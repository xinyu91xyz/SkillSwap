//
//  PeopleTableViewController.m
//  SkillSwap
//
//  Created by Xiao Tong on 4/15/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "PeopleTableViewController.h"
#import "PeopleDetailViewController.h"
#import <Parse/Parse.h>

@implementation PeopleTableViewController
NSMutableArray *knowRes;
NSMutableArray *wantRes;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.users count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PeopleCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"PeopleCellId" forIndexPath:indexPath];
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
    NSString *userId = [user objectId];

    PFQuery *query1 = [PFQuery queryWithClassName:@"UserSkill"];
    [query1 whereKey:@"userId" equalTo:userId];
    [query1 whereKey:@"skillType" equalTo:@"known"];
    [query1 selectKeys:@[@"skillName"]];
    knowRes = [[NSMutableArray alloc] initWithArray:[query1 findObjects]];
    NSInteger knowCount = [knowRes count];
    NSMutableString *knowStr = [NSMutableString string];
    for(int i = 0; i < knowCount-1; i++) {
        NSString *tmp = knowRes[i][@"skillName"];
        [knowStr appendString:tmp];
        [knowStr appendString:@","];
    }
    [knowStr appendString:knowRes[knowCount-1][@"skillName"]];
    cell.skills.text = knowStr;
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"UserSkill"];
    [query2 whereKey:@"userId" equalTo:userId];
    [query2 whereKey:@"skillType" equalTo:@"toLearn"];
    [query2 selectKeys:@[@"skillName"]];
    wantRes = [[NSMutableArray alloc] initWithArray:[query2 findObjects]];
    NSInteger wantCount = [wantRes count];
    NSMutableString *wantStr = [NSMutableString string];
    for(int i = 0; i < wantCount-1; i++) {
        NSString *tmp = wantRes[i][@"skillName"];
        [wantStr appendString:tmp];
        [wantStr appendString:@","];
    }
    [wantStr appendString:wantRes[wantCount-1][@"skillName"]];
    cell.wants.text = wantStr;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFUser *selectedUser = self.users[indexPath.row];
    PeopleDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PeopleDetailViewController"];
    detailViewController.title = @"People";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    detailViewController.object = selectedUser;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

-(void)viewWillAppear:(BOOL)animated {
    PFQuery *query = [PFUser query];
    //[query orderByAscending:@"createdAt"];
    NSString *myUserId = [PFUser currentUser][@"username"];
    [query whereKey:@"username" notEqualTo:myUserId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            self.users = objects;
            [self.tableView reloadData];
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PeopleCell class]) bundle:nil] forCellReuseIdentifier:@"PeopleCellId"];
    
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
