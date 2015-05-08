//
//  BuildNameViewController.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/4/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@class BuildNameViewController;

@protocol BuildNameViewControllerDelegate <NSObject>
//- (void)buildNameViewControllerDidBuild:(BuildProfileViewController *)controller;

@end

@interface BuildNameViewController : UIViewController

@property (nonatomic, weak) id<BuildNameViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *createName;
- (IBAction)saveName:(id)sender;

//- (IBAction)donePressed:(id)sender;

@end
