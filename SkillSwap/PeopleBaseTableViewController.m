//
//  PeopleBaseTableViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 5/13/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "PeopleBaseTableViewController.h"
#import "AppDelegate.h"


@interface PeopleBaseTableViewController ()

@end

@implementation PeopleBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"PeopleCell" bundle:nil] forCellReuseIdentifier:@"peopleCellId"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configureCell:(PeopleCell *)cell forUser:(NSString *)userId {
    PFQuery *query = [PFUser query];
    PFUser *user = (PFUser *)[query getObjectWithId:userId];
    
    PFFile *file = [user objectForKey:@"userImg"];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.userImage.image = [UIImage imageWithData:data];
            cell.userImage.layer.cornerRadius = cell.userImage.frame.size.width / 2.0f;
            cell.userImage.layer.masksToBounds = YES;
        }
    }];
    cell.nameLabel.text = [user objectForKey:@"realName"];
    cell.majorLabel.text = [user objectForKey:@"major"];
    
//    PFQuery *querySkill = [PFQuery queryWithClassName:@"UserSkill"];
//    [querySkill whereKey:@"userId" equalTo:userId];
//    [querySkill selectKeys:@[@"skillName",@"skillType"]];
//    self.skills = [querySkill findObjects];
    
    NSMutableString *skillsString = [NSMutableString stringWithString:@"Skills: "];
    NSMutableString *wantsString = [NSMutableString stringWithString:@"Wants: "];
//    
//    for (int i = 0; i < [self.skills count]; i++) {
//        if ([[self.skills[i] objectForKey:@"skillType"] isEqualToString:@"known"]) {
//            [skillsString appendString:[self.skills[i] objectForKey:@"skillName"]];
//            [skillsString appendString:@", "];
//
//        } else {
//            [wantsString appendString:[self.skills[i] objectForKey:@"skillName"]];
//            [wantsString appendString:@", "];
//        }
//    }
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSArray *userSkills = appDelegate.matchedPeople;
    for (int i = 0; i < [userSkills count]; i++) {
        if ([[userSkills[i] objectForKey:@"skillType"] isEqualToString:@"known"] && [[userSkills[i] objectForKey:@"userId"] isEqualToString:[user objectId]]) {
            [skillsString appendString:[userSkills[i] objectForKey:@"skillName"]];
            [skillsString appendString:@", "];
            
        }
        else if ([[userSkills[i] objectForKey:@"skillType"] isEqualToString:@"toLearn"] && [[userSkills[i] objectForKey:@"userId"] isEqualToString:[user objectId]]) {
            [wantsString appendString:[userSkills[i] objectForKey:@"skillName"]];
            [wantsString appendString:@", "];
            
        }

    }
    
    NSString *skills = [NSString stringWithString:skillsString];
    NSString *wants = [NSString stringWithString:wantsString];
    cell.skillsLabel.text = [skills substringToIndex:skills.length-2];
    cell.wantsLabel.text = [wants substringToIndex:wants.length-2];
    
}

- (void)configureDetailedCell:(PeopleCell *)cell forUser:(NSString *)userId {
    PFQuery *query = [PFUser query];
    PFUser *user = (PFUser *)[query getObjectWithId:userId];
    
    PFFile *file = [user objectForKey:@"userImg"];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.userImage.image = [UIImage imageWithData:data];
            cell.userImage.layer.cornerRadius = cell.userImage.frame.size.width / 2.0f;
            cell.userImage.layer.masksToBounds = YES;
        }
    }];
    cell.nameLabel.text = [user objectForKey:@"realName"];
    cell.majorLabel.text = [user objectForKey:@"major"];
    PFQuery *querySkill = [PFQuery queryWithClassName:@"UserSkill"];
    [querySkill whereKey:@"userId" equalTo:userId];
    [querySkill selectKeys:@[@"skillName",@"skillType"]];
    
    NSArray *mySkills = [querySkill findObjects];
    
    NSMutableString *skillsString = [NSMutableString stringWithString:@"Skills: "];
    NSMutableString *wantsString = [NSMutableString stringWithString:@"Wants: "];

    for (int i = 0; i < [mySkills count]; i++) {
        if ([[mySkills[i] objectForKey:@"skillType"] isEqualToString:@"known"]) {
            [skillsString appendString:[mySkills[i] objectForKey:@"skillName"]];
            [skillsString appendString:@", "];

        } else {
            [wantsString appendString:[mySkills[i] objectForKey:@"skillName"]];
            [wantsString appendString:@", "];
        }
    }
    NSString *skills = [NSString stringWithString:skillsString];
    NSString *wants = [NSString stringWithString:wantsString];
    cell.skillsLabel.text = [skills substringToIndex:skills.length-2];
    cell.wantsLabel.text = [wants substringToIndex:wants.length-2];
}

@end




