//
//  EventTableViewController.h
//  SkillSwap
//
//  Created by Chen Zhu on 4/6/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@interface EventTableViewController : PFQueryTableViewController

@property (nonatomic, strong) UISearchController *searchController;

// for state restoration
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

@end
