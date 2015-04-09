//
//  ProfileViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 4/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "ProfileViewController.h"
#import "MyLogInViewController.h"
#import "MySignUpViewController.h"
#import <Parse/Parse.h>
@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (PFQuery *) queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:@"UserProfile"];
    
    [query orderByAscending:@"UserId"];
    return query;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([PFUser currentUser]) {
        self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
    } else {
        self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
    }
    
//    [[PFUser currentUser] setObject:UserName forKey:@"UserId"];
    
//    self.nameLabel.text = [[PFUser currentUser] objectForKey:@"UserName"];
//
//    (PFObject *)object {
//        static NSString *CellIdentifier = @"EventCell";
//        
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        }
//        
//        cell.textLabel.text = [object objectForKey:@"eventName"];
//        
//        return cell;
//    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//[someUser setObject:someOccupation forKey:@"occupation"]





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
