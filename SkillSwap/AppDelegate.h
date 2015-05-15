//
//  AppDelegate.h
//  SkillSwap
//
//  Created by Chen Zhu on 3/30/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
- (void)resetWindowToInitialView;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIImage *userImage;
@property (strong, nonatomic) NSMutableArray *mySkills;
@property (strong, nonatomic) NSMutableArray *wantToLearns;
@property (strong, nonatomic) NSArray *matchedPeople;

@end

