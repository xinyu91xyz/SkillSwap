//
//  ProfileViewController.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 4/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;


//- (PFQuery *) queryForTable;

@end
