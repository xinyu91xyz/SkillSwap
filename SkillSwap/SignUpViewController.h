//
//  PAWNewUserViewController.h
//  Anywall
//
//  Copyright (c) 2014 Parse Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignUpViewController;

@protocol SignUpViewControllerDelegate <NSObject>

- (void)newUserViewControllerDidSignup:(SignUpViewController *)controller;

@end

@interface SignUpViewController : UIViewController

@property (nonatomic, weak) id<SignUpViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UITextField *usernameField;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) IBOutlet UITextField *passwordAgainField;

@end
