//
//  BuildEnrollYearViewController.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface BuildEnrollYearViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *createEnrollYear;
- (IBAction)saveEnrollYear:(id)sender;


@end
