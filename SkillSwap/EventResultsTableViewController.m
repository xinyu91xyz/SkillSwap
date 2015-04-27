//
//  EventResultsTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/27/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "EventResultsTableViewController.h"
#import "EventCell.h"

@interface EventResultsTableViewController ()

@end

@implementation EventResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredEvents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventCell *cell = (EventCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    PFObject *event = self.filteredEvents[indexPath.row];
    [self configureCell:cell forPFObject:event];
    return cell;
}

@end
