//
//  PeopleDetailViewController.h
//  SkillSwap
//
//  Created by Xiao Tong on 4/17/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PeopleDetailViewController : UIViewController

@property(nonatomic, retain) UIButton *sendMessage;
-(IBAction)sendMessage:(id)sender;
@end
