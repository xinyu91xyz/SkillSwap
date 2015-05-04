//
//  TabBarController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/1/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "TabBarController.h"
//#import "MyLogInViewController.h"
//#import "MySignUpViewController.h"
#import "SignInViewController.h"
#import "SignUpViewController.h"
#import "BuildProfileViewController.h"

@interface TabBarController ()
<SignInViewControllerDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // set default selected tab in TabBarController to profile table view controller
    self.selectedViewController=[self.viewControllers objectAtIndex:1];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) {
        
        [self presentLoginViewController];

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
