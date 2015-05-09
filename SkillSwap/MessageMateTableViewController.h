//
//  MessageMateTableViewController.h
//  SkillSwap
//
//  Created by Xiao Tong on 5/2/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "ChatDialogViewController.h"

@interface MessageMateTableViewController : UITableViewController <UITableViewDataSource>
@property (strong, nonatomic) ChatDialogViewController *activeDialogViewController;
@property(strong, nonatomic) NSString *myUserId;
@property (strong, nonatomic) NSMutableArray *chatMatesArray;
@end
