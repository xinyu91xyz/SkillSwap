//
//  PeopleTableViewCell.h
//  SkillSwap
//
//  Created by Xiao Tong on 5/7/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PeopleCell;

@interface PeopleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *major;
@property (weak, nonatomic) IBOutlet UIImageView *userimage;
@property (weak, nonatomic) IBOutlet UILabel *skills;
@property (weak, nonatomic) IBOutlet UILabel *wants;

@end
