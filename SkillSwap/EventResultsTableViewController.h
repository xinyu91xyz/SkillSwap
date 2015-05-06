//
//  EventResultsTableViewController.h
//  SkillSwap
//
//  Created by Chen Zhu on 4/27/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "EventBaseTableViewController.h"

@interface EventResultsTableViewController : EventBaseTableViewController

@property (nonatomic, strong) NSArray *filteredEvents;
@property (nonatomic, strong) NSMutableArray *myEvents;

@end
