//
//  ChatMessageCell.h
//  SkillSwap
//
//  Created by Xiao Tong on 5/3/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChatMessageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *chatMateMessageLabel;
@property (strong, nonatomic) IBOutlet UILabel *myMessageLabel;

@end
