//
//  ProfileTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/17/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "ProfileTableViewController.h"
#import <Parse/Parse.h>

@interface ProfileTableViewController () {
    NSDictionary *animals;
    NSArray *animalSectionTitles;
    NSArray *animalIndexTitles;
    
    NSArray *knownSkills;
    NSArray *toLearnSkills;
    NSString *userEmail;
    NSString *userRealName;
}
@end

@implementation ProfileTableViewController

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
//        PFQuery *queryUser = [PFQuery queryWithClassName:@"User"];
//        [queryUser whereKey:@"objectId" equalTo:[PFUser currentUser]];
//        [queryUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            if (!error) {
//                PFObject *user= objects[0];
//                userEmail = user[@"email"];
//                userRealName = user[@"realName"];
//            } else {
//                
//            }
//        }];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // animals = @[@"Bear", @"Black Swan", @"Buffalo", @"Camel", @"Cockatoo", @"Dog", @"Donkey", @"Emu", @"Giraffe", @"Greater Rhea", @"Hippopotamus", @"Horse", @"Koala", @"Lion", @"Llama", @"Manatus", @"Meerkat", @"Panda", @"Peacock", @"Pig", @"Platypus", @"Polar Bear", @"Rhinoceros", @"Seagull", @"Tasmania Devil", @"Whale", @"Whale Shark", @"Wombat"];
    
    animals = @{@"B" : @[@"Bear", @"Black Swan", @"Buffalo"],
                @"C" : @[@"Camel", @"Cockatoo"],
                @"D" : @[@"Dog", @"Donkey"],
                @"E" : @[@"Emu"],
                @"G" : @[@"Giraffe", @"Greater Rhea"],
                @"H" : @[@"Hippopotamus", @"Horse"],
                @"K" : @[@"Koala"],
                @"L" : @[@"Lion", @"Llama"],
                @"M" : @[@"Manatus", @"Meerkat"],
                @"P" : @[@"Panda", @"Peacock", @"Pig", @"Platypus", @"Polar Bear"],
                @"R" : @[@"Rhinoceros"],
                @"S" : @[@"Seagull"],
                @"T" : @[@"Tasmania Devil"],
                @"W" : @[@"Whale", @"Whale Shark", @"Wombat"]};
    
    animalSectionTitles = [[animals allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    animalIndexTitles = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    
    
    PFUser *user = [PFUser currentUser];
        
    userEmail = [user objectForKey:@"email"];
    userRealName = [user objectForKey:@"realName"];
    
    PFQuery *queryKnown = [PFQuery queryWithClassName:@"UserSkill"];
    [queryKnown whereKey:@"userId" equalTo:[PFUser currentUser]];
    [queryKnown whereKey:@"skillType" equalTo:@"known"];
    [queryKnown findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            knownSkills = [[NSArray alloc] initWithArray:objects];
        } else {
        }
    }];
    
    PFQuery *queryToLearn = [PFQuery queryWithClassName:@"UserSkill"];
    [queryToLearn whereKey:@"userId" equalTo:[PFUser currentUser]];
    [queryToLearn whereKey:@"skillType" equalTo:@"tolearn"];
    [queryToLearn findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            toLearnSkills = [[NSArray alloc] initWithArray:objects];
        } else {
        }
    }];
    
    
    
    NSLog(@"%@,%@",userEmail,userRealName);
    
    for (PFObject *object in knownSkills) {
        NSLog(@"knownSkill: %@",object[@"skillName"]);
    }
    
    for (PFObject *object in toLearnSkills) {
        NSLog(@"toLearnSkill: %@",object[@"skillName"]);
    }
    
}
//
//- (NSString *)getImageFilename:(NSString *)animal
//{
//    NSString *imageFilename = [[animal lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
//    imageFilename = [imageFilename stringByAppendingString:@".jpg"];
//    
//    return imageFilename;
//}

//- (PFQuery *) queryForTable {
//    PFQuery *query = [PFQuery queryWithClassName:@"User"];
//    [query whereKey:@"objectId" equalTo:[PFUser currentUser]];
//    return query;
//}

/*!
 Called when objects have loaded from Parse. If you override this method, you must
 call [super objectsDidLoad:] in your implementation.
 @param error The Parse error from running the PFQuery, if there was any.
 */
//- (void)objectsDidLoad:(PFUI_NULLABLE NSError *)error {
//    [super objectsDidLoad:error];
//    NSString *userEmail = [[self.objects objectAtIndex:0] objectForKey:@"email"];
//    NSLog(@"%@",userEmail);
//    NSLog(@"objectsDidLoad");
//}
//

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [animalSectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = [animalSectionTitles objectAtIndex:section];
    NSArray *sectionAnimals = [animals objectForKey:sectionTitle];
    return [sectionAnimals count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [animalSectionTitles objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *sectionTitle = [animalSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionAnimals = [animals objectForKey:sectionTitle];
    NSString *animal = [sectionAnimals objectAtIndex:indexPath.row];
    cell.textLabel.text = animal;
//    cell.imageView.image = [UIImage imageNamed:[self getImageFilename:animal]];
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //  return animalSectionTitles;
    return animalIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [animalSectionTitles indexOfObject:title];
}



@end
