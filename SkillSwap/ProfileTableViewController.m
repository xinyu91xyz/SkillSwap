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

@interface ProfileTableViewController () <SignInViewControllerDelegate, UIAlertViewDelegate> {
    
//    NSArray *knownSkills;
//    NSArray *toLearnSkills;
    NSMutableArray *knownSkills;
    NSMutableArray *toLearnSkills;
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
    
//    UIImage *moreImage = [UIImage imageNamed:@"MoreButton.png"];
//    UIBarButtonItem *moreButton = [[UIBarButtonItem alloc] initWithImage:moreImage  landscapeImagePhone:moreImage style:UIBarButtonItemStylePlain target:self action:@selector(showMoreOptions:)];
//    self.navigationItem.rightBarButtonItem = moreButton;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    PFRelation *knownRelation = [[PFUser currentUser] relationForKey:@"knownSkills"];
//    knownSkills =  [[knownRelation query] findObjects];
    knownSkills = [[NSMutableArray alloc] initWithArray:[[knownRelation query] findObjects]];
//    ;
    
    PFRelation *toLearnRelation = [[PFUser currentUser] relationForKey:@"toLearnSkills"];
//    toLearnSkills = [[toLearnRelation query] findObjects];
    toLearnSkills = [[NSMutableArray alloc] initWithArray:[[toLearnRelation query] findObjects]];
    
    // During startup (-viewDidLoad or in storyboard) do:
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
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


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    
//    if (section == 1) {
//        return @"My Skills";
//    }
//    else if (section == 2) {
//        return @"Want to Learn";
//    }
//    else {
//        return @"";
//    }
//}

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
        
        UIButton *editProfileButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        editProfileButton.frame = CGRectMake(35.0f, 140.0f, 80.0f, 30.0f);
        [editProfileButton setTitle:@"Edit Profile" forState:UIControlStateNormal];
        [editProfileButton setBackgroundImage:[UIImage imageNamed:@"Edit bg X1.png"] forState:UIControlStateNormal];
        
        [cell addSubview:editProfileButton];
        [editProfileButton addTarget:self
                            action:@selector(editProfile:)
                  forControlEvents:UIControlEventTouchUpInside];
        
        
//        cell.userInteractionEnabled = NO;
        
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

    return cell;
}


-(void) editProfile: (id)sender {
//    NSLog(@"Edit");
    [self presentEditProfileViewController];
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


- (IBAction)settings:(id)sender {
    [self performSegueWithIdentifier:@"showSettings" sender:self];
}

//- (void)showMoreOptions:(id)sender {
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Edit profile" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [self presentEditProfileViewController];
//    }]];
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Sign out" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        [PFUser logOut];
//        [self presentLoginViewController];
//    }]];
//    
//    // Configure the alert controller's popover presentation controller if it has one.
//    UIPopoverPresentationController *popoverPresentationController = [alertController popoverPresentationController];
//    if (popoverPresentationController) {
//        popoverPresentationController.sourceView = self.view;
//        popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
//    }
//    
//    [self presentViewController:alertController animated:YES completion:nil];
//
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGRect frame = tableView.frame;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    if (section == 1) {
        
        [headerView setBackgroundColor:[UIColor colorWithRed:214/255.0 green:213/255.0 blue:215/255.0 alpha:1]];
        
        UIButton *addButton = [[UIButton alloc]init];
        addButton.frame = CGRectMake(10, 6, 25, 25);

        [addButton setBackgroundImage:[UIImage imageNamed:@"ui element_Add_Page 1@3x.png"] forState:UIControlStateNormal];
//        [addButton setBackgroundImage:[UIImage imageNamed:@"ui element_Add_Page 1@3x.png"] forState:UIControlStateHighlighted];
        addButton.tag = 1;
        
        [addButton addTarget:self action:@selector(addKnownSkill:) forControlEvents:UIControlEventTouchDown];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(45, 6, 100, 25)];
        title.text = @"My Skills";
        
        [headerView addSubview:title];
        [headerView addSubview:addButton];
        

        
    } else if (section == 2) {

        [headerView setBackgroundColor:[UIColor colorWithRed:214/255.0 green:213/255.0 blue:215/255.0 alpha:1]];

        UIButton *addButton = [[UIButton alloc]init];
        addButton.frame = CGRectMake(10, 6, 25, 25);
        [addButton setBackgroundImage:[UIImage imageNamed:@"ui element_Add_Page 1@3x.png"] forState:UIControlStateNormal];
//        [addButton setBackgroundImage:[UIImage imageNamed:@"ui element_Add_Page 1@3x.png"] forState:UIControlStateHighlighted];
        addButton.tag = 2;
        
        [addButton addTarget:self action:@selector(addToLearnSkill:) forControlEvents:UIControlEventTouchDown];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(45, 6, 120, 25)];
        title.text = @"Want to Learn";

        [headerView addSubview:title];
        [headerView addSubview:addButton];
    }

    
    return headerView;
}

- (void) addKnownSkill:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@""
                                                     message:@"Add a Known Skill"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
    alert.tag = 1;
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField1 = [alert textFieldAtIndex:0];
    alertTextField1.keyboardType = UIKeyboardTypeDefault;
    alertTextField1.placeholder = @"Skill Name";
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        if (alertView.tag == 1) {
            NSString *skillname = [alertView textFieldAtIndex:0].text;
            
            PFQuery *query = [PFQuery queryWithClassName:@"Skills"];
            [query whereKey:@"skillName" equalTo:skillname];
            
            if (![query getFirstObject]) {
                
                PFObject *newSkillKnown = [PFObject objectWithClassName:@"Skills"];
                [newSkillKnown setObject:skillname forKey:@"skillName"];
                [newSkillKnown save];
                
                PFUser *user = [PFUser currentUser];
                PFRelation *relation = [user relationForKey:@"knownSkills"];
                [relation addObject:newSkillKnown];
                [user save];
                
                knownSkills = [[NSMutableArray alloc] initWithArray:[[relation query] findObjects]];
                [self.tableView reloadData];
                
            } else {
                
                PFObject *existingSkill = [query getFirstObject];
                
                PFUser *user = [PFUser currentUser];
                PFRelation *relation = [user relationForKey:@"knownSkills"];
                [relation addObject:existingSkill];
                [user save];
                
                knownSkills = [[NSMutableArray alloc] initWithArray:[[relation query] findObjects]];
                [self.tableView reloadData];
                
            }
            
        } else if (alertView.tag == 2) {
            NSString *skillname = [alertView textFieldAtIndex:0].text;
            
            PFQuery *query = [PFQuery queryWithClassName:@"Skills"];
            [query whereKey:@"skillName" equalTo:skillname];
            
            if (![query getFirstObject]) {
                
                PFObject *newSkillToLearn = [PFObject objectWithClassName:@"Skills"];
                [newSkillToLearn setObject:skillname forKey:@"skillName"];
                [newSkillToLearn save];
                
                PFUser *user = [PFUser currentUser];
                PFRelation *relation = [user relationForKey:@"toLearnSkills"];
                [relation addObject:newSkillToLearn];
                [user save];
                
                toLearnSkills = [[NSMutableArray alloc] initWithArray:[[relation query] findObjects]];
                [self.tableView reloadData];
                
            } else {
                
                PFObject *existingSkill = [query getFirstObject];
                
                PFUser *user = [PFUser currentUser];
                PFRelation *relation = [user relationForKey:@"toLearnSkills"];
                [relation addObject:existingSkill];
                [user save];
                
                toLearnSkills = [[NSMutableArray alloc] initWithArray:[[relation query] findObjects]];
                [self.tableView reloadData];
                
            }
            
        }
        
    }
}

- (void) addToLearnSkill:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@""
                                                     message:@"Add a Skill To Learn"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
    alert.tag = 2;
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField1 = [alert textFieldAtIndex:0];
    alertTextField1.keyboardType = UIKeyboardTypeDefault;
    alertTextField1.placeholder = @"Skill Name";
    
    [alert show];
    
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    if (indexPath.section == 0) {
        return NO;
    } else {
        return YES;
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        if (indexPath.section == 1) {
            
//            [knownSkills removeObjectAtIndex:indexPath.row];
            PFObject *object = [knownSkills objectAtIndex:indexPath.row];
            [knownSkills removeObjectAtIndex:indexPath.row];
            [object deleteEventually];
            
            [tableView reloadData];
            

            
        } else if (indexPath.section == 2) {
            PFObject *object = [toLearnSkills objectAtIndex:indexPath.row];
            [toLearnSkills removeObjectAtIndex:indexPath.row];
            [object deleteEventually];
            
            [tableView reloadData];
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
    
//    NSLog(@"present edit profile view controller");

}


@end
