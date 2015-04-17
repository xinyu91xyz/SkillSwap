//
//  PeopleTableViewController.h
//  SkillSwap
//
//  Created by Xiao Tong on 4/15/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@interface PeopleTableViewController : PFQueryTableViewController
@property (nonatomic) NSArray *users;

@end
