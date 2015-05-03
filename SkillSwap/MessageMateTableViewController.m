//
//  MessageMateTableViewController.m
//  SkillSwap
//
//  Created by Xiao Tong on 5/2/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "MessageMateTableViewController.h"
#import <Parse/Parse.h>
#import "ChatDialogViewController.h"
@interface MessageMateTableViewController ()
@property (strong, nonatomic) NSMutableArray *chatMatesArray;
@property (strong, nonatomic) ChatDialogViewController *activeDialogViewController;
@property (strong, nonatomic) NSString *myUserId;
@end

@implementation MessageMateTableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return the number of sections
    return 1;
}

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section:(NSInteger)section
//{
//    return [self.chatMatesArray count];
//}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.activeDialogViewController = nil;
    [self retrieveChatMatesFromParse];
}
- (void)retrieveChatMatesFromParse {
    [self.chatMatesArray removeAllObjects];
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    NSLog(@"error");
    [query whereKey:@"username" notEqualTo:[PFUser currentUser][@"username"]];
    __weak typeof(self) weakSelf = self;
   [query findObjectsInBackgroundWithBlock:^(NSArray *chatMateArray, NSError *error) {
        if(!error) {
            
            for(int i = 0; i < [chatMateArray count]; i++) {
                [weakSelf.chatMatesArray addObject:chatMateArray[i][@"username"]];
            }
            [weakSelf.tableView reloadData];
        }
        else {
            NSLog(@"Error: %@", error.description);
        }
    }];
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chatMatesArray = [[NSMutableArray alloc] init];
    //self.navigationItem.title = self.myUserId;
    // Do any additional setup after loading the view.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ChatMateCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *chatMateId = [self.chatMatesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = chatMateId;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"openDialog"]) {
        self.activeDialogViewController = segue.destinationViewController;
        NSInteger chatMateIndex = [[self.tableView indexPathForCell:(UITableViewCell *)sender] row];
        self.activeDialogViewController.chatMateId = self.chatMatesArray[chatMateIndex];
    }
}


@end
