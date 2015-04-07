//
//  TabBarController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/1/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "TabBarController.h"
#import "MyLogInViewController.h"
#import "MySignUpViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    if (![PFUser currentUser]) {
//        // Customize the Log In View Controller
//        MyLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
//        logInViewController.delegate = self;
//        
//        logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsSignUpButton | PFLogInFieldsLogInButton;
//        
//        // Customize the Sign Up View Controller
//        MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
//        signUpViewController.delegate = self;
//        signUpViewController.fields = PFSignUpFieldsDefault | PFSignUpFieldsAdditional;
//        logInViewController.signUpController = signUpViewController;
//        
//        // Present Log In View Controller
//        [self presentViewController:logInViewController animated:YES completion:NULL];
//    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    if (username && password && username.length && password.length) {
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO;
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
}


#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) {
            informationComplete = NO;
            break;
        }
    }
    
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

// Don't Delete - Chen Zhu
//#pragma mark - ()
//
//- (IBAction)logOutButtonTapAction:(id)sender {
//    [PFUser logOut];
//    
//    MyLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
//    logInViewController.delegate = self;
//    logInViewController.facebookPermissions = @[@"friends_about_me"];
//    logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsSignUpButton | PFLogInFieldsLogInButton;
//    
//    // Customize the Sign Up View Controller
//    MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
//    signUpViewController.delegate = self;
//    signUpViewController.fields = PFSignUpFieldsDefault | PFSignUpFieldsAdditional;
//    logInViewController.signUpController = signUpViewController;
//    
//    // Present Log In View Controller
//    [self presentViewController:logInViewController animated:YES completion:NULL];
//    
//    //[self.navigationController popViewControllerAnimated:YES];
//}

@end
