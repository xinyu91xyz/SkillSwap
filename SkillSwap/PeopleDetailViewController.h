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
#import "PeopleTableViewController.h"
@interface PeopleDetailViewController : UIViewController <MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (weak, nonatomic) PFUser *object;
@property (strong, nonatomic) NSMutableArray *knowRes;
@property (strong, nonatomic) NSMutableArray *wantRes;

@property(nonatomic, retain) UIButton *sendMessage;
-(IBAction)sendMessage:(id)sender;
@end