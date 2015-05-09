//
//  EditProfileViewController.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 4/23/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *updateName;
//@property (weak, nonatomic) IBOutlet UILabel *showName;


@property (weak, nonatomic) IBOutlet UITextField *updateTitle;
//@property (weak, nonatomic) IBOutlet UILabel *showTitle;


@property (weak, nonatomic) IBOutlet UITextField *updateMajor;
//@property (weak, nonatomic) IBOutlet UILabel *showMajor;

@property (weak, nonatomic) IBOutlet UITextField *updateEnrollYear;
//@property (weak, nonatomic) IBOutlet UILabel *showEnrollYear;


@end
