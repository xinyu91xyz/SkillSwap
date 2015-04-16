//
//  EventTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/6/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "EventTableViewController.h"
#import <Parse/Parse.h>
<<<<<<< Updated upstream
#import "EventTableViewCell.h"
#import "EventDetailViewController.h"
=======
<<<<<<< HEAD

=======
#import "EventTableViewCell.h"
#import "EventDetailViewController.h"
>>>>>>> origin/ChenZhu
>>>>>>> Stashed changes
@implementation EventTableViewController

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
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
        self.objectsPerPage = 25;
    }
    return self;
}

- (PFQuery *) queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    
    [query orderByAscending:@"eventDate"];
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
