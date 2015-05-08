//
//  BuildAboutMeViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "BuildAboutMeViewController.h"

@interface BuildAboutMeViewController ()

@end

@implementation BuildAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.createAboutMe resignFirstResponder];
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

- (IBAction)saveAboutMe:(id)sender {
    
    if (![self.createAboutMe.text isEqualToString:@""]) {
        
        // update user real name
        PFQuery *userrealname = [PFUser query];
        [userrealname whereKey:@"objectId" equalTo:[PFUser currentUser]];
        
        [userrealname getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         {
             PFUser *currentUser = [PFUser currentUser];
             [currentUser setObject:self.createAboutMe.text forKey:@"userTitle"];
             [[PFUser currentUser] saveInBackground];
             
         }];
    }
    
}
@end
