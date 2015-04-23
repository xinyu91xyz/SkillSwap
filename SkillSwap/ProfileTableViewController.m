//
//  ProfileTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/17/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "SignInViewController.h"
#import "SignUpViewController.h"
#import "ProfileTableViewCell.h"

@interface ProfileTableViewController () <SignInViewControllerDelegate> {
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
    
    UIImage *moreImage = [UIImage imageNamed:@"MoreButton.png"];
    UIBarButtonItem *moreButton = [[UIBarButtonItem alloc] initWithImage:moreImage  landscapeImagePhone:moreImage style:UIBarButtonItemStylePlain target:self action:@selector(showMoreOptions:)];
    self.navigationItem.rightBarButtonItem = moreButton;
    
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1]}];
    self.navigationController.navigationBar.translucent = NO;
    
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return 200.0f;
    return 44.0f;
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
    ProfileTableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell" forIndexPath:indexPath];
        PFUser *user = [PFUser currentUser];
        cell.realname.text = [user objectForKey:@"realName"];
        cell.usertitle.text = [user objectForKey:@"userTitle"];
        cell.usermajor.text = [user objectForKey:@"major"];
        cell.enrollyear.text = [user objectForKey:@"enrollYear"];
        
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

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    //  return animalSectionTitles;
//    return animalIndexTitles;
//}

//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    return [animalSectionTitles indexOfObject:title];
//}


- (void)showMoreOptions:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Edit profile" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Add a skill" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Sign out" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [PFUser logOut];
        [self presentLoginViewController];
    }]];
    
    // Configure the alert controller's popover presentation controller if it has one.
    UIPopoverPresentationController *popoverPresentationController = [alertController popoverPresentationController];
    if (popoverPresentationController) {
        popoverPresentationController.sourceView = self.view;
        popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    }
    
    [self presentViewController:alertController animated:YES completion:nil];

}


#pragma mark -
#pragma mark LoginViewController

- (void)presentLoginViewController {
    // Go to the welcome screen and have them log in or create an account.
    SignInViewController *viewController = [[SignInViewController alloc] initWithNibName:nil bundle:nil];
    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:NULL];
    //    [self.navigationController setViewControllers:@[ viewController ] animated:NO];
}

#pragma mark Delegate

- (void)loginViewControllerDidLogin:(SignInViewController *)controller {
    //    [self presentWallViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
