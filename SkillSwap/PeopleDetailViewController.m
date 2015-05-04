//
//  PeopleDetailViewController.m
//  SkillSwap
//
//  Created by Xiao Tong on 4/17/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "PeopleDetailViewController.h"
#import "ChatDialogViewController.h"
@interface PeopleDetailViewController()

@end
@implementation PeopleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1]}];
    self.navigationController.navigationBar.translucent = NO;
    
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)sendMessage:(id)sender {
    ChatDialogViewController *chat = [[ChatDialogViewController alloc] initWithNibName:@"ChatDialogViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:chat animated:YES completion:nil];
}

@end
