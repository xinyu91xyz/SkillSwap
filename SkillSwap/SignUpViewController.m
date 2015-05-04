//
//  PAWNewUserViewController.m
//  Anywall
//
//  Copyright (c) 2014 Parse Inc. All rights reserved.
//

#import "SignUpViewController.h"
#import "BuildProfileViewController.h"

#import <Parse/Parse.h>


@interface SignUpViewController () <UITextFieldDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIButton *createAccountButton;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) IBOutlet UIImageView *logoImageView;

@property (nonatomic, assign) CGFloat iconImageViewOriginalY;
@property (nonatomic, assign) CGFloat iconLogoOffsetY;

@end

@implementation SignUpViewController

#pragma mark -
#pragma mark Init

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Disable automatic adjustment, as we want to occupy all screen real estate
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self.scrollView setScrollEnabled:YES];
    // For dismissing keyboard
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self registerForKeyboardNotifications];

    // Save original y position and offsets for floating views
    self.iconImageViewOriginalY = self.iconImageView.frame.origin.y;
    self.iconLogoOffsetY = self.logoImageView.frame.origin.y - self.iconImageView.frame.origin.y;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    [self.usernameField becomeFirstResponder];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.usernameField becomeFirstResponder];
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    }
    if (textField == self.passwordField) {
        [self.passwordAgainField becomeFirstResponder];
    }
    if (textField == self.passwordAgainField) {
        [self.passwordAgainField resignFirstResponder];
//        [self processFieldEntries];
    }
    if (textField == self.emailField) {
        [self.emailField becomeFirstResponder];
        [self processFieldEntries];
    }

    return YES;
}

#pragma mark -
#pragma mark IBActions

- (IBAction)createAccountPressed:(id)sender {
    [self dismissKeyboard];
    [self processFieldEntries];
    // build profile and skills first
//    [self presentBuildProfileViewController];
}

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissKeyboard];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentBuildProfileViewController {
    BuildProfileViewController *viewController = [[BuildProfileViewController alloc] initWithNibName:nil bundle:nil];
//    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:NULL];
}


//- (void)buildProfileViewControllerDidBuild:(BuildProfileViewController *)controller {
//    //    [self presentWallViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:NULL];
//    
//}

#pragma mark -
#pragma mark Sign Up

- (void)processFieldEntries {
    // Check that we have a non-zero username and passwords.
    // Compare password and passwordAgain for equality
    // Throw up a dialog that tells them what they did wrong if they did it wrong.

    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    NSString *passwordAgain = self.passwordAgainField.text;
    NSString *email = self.emailField.text;
    NSString *errorText = @"Please ";
    NSString *usernameBlankText = @"enter a username";
    NSString *passwordBlankText = @"enter a password";
    NSString *joinText = @", and ";
//    NSString *joinText2 = @", ";
    NSString *passwordMismatchText = @"enter the same password twice";
    NSString *emailBlankText = @"enter an email";

    BOOL textError = NO;

    // Messaging nil will return 0, so these checks implicitly check for nil text.
    if (username.length == 0 || password.length == 0 || passwordAgain.length == 0 || email.length == 0) {
        textError = YES;

        // Set up the keyboard for the first field missing input:
        if (email.length == 0) {
            [self.emailField becomeFirstResponder];
        }
        
        if (passwordAgain.length == 0) {
            [self.passwordAgainField becomeFirstResponder];
        }
        if (password.length == 0) {
            [self.passwordField becomeFirstResponder];
        }
        if (username.length == 0) {
            [self.usernameField becomeFirstResponder];
        }

        if (username.length == 0) {
            errorText = [errorText stringByAppendingString:usernameBlankText];
        }

        if (password.length == 0 || passwordAgain.length == 0) {
            if (username.length == 0) { // We need some joining text in the error:
                errorText = [errorText stringByAppendingString:joinText];
            }
            errorText = [errorText stringByAppendingString:passwordBlankText];
        }
        
        if (email.length == 0) {
            if (username.length == 0 || password.length == 0 || passwordAgain.length == 0) {
                errorText = [errorText stringByAppendingString:joinText];
            }
            errorText = [errorText stringByAppendingString:emailBlankText];
        }
        
    } else if ([password compare:passwordAgain] != NSOrderedSame) {
        // We have non-zero strings.
        // Check for equal password strings.
        textError = YES;
        errorText = [errorText stringByAppendingString:passwordMismatchText];
        [self.passwordField becomeFirstResponder];
    }

    if (textError) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorText message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        return;
    }

//    // Everything looks good; try to log in.
//    PAWActivityView *activityView = [[PAWActivityView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height)];
//    UILabel *label = activityView.label;
//    label.text = @"Signing You Up";
//    label.font = [UIFont boldSystemFontOfSize:20.f];
//    [activityView.activityIndicator startAnimating];
//    [activityView layoutSubviews];
//
//    [self.view addSubview:activityView];

    // Call into an object somewhere that has code for setting up a user.
    // The app delegate cares about this, but so do a lot of other objects.
    // For now, do this inline.

    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    user.email = email;
    
    NSLog(@"A PFUser is Initiated");
    NSLog(@"%@",user);
    
    PFObject *userProfile = [PFObject objectWithClassName:@"UserProfile"];
    userProfile[@"userName"] = @"testwodidie";
    userProfile[@"userId"] = user;
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error userInfo][@"error"]
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
            [alertView show];
//            [activityView.activityIndicator stopAnimating];
//            [activityView removeFromSuperview];
            // Bring the keyboard back up, because they'll probably need to change something.
            [self.usernameField becomeFirstResponder];
            return;
        }

        
        
        [userProfile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSLog(@"user Profile is not saved");
                //            NSLog(@"Couldn't save!");
                //            NSLog(@"%@", error);
                //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error userInfo][@"error"]
                //                                                                message:nil
                //                                                               delegate:self
                //                                                      cancelButtonTitle:nil
                //                                                    otherButtonTitles:@"Ok", nil];
                //            [alertView show];
                return;
            }
            if (succeeded) {
                NSLog(@"Successfully saved!");
                NSLog(@"%@", userProfile);
            } else {
                NSLog(@"Failed to save.");
            }
        }];

        [self presentBuildProfileViewController];
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate newUserViewControllerDidSignup:self];
    }];
}

#pragma mark -
#pragma mark Keyboard

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:endFrame fromView:self.view.window];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

//    CGFloat scrollViewOffsetY = (keyboardFrame.size.height -
//                                 (CGRectGetHeight(self.view.bounds) -
//                                  CGRectGetMaxY(self.createAccountButton.frame) - 10.0f));
    
    CGFloat scrollViewOffsetY = (CGRectGetHeight(keyboardFrame) -
                                 (CGRectGetHeight(self.view.bounds) -
                                  CGRectGetMaxY(self.createAccountButton.frame) + 120.0f));
    
//    CGRectGetHeight(keyboardFrame) -
//    (CGRectGetMaxY(self.view.bounds) -
//     CGRectGetMaxY(self.loginButton.frame) - 10.0f)
    // Check if scrolling needed
    if (scrollViewOffsetY < 0) {
        return;
    }

    // Fix the icon and logo if necessary
    CGFloat bottomViewToCheck = self.iconImageView.frame.origin.y + self.iconImageView.frame.size.height;
    // Only if the logo is party visible (happens for 3.5-inch device)
    if (scrollViewOffsetY > bottomViewToCheck) {
        return;
    }
    CGFloat yIconOffset = MAX(scrollViewOffsetY, self.iconImageViewOriginalY);
    __block CGRect iconFrame = self.iconImageView.frame;

    [UIView animateWithDuration:duration
                          delay:0.0
                        options:curve << 16 | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.scrollView setContentOffset:CGPointMake(0.0f, scrollViewOffsetY) animated:NO];

                         if (yIconOffset != iconFrame.origin.y) {
                             // Move icon
                             iconFrame.origin.y = yIconOffset + 20.0f;
                             self.iconImageView.frame = iconFrame;

                             // Move logo with respect to the icon and
                             // decrease distance between them slightly
                             // to avoid overlap with the first text field.
                             CGRect logoFrame = self.logoImageView.frame;
                             logoFrame.origin.y = CGRectGetMinY(iconFrame) + self.iconLogoOffsetY - 7.0f;
                             self.logoImageView.frame = logoFrame;
                         }
                     }
                     completion:nil];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:endFrame fromView:self.view.window];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

    [UIView animateWithDuration:duration
                          delay:0.0
                        options:curve << 16 | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.scrollView setContentOffset:CGPointZero animated:NO];

                         if (self.iconImageView.frame.origin.y != self.iconImageViewOriginalY) {
                             CGRect iconFrame = self.iconImageView.frame;
                             iconFrame.origin.y = self.iconImageViewOriginalY;
                             self.iconImageView.frame = iconFrame;

                             CGRect logoFrame = self.logoImageView.frame;
                             logoFrame.origin.y = self.iconImageViewOriginalY + self.iconLogoOffsetY;
                             self.logoImageView.frame = logoFrame;
                         }
                     }
                     completion:nil];
}

@end
