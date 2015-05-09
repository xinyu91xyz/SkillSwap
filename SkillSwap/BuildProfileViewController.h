//
//  BuildProfileViewController.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/4/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BuildProfileViewController;

@protocol BuildProfileViewControllerDelegate <NSObject>
//- (void)buildProfileViewControllerDidBuild:(BuildProfileViewController *)controller;

@end

@interface BuildProfileViewController : UIViewController

@property (nonatomic, weak) id<BuildProfileViewControllerDelegate> delegate;


- (IBAction)donePressed:(id)sender;

@end
