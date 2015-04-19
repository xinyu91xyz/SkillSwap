//
//  EventTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/6/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "EventTableViewController.h"
#import <Parse/Parse.h>
#import "EventTableViewCell.h"
#import "EventDetailViewController.h"


@implementation EventTableViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1]}];
    self.navigationController.navigationBar.translucent = NO;
    
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1];
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"text";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 10;
        
        NSLog(@"run");

        
    }
    return self;
}

//- (id)initWithStyle:(UITableViewStyle)style{
//    self = [super initWithStyle:style];
//    if (self) {
//
//        
//        // The key of the PFObject to display in the label of the default cell style
//        self.textKey = @"text";
//        
//        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
//        // self.imageKey = @"image";
//        
//        // Whether the built-in pull-to-refresh is enabled
//        self.pullToRefreshEnabled = YES;
//        
//        // Whether the built-in pagination is enabled
//        self.paginationEnabled = YES;
//        
//        // The number of objects to show per page
//        self.objectsPerPage = 25;
//        
//        NSLog(@"run");
//    }
//    return self;
//}

- (PFQuery *) queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    
    [query orderByAscending:@"evenDate"];
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"EventCell";
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[EventTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.eventTitleLabel.text = [object objectForKey:@"eventName"];
    cell.eventDescLabel.text = [object objectForKey:@"eventDesc"];
    
    PFFile *file = [object objectForKey:@"eventImg"];
    
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.eventImage.image = image;
            // image can now be set on a UIImageView
        }
    }];

    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowEventDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        PFObject *selectedObject = self.objects[indexPath.row];
        EventDetailViewController *destiation = segue.destinationViewController;
        destiation.object = selectedObject;
    }
    
}

@end
