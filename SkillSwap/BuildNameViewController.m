//
//  BuildNameViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/4/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "BuildNameViewController.h"


@interface BuildNameViewController ()

@end

@implementation BuildNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.createName resignFirstResponder];
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

//- (IBAction)donePressed:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (IBAction)saveName:(id)sender {
    if (![self.createName.text isEqualToString:@""]) {
        
        // update user real name
        PFQuery *userrealname = [PFUser query];
        [userrealname whereKey:@"objectId" equalTo:[PFUser currentUser]];
        
        [userrealname getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         {
             PFUser *currentUser = [PFUser currentUser];
             [currentUser setObject:self.createName.text forKey:@"realName"];
             [[PFUser currentUser] saveInBackground];
             
         }];
    }
}



@end
