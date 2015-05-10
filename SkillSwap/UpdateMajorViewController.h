//
//  UpdateMajorViewController.h
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateMajorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *majorTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *majorPicker;
- (IBAction)goButtonPressed:(id)sender;

@property (nonatomic, weak) NSString *schoolName;

@end
