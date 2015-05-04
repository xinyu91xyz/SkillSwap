//
//  ProfileTableViewController.h
//  SkillSwap
//
//  Created by Chen Zhu on 4/17/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface ProfileTableViewController : UITableViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settings;
- (IBAction)settings:(id)sender;


@end
