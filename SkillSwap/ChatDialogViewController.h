//
//  ChatDialogViewController.h
//  SkillSwap
//
//  Created by Xiao Tong on 5/2/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessageCell.h"
#import "ChatMessage.h"
#import <ParseUI/ParseUI.h>

@interface ChatDialogViewController : UIViewController
@property (strong, nonatomic) NSString *chatMateId;
@property (strong, nonatomic) NSMutableArray *messageArray;
@property (strong, nonatomic) NSString *myUserId;
@property (strong, nonatomic) UITextField *activeTextField;

-(IBAction)sendMessage:(id)sender;
@end
