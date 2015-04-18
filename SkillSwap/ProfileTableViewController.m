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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    PFRelation *knownRelation = [[PFUser currentUser] relationForKey:@"knownSkills"];
    knownSkills = [[knownRelation query] findObjects];
    
    PFRelation *toLearnRelation = [[PFUser currentUser] relationForKey:@"toLearnSkills"];
    toLearnSkills = [[toLearnRelation query] findObjects];
    
    
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
    
    
    
    
    NSLog(@"%@,%@",userEmail,userRealName);
    
    for (PFObject *object in knownSkills) {
        NSLog(@"knownSkill: %@",object[@"skillName"]);
    }
    
    for (PFObject *object in toLearnSkills) {
        NSLog(@"%@",object[@"skillType"]);
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
    //    return [animalSectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //    NSString *sectionTitle = [animalSectionTitles objectAtIndex:section];
    //    NSArray *sectionAnimals = [animals objectForKey:sectionTitle];
    //    return [sectionAnimals count];
    if (section == 0) return 1;
    else if (section == 1) return [knownSkills count];
    else if (section == 2) return [toLearnSkills count];
    else return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 1.0f;
    return 32.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section == 1) {
        return @"My Skills";
    }
    else if (section == 2) {
        return @"Want to Learn";
    }
    else {
        return @"";
    }
    //    return [animalSectionTitles objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell" forIndexPath:indexPath];
    }
    else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MySkillCell" forIndexPath:indexPath];
        
        cell.textLabel.text = knownSkills[indexPath.row][@"skillName"];
        
    }
    else if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ToLearnCell" forIndexPath:indexPath];
        cell.textLabel.text = toLearnSkills[indexPath.row][@"skillName"];
        
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell" forIndexPath:indexPath];
    }
    // Configure the cell...
    //    NSString *sectionTitle = [animalSectionTitles objectAtIndex:indexPath.section];
    //    NSArray *sectionAnimals = [animals objectForKey:sectionTitle];
    //    NSString *animal = [sectionAnimals objectAtIndex:indexPath.row];
    //    cell.textLabel.text = animal;
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
