//
//  EventBaseTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/27/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "EventBaseTableViewController.h"

NSString *const kCellIdentifier = @"cellID";
NSString *const kTableCellNibName = @"EventCell";

@interface EventBaseTableViewController ()

@end

@implementation EventBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:kTableCellNibName bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureCell:(EventCell *)cell forPFObject:(PFObject *)object {
    cell.eventTitleLabel.text = [object objectForKey:@"eventName"];
    cell.eventDescLabel.text = [object objectForKey:@"eventDesc"];
    PFFile *file = [object objectForKey:@"eventImg"];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.eventImage.image = image;
        }
    }];
}


@end
