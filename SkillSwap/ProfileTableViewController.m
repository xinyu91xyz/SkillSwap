//
//  ProfileTableViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 4/15/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "ProfileTableViewController.h"
#import <Parse/Parse.h>

@interface ProfileTableViewController () {
    NSString *skill_type;
    NSString *current_skill;
    NSMutableArray *skill_known;
    NSMutableArray *skill_tolearn;
    NSArray *skill_titles;
    NSArray *skill_index_titles;
    NSDictionary *skill_dict;
    
}

@end


@implementation ProfileTableViewController

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
        
        
        skill_known = [[NSMutableArray alloc] init];
        skill_tolearn = [[NSMutableArray alloc] init];
        
        skill_dict = @{@"known" : skill_known,
                       @"tolearn" : skill_tolearn};
        skill_titles = [[skill_dict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        skill_index_titles = @[@"userProfile", @"known", @"tolearn"];
        
//        NSLog(@"run?");
//        
//        
//        NSMutableArray *hehe = [[NSMutableArray alloc] init];
//        
//        [hehe addObject:@"as"];
//        [hehe addObject:@"bs"];
//        for (NSString *st in hehe) {
//            NSLog(@"%@",st);
//        }
//        NSLog(@"%lu",(unsigned long)[hehe count]);
//        NSLog(@"run!");
    }
    
    return self;
}

- (void)objectsDidLoad:(PFUI_NULLABLE NSError *)error {
    [super objectsDidLoad:error];
    
    for (PFObject *object in self.objects) {

        if ([[object objectForKey:@"skillType"] isEqualToString:@"known"]){

            [skill_known addObject:object];
       
        } else {
            [skill_tolearn addObject:object];

        }
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (PFObject *object in skill_known) {
        NSLog(@"%@",[object objectForKey:@"skillName"]);
    }
    for (PFObject *object in skill_tolearn) {
        NSLog(@"%@",[object objectForKey:@"skillName"]);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (PFQuery *) queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:@"Skills"];
//    [query orderByAscending:@"eventDate"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"ProfileCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    
    
    
    
    
    NSString *sectionTitle = [object objectForKey:@"skillType"];
    NSArray *sectionSkills = [skill_dict objectForKey:sectionTitle];
    
    NSString *skill = [sectionSkills objectAtIndex:indexPath.row];
    cell.textLabel.text =  skill;

   
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowProfileDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        //        Observation *selectedObservation = self.survey.observations[indexPath.row];
        //        ObservationEditorViewController *destination = segue.destinationViewController;
        //        destination.theObservation = selectedObservation;
    }

}

//- (void)printKnownSkills {
//    NSLog(@"skill_known, %@", skill_known);
//}
//
//- (void)printToLearnSkills {
//    NSLog(@"skill_tolearn, %@", skill_tolearn);
//}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *sectionSkills;
    switch (section)
    {
        case 0:
            sectionSkills = [[NSArray alloc] init];
            break;
        case 1:
            sectionSkills= [skill_dict objectForKey:@"known"];
            break;
        case 2:
            sectionSkills= [skill_dict objectForKey:@"tolearn"];
            break;
        default:
            sectionSkills = [[NSArray alloc] init];
            break;
    }
    
    return [sectionSkills count];
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //  return animalSectionTitles;
    return skill_index_titles;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"userProfile";
            break;
        case 1:
            sectionName = @"known";
            break;
        case 2:
            sectionName = @"tolearn";
            break;
        default:
            sectionName = @"default";
            break;
    }
    return sectionName;
}

@end
