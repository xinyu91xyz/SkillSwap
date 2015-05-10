//
//  UpdateNameViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "UpdateNameViewController.h"
#import <Parse/Parse.h>

@interface UpdateNameViewController () <UITextFieldDelegate>

@end

@implementation UpdateNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextField.delegate = self;
    [self.nameTextField becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.nameTextField.text.length == 0) {
        [self.nameTextField becomeFirstResponder];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Username cannot be empty"message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    else {
//        // update user real name
//        PFQuery *userrealname = [PFUser query];
//        [userrealname whereKey:@"objectId" equalTo:[PFUser currentUser]];
//        
//        [userrealname getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
//         {
//             PFUser *currentUser = [PFUser currentUser];
//             [currentUser setObject:self.nameTextField.text forKey:@"realName"];
//             [[PFUser currentUser] saveInBackground];
//             
//         }];
        
    }
    
    
    return true;
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
