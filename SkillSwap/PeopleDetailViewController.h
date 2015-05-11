//
//  PeopleDetailViewController.h
//  SkillSwap
//
//  Created by Xiao Tong on 4/17/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MessageUI/MessageUI.h>
@interface PeopleDetailViewController : UIViewController <MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) PFObject *object;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *major;
@property (weak, nonatomic) IBOutlet UIImageView *userimage;
@property (weak, nonatomic) IBOutlet UILabel *skills;
@property (weak, nonatomic) IBOutlet UILabel *wants;
@property(nonatomic, retain) UIButton *sendMessage;
-(IBAction)sendMessage:(id)sender;
@end