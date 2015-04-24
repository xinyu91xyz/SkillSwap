//
//  EditProfileViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 4/23/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "EditProfileViewController.h"
#import <Parse/Parse.h>
#import "ProfileTableViewController.h"
#import "ProfileTableViewCell.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Disable automatic adjustment, as we want to occupy all screen real estate
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

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
- (IBAction)backBtn:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)updateNameBtn:(id)sender {
    
    if (![self.updateName.text isEqualToString:@""]) {
            
            // update user real name
        PFQuery *userrealname = [PFUser query];
        [userrealname whereKey:@"objectId" equalTo:[PFUser currentUser]];
        
        [userrealname getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
        {
            PFUser *currentUser = [PFUser currentUser];
            [currentUser setObject:self.updateName.text forKey:@"realName"];
            [[PFUser currentUser] saveInBackground];
            self.showName.text = [currentUser objectForKey:@"realName"];

        }];

    }
    
}

- (IBAction)updateTitleBtn:(id)sender {
    
    if (![self.updateTitle.text isEqualToString:@""]) {
        
        // update user real name
        PFQuery *userrealname = [PFUser query];
        [userrealname whereKey:@"objectId" equalTo:[PFUser currentUser]];
        
        [userrealname getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         {
             PFUser *currentUser = [PFUser currentUser];
             [currentUser setObject:self.updateTitle.text forKey:@"userTitle"];
             [[PFUser currentUser] saveInBackground];
             self.showTitle.text = [currentUser objectForKey:@"userTitle"];
             
         }];
        
    }
}

- (IBAction)updateMajorBtn:(id)sender {
    
    if (![self.updateMajor.text isEqualToString:@""]) {
        
        // update user real name
        PFQuery *userrealname = [PFUser query];
        [userrealname whereKey:@"objectId" equalTo:[PFUser currentUser]];
        
        [userrealname getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         {
             PFUser *currentUser = [PFUser currentUser];
             [currentUser setObject:self.updateMajor.text forKey:@"major"];
             [[PFUser currentUser] saveInBackground];
             self.showMajor.text = [currentUser objectForKey:@"major"];
             
         }];
        
    }
}


- (IBAction)updateEnrollYearBtn:(id)sender {
    
    if (![self.updateEnrollYear.text isEqualToString:@""]) {
        
        // update user real name
        PFQuery *userrealname = [PFUser query];
        [userrealname whereKey:@"objectId" equalTo:[PFUser currentUser]];
        
        [userrealname getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         {
             PFUser *currentUser = [PFUser currentUser];
             [currentUser setObject:self.updateEnrollYear.text forKey:@"enrollYear"];
             [[PFUser currentUser] saveInBackground];
             self.showEnrollYear.text = [currentUser objectForKey:@"enrollYear"];
             
         }];
        
    }
    
}


@end
