//
//  PeopleDetail.h
//  SkillSwap
//
//  Created by Xiao Tong on 5/11/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PeopleDetail;

@interface PeopleDetail : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *aboutMe;
@property (weak, nonatomic) IBOutlet UILabel *skills;
@property (weak, nonatomic) IBOutlet UILabel *wants;

@end
