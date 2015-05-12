//
//  UpdateEmailViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "UpdateEmailViewController.h"
#import <Parse/Parse.h>

@interface UpdateEmailViewController () <UITextFieldDelegate>

@end

@implementation UpdateEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.emailTextField becomeFirstResponder];
    self.emailTextField.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (![self validateEmail:self.emailTextField.text]) {
        [self.emailTextField becomeFirstResponder];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please Enter Valid Email"message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    else {
        if (![self.emailTextField.text isEqualToString:@""]) {
            
            // update user real name
            PFQuery *useremail = [PFUser query];
            [useremail whereKey:@"objectId" equalTo:[PFUser currentUser]];
            
            [useremail getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
             {
                 PFUser *currentUser = [PFUser currentUser];
                 [currentUser setObject:self.emailTextField.text forKey:@"myEmail"];
                 [[PFUser currentUser] saveInBackground];
                 //             self.showMajor.text = [currentUser objectForKey:@"major"];
                 
             }];
        }
    }
    return true;
}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
