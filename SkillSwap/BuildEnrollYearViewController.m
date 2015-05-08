//
//  BuildEnrollYearViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "BuildEnrollYearViewController.h"

@interface BuildEnrollYearViewController ()

@end

@implementation BuildEnrollYearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.createEnrollYear resignFirstResponder];
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

- (IBAction)saveEnrollYear:(id)sender {
    if (![self.createEnrollYear.text isEqualToString:@""]) {
        
        // update user real name
        PFQuery *userrealname = [PFUser query];
        [userrealname whereKey:@"objectId" equalTo:[PFUser currentUser]];
        
        [userrealname getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         {
             PFUser *currentUser = [PFUser currentUser];
             [currentUser setObject:self.createEnrollYear.text forKey:@"enrollYear"];
             [[PFUser currentUser] saveInBackground];
             
         }];
    }
    
}
@end
