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
    NSString *urlString = [self.object objectForKey:@"eventUrl"];
    [self.eventWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
//    self.eventTitleLabel.text = [self.object objectForKey:@"eventName"];
//    self.eventDescLabel.text = [self.object objectForKey:@"eventDesc"];
//    
//    PFFile *file = [self.object objectForKey:@"eventImg"];
//    
//    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//        if (!error) {
//            UIImage *image = [UIImage imageWithData:data];
//            self.eventImage.image = image;
//            // image can now be set on a UIImageView
//        }
//    }];
//    // Do any additional setup after loading the view.
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
