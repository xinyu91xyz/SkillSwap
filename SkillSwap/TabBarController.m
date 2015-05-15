//
//  TabBarController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/1/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "TabBarController.h"
#import "SignInViewController.h"
#import "SignUpViewController.h"
#import "AppDelegate.h"
#import "ActivityView.h"
#import "ProfileTableViewController.h"

@interface TabBarController () <SignInViewControllerDelegate>

@property (nonatomic, assign) BOOL activityViewVisible;
@property (nonatomic, strong) UIView *activityView;

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([PFUser currentUser]) {
        self.activityViewVisible = YES;
        [self loadUserData];
        self.activityViewVisible = NO;
    }
    // set default selected tab in TabBarController to profile table view controller
    self.selectedViewController=[self.viewControllers objectAtIndex:2];
    
    

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![PFUser currentUser]) {
        [self presentLoginViewController];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.activityView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadUserData {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    PFUser *user = [PFUser currentUser];
    
    PFQuery *query1 = [PFQuery queryWithClassName:@"UserSkill"];
    [query1 whereKey:@"userId" equalTo:[user objectId]];
    [query1 whereKey:@"skillType" equalTo:@"known"];
    [query1 selectKeys:@[@"skillName",@"skillType"]];
    
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"UserSkill"];
    [query2 whereKey:@"userId" equalTo:[user objectId]];
    [query2 whereKey:@"skillType" equalTo:@"toLearn"];
    [query2 selectKeys:@[@"skillName",@"skillType"]];
    
    PFFile *file = [user objectForKey:@"userImg"];
    
    appDelegate.mySkills = [[NSMutableArray alloc] initWithArray:[query1 findObjects]];
    appDelegate.wantToLearns = [[NSMutableArray alloc] initWithArray:[query2 findObjects]];
    appDelegate.userImage  = [UIImage imageWithData:[file getData]];
}

#pragma mark -
#pragma mark LoginViewController

- (void)presentLoginViewController {
    // Go to the welcome screen and have them log in or create an account.
    SignInViewController *viewController = [[SignInViewController alloc] initWithNibName:nil bundle:nil];
    viewController.delegate = self;
    [self presentViewController:viewController animated:NO completion:NULL];
}


#pragma mark Delegate

- (void)loginViewControllerDidLogin:(SignInViewController *)controller {
    
    [self loadUserData];
//    ProfileTableViewController *profileTableViewController = (ProfileTableViewController *)[self.viewControllers objectAtIndex:2];
//    [profileTableViewController.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark ActivityView

- (void)setActivityViewVisible:(BOOL)visible {
    if (self.activityViewVisible == visible) {
        return;
    }
    
    _activityViewVisible = visible;
    
    if (_activityViewVisible) {
        ActivityView *activityView = [[ActivityView alloc] initWithFrame:self.view.bounds];
        activityView.label.text = @"Loading";
        activityView.label.font = [UIFont boldSystemFontOfSize:20.f];
        [activityView.activityIndicator startAnimating];
        
        _activityView = activityView;
        [self.view addSubview:_activityView];
    } else {
        [_activityView removeFromSuperview];
        _activityView = nil;
    }
}




@end
