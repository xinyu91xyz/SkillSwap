//
//  PeopleResultsTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 5/13/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "PeopleResultsTableViewController.h"
#import "PeopleCell.h"

@interface PeopleResultsTableViewController ()

@end

@implementation PeopleResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredPeople.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PeopleCell *cell = (PeopleCell *)[self.tableView dequeueReusableCellWithIdentifier:@"peopleCellId"];

    NSString *userId = self.filteredPeople[indexPath.row];
    
    [self configureDetailedCell:cell forUser:userId];
    
    return cell;
}





@end
