//
//  PeopleDetailCell.h
//  SkillSwap
//
//  Created by Xiao Tong on 5/10/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PeopleDetailCell;

@interface PeopleDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userimage;
@property (weak, nonatomic) IBOutlet UILabel *major;
@property (weak, nonatomic) IBOutlet UILabel *username;

@end
