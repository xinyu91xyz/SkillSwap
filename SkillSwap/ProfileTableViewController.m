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
#import "EditProfileViewController.h"

@interface ProfileTableViewController () <SignInViewControllerDelegate> {
    
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
    
    PFRelation *knownRelation = [[PFUser currentUser] relationForKey:@"knownSkills"];
    knownSkills = [[knownRelation query] findObjects];
    
    PFRelation *toLearnRelation = [[PFUser currentUser] relationForKey:@"toLearnSkills"];
    toLearnSkills = [[toLearnRelation query] findObjects];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) return 1;
    else if (section == 1) return [knownSkills count];
    else if (section == 2) return [toLearnSkills count];
    else return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 0.0f;
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileTableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell" forIndexPath:indexPath];
        
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user profile bg.png"]];
        
        PFUser *user = [PFUser currentUser];
        cell.realname.text = [user objectForKey:@"realName"];
        cell.realname.textColor = [UIColor whiteColor];
        cell.usertitle.text = [user objectForKey:@"userTitle"];
        cell.usertitle.textColor = [UIColor whiteColor];
        cell.usermajor.text = [user objectForKey:@"major"];
        cell.usermajor.textColor = [UIColor whiteColor];
        cell.enrollyear.text = [user objectForKey:@"enrollYear"];
        cell.enrollyear.textColor = [UIColor whiteColor];
        
        PFFile *file = [user objectForKey:@"userImg"];
        
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                cell.userimage.image = image;
                // image can now be set on a UIImageView
            }
        }];
        
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
        [self presentEditProfileViewController];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Add a skill" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@""
                                                         message:@"Add a Skill"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles:@"OK", nil];
        alert.tag = 1;
        
        alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        UITextField * alertTextField1 = [alert textFieldAtIndex:0];
        alertTextField1.keyboardType = UIKeyboardTypeDefault;
        alertTextField1.placeholder = @"Skill Name";
        
        UITextField * alertTextField2 = [alert textFieldAtIndex:1];
        alertTextField2.keyboardType = UIKeyboardTypeDefault;
        alertTextField2.placeholder = @"Skill Type: tolearn or known";
        alertTextField2.secureTextEntry=NO;
        
        [alert show];
        
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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {  //Login
            UITextField *skillname = [alertView textFieldAtIndex:0];
            UITextField *skilltype = [alertView textFieldAtIndex:1];
            
            NSLog(@"skillname: %@", skillname.text);
            NSLog(@"skilltype: %@", skilltype.text);
        }
    }

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


- (void)presentEditProfileViewController {
    EditProfileViewController *viewController = [[EditProfileViewController alloc] initWithNibName:nil bundle:nil];
//    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:NULL];
    
    NSLog(@"present edit profile view controller");

}



@end
