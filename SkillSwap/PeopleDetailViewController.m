//
//  PeopleDetailViewController.m
//  SkillSwap
//
//  Created by Xiao Tong on 4/17/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "PeopleDetailViewController.h"
#import "PeopleCell.h"
@interface PeopleDetailViewController()

@end
@implementation PeopleDetailViewController
NSMutableArray *knowRes;
NSMutableArray *wantRes;

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1];
//    [self.navigationController.navigationBar
//     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1]}];
//    self.navigationController.navigationBar.translucent = NO;
//    
//    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:223/255.0 green:62/255.0 blue:125/255.0 alpha:1];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view;
    if(section == 0) {
        //initialize view for section 1
    }
    else {
        //inialize view for section 2
    }
    return view;
}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if(indexPath.section == 0) {
//        UITableViewCell *cell;
//        cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCellId" forIndexPath:indexPath];
//        
//    }
//    else if (indexPath.section == 1) {
//        switch(indexPath.row) {
//            case 0: // Initialize cell 1
//                break;
//            case 1: // Initialize cell 2
//                break;
//                
//        }
//    }
//    return cell;
//}

-(IBAction)sendMessage:(id)sender {
    //    ChatDialogViewController *chat = [[ChatDialogViewController alloc] initWithNibName:@"ChatDialogViewController" bundle:[NSBundle mainBundle]];
    //    [self presentViewController:chat animated:YES completion:nil];
    
    //Email Subject
    NSString *emailTitle = @"Test Email";
    //Email Content
    NSString *messageBody = @"iOS programming is so fun!";
    //To address
    NSString *email = _object[@"email"];
    NSArray *toRecipients = [NSArray arrayWithObject:email];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipients];
    
    //present mail view controller on screen
    [self presentViewController:mc animated:YES completion: NULL];
    
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            
        default:
            break;
    }
    //close the mail interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
