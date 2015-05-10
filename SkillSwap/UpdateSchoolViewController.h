//
//  UpdateSchoolViewController.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateSchoolViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *schoolTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *schoolPicker;
- (IBAction)goButtonPressed:(id)sender;

@end
