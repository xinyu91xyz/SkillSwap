//
//  PeopleViewController.m
//  SkillSwap
//
//  Created by Xiao Tong on 4/15/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "PeopleViewController.h"
#import <Parse/Parse.h>

@interface  PeopleViewController()

@end

@implementation PeopleViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:@"xixihaha"];
    PFUser *user = (PFUser *)[query getFirstObject];

    self.userNameLabel.text = user.username;
   
};

@end


