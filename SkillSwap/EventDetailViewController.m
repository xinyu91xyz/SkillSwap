//
//  EventDetailViewController.m
//  SkillSwap
//
//  Created by Chen Zhu on 4/6/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eventTitleLabel.text = [self.object objectForKey:@"eventName"];
    self.eventDescLabel.text = [self.object objectForKey:@"eventDesc"];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1]}];
    self.navigationController.navigationBar.translucent = NO;
    
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1];
    
    PFFile *file = [self.object objectForKey:@"eventImg"];
    
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            self.eventImage.image = image;
            // image can now be set on a UIImageView
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
