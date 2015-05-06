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

- (void)configureCell:(EventCell *)cell forPFObject:(PFObject *)object withFlag:(BOOL)isInMyEvent {
    cell.eventTitleLabel.text = [object objectForKey:@"eventName"];
//    cell.eventHostLabel.text = [object objectForKey:@"eventHost"];
    cell.eventLocationLabel.text = [object objectForKey:@"eventLocation"];
    cell.event = object;
    UIImage *btnImg = [UIImage imageNamed:@"heartEmpty.png"];
    [cell.likeButton setImage:btnImg forState:UIControlStateNormal];
    
    PFUser *currentUser = [PFUser currentUser];
    PFRelation *relation = [currentUser relationForKey:@"myEvent"];
    
    if (isInMyEvent) {
        UIImage *btnImage = [UIImage imageNamed:@"heartFilled.png"];
        [cell.likeButton setImage:btnImage forState:UIControlStateNormal];
        cell.user = [PFUser currentUser];
    }

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM dd hh:mma"];
    NSString *date = [dateFormat stringFromDate:[object objectForKey:@"eventDate"]];
    cell.eventCalendarLabel.text = date;
    
    PFFile *file = [object objectForKey:@"eventImg"];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.eventImage.image = image;
        }
    }];
}


@end
