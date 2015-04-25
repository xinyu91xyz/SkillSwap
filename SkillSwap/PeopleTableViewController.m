//
//  PeopleTableViewController.m
//  SkillSwap
//
//  Created by Xiao Tong on 4/15/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "PeopleTableViewController.h"
#import <Parse/Parse.h>

@implementation PeopleTableViewController

-(id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if(self) {
        self.parseClassName = @"_User";
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

-(void)viewWillAppear:(BOOL)animated {
    PFQuery *query = [PFUser query];
       //[query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            self.users = objects;
            [self.tableView reloadData];
        }
        NSLog(@"objects");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1];
//    [self.navigationController.navigationBar
//     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];

    self.navigationController.navigationBar.translucent = NO;
    
//    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1];
    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];

//    self.tabBarController.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"myImage.png"];
    

}

//- (PFQuery *) queryForTable {
//    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
//    [query orderByAscending:@"createdAt"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if(!error) {
//         
//           [self.tableView reloadData];
//        }
//    }];
//    return query;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PeopleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    PFUser *user = self.users[indexPath.row];
    cell.textLabel.text = user.username;
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showPeopleDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        //        Observation *selectedObservation = self.survey.observations[indexPath.row];
        //        ObservationEditorViewController *destination = segue.destinationViewController;
        //        destination.theObservation = selectedObservation;
    }
    
}

@end
