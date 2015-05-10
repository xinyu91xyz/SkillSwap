//
//  SettingsTableViewController.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SettingsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *realName;
@property (weak, nonatomic) IBOutlet UILabel *emailAddress;
@property (weak, nonatomic) IBOutlet UILabel *schoolName;
@property (weak, nonatomic) IBOutlet UILabel *majorName;
@property (weak, nonatomic) IBOutlet UILabel *enrollYear;



@end
