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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.objects count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PeopleTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"PeopleCell" forIndexPath:indexPath];
    
    PFUser *user = self.users[indexPath.row];
    
    PFFile *file = [user objectForKey:@"userImg"];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(!error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.userimage.image = image;
        }
    }];
   
    cell.username.text = [user objectForKey:@"realName"];
    cell.major.text = [user objectForKey:@"major"];
    PFRelation *knownRelation = [user relationForKey:@"knownSkills"];
    NSMutableArray *knowRes = [[NSMutableArray alloc] initWithArray:[[knownRelation query] findObjects]];
    cell.skills.text = [knowRes componentsJoinedByString:@"\n"];
    PFRelation *toLearnRelation = [[PFUser currentUser] relationForKey:@"toLearnSkills"];
    NSMutableArray *wantRes = [[NSMutableArray alloc] initWithArray:[[toLearnRelation query] findObjects]];
    cell.wants.text = [wantRes componentsJoinedByString:@"\n"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[self.tableView setBounces:NO];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showPeopleDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        //        Observation *selectedObservation = self.survey.observations[indexPath.row];
        //        ObservationEditorViewController *destination = segue.destinationViewController;
        //        destination.theObservation = selectedObservation;
    }
    
}

@end
