//
//  ChatMessage.h
//  SkillSwap
//
//  Created by Xiao Tong on 5/3/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMessage : NSObject
@property(nonatomic, strong) NSString *messageId;
@property(nonatomic, strong) NSArray *recipientId;
@property(nonatomic, strong) NSArray *senderId;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSDictionary *headers;
@property(nonatomic, strong) NSDate *timestamp;

@end
