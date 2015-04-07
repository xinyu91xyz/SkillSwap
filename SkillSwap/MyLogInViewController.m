//
//  MyLogInViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "MyLogInViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MyLogInViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end

@implementation MyLogInViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBG.png"]]];
    
    // !!!!!!!!!!!!!TO CHANGE TO OUR LOGO
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo.png"]]];
    
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"Signup.png"] forState:UIControlStateNormal];
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"SignupDown.png"] forState:UIControlStateHighlighted];
    [self.logInView.signUpButton setTitle:@"" forState:UIControlStateNormal];
    [self.logInView.signUpButton setTitle:@"" forState:UIControlStateHighlighted];
    
    // ADDED - need customized logInButton for logInView
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"Signup.png"] forState:UIControlStateNormal];
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"SignupDown.png"] forState:UIControlStateHighlighted];
    
    [self.logInView.logInButton setTitle:@"" forState:UIControlStateNormal];
    [self.logInView.logInButton setTitle:@"" forState:UIControlStateHighlighted];
    
    // Add login field background
    fieldsBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginFieldBG.png"]];
    [self.logInView addSubview:self.fieldsBackground];
    [self.logInView sendSubviewToBack:self.fieldsBackground];
    
    // Remove text shadow
    CALayer *layer = self.logInView.usernameField.layer;
    layer.shadowOpacity = 0.0f;
    layer = self.logInView.passwordField.layer;
    layer.shadowOpacity = 0.0f;
    
    // Set field text color
    [self.logInView.usernameField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
    [self.logInView.passwordField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Set frame for elements
    CGRect fieldFrame = self.logInView.frame;
    
    [self.logInView.dismissButton setFrame:CGRectMake(fieldFrame.origin.x, fieldFrame.origin.y, 0, 0)];
    [self.fieldsBackground setFrame:CGRectMake(fieldFrame.origin.x, fieldFrame.origin.y, 0, 0)];
    
//    [self.logInView.logo setFrame:CGRectMake(fieldFrame.origin.x + fieldFrame.size.width * 0.1,
//                                              fieldFrame.origin.y + fieldFrame.size.height * 0.05,
//                                              fieldFrame.size.width * 0.8,
//                                              fieldFrame.size.height * 0.2)];
    
    [self.logInView.logo setFrame:CGRectMake(fieldFrame.origin.x,
                                             fieldFrame.origin.y + fieldFrame.size.height * 0.05,
                                             fieldFrame.size.width,
                                             fieldFrame.size.height * 0.3)];
    
    [self.logInView.usernameField setFrame:CGRectMake(fieldFrame.origin.x + fieldFrame.size.width * 0.1,
                                                       fieldFrame.origin.y + fieldFrame.size.height * 0.4,
                                                       fieldFrame.size.width * 0.8,
                                                       fieldFrame.size.height * 0.08)];
    
    [self.logInView.passwordField setFrame:CGRectMake(fieldFrame.origin.x + fieldFrame.size.width * 0.1,
                                                       fieldFrame.origin.y + fieldFrame.size.height * 0.48,
                                                       fieldFrame.size.width * 0.8,
                                                       fieldFrame.size.height * 0.08)];
    
    [self.logInView.signUpButton setFrame:CGRectMake(fieldFrame.origin.x + fieldFrame.size.width * 0.15,
                                                     fieldFrame.origin.y + fieldFrame.size.height * 0.62,
                                                     fieldFrame.size.width * 0.7,
                                                     fieldFrame.size.height * 0.08)];
    
    [self.logInView.logInButton setFrame:CGRectMake(fieldFrame.origin.x + fieldFrame.size.width * 0.15,
                                                    fieldFrame.origin.y + fieldFrame.size.height * 0.75,
                                                    fieldFrame.size.width * 0.7,
                                                    fieldFrame.size.height * 0.08)];    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
