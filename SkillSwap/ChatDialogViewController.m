//
//  ChatDialogViewController.m
//  SkillSwap
//
//  Created by Xiao Tong on 5/2/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "ChatDialogViewController.h"
@interface ChatDialogViewController()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *messageEditField;
@property (strong, nonatomic) IBOutlet UITextView *historicalMessageTableView;
@end
@implementation ChatDialogViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.chatMateId;
    self.messageArray = [[NSMutableArray alloc] init];
}
@end
