//
//  PeopleDetailViewController.m
//  SkillSwap
//
//  Created by Xiao Tong on 4/17/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "PeopleDetailViewController.h"
#import "PeopleDetailCell.h"
#import "PeopleDetail.h"

@interface PeopleDetailViewController()

@end
@implementation PeopleDetailViewController
@synthesize knowRes;
@synthesize wantRes;
@synthesize tableView;
@synthesize object;
- (void)viewDidLoad {
    [super viewDidLoad];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PeopleDetailCell class]) bundle:nil] forCellReuseIdentifier:@"DetailCellID"];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PeopleDetail class]) bundle:nil] forCellReuseIdentifier:@"LargeCell"];
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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
    
}
//-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if(section == 0) {
//        return 20.0f;
//    }
//    else {
//        return 32.0f;
//    }
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return 30.0f;
    }
    return 40.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        PeopleDetailCell *cell;
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailCellID" forIndexPath:indexPath];
        cell.username.text = object[@"realName"];
        cell.major.text = object[@"major"];
        PFFile *file = [object objectForKey:@"userImg" ];
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(!error) {
                UIImage *image = [UIImage imageWithData:data];
                cell.userimage.image = image;
            }
        }];
        //        if ([cell respondsToSelector:@selector(layoutMargins)]) {
        //            cell.layoutMargins = UIEdgeInsetsZero;
        //        }
        return cell;
    }
    
    // else if (indexPath.section == 1) {
    else{
        PeopleDetail *cell;
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"LargeCell" forIndexPath:indexPath];
        PFQuery *query = [PFQuery queryWithClassName:@"UserSkill"];
        [query whereKey:@"userId" equalTo:[object objectId]];
        [query whereKey:@"skillType" equalTo:@"known"];
        [query selectKeys:@[@"skillName"]];
        knowRes = [[NSMutableArray alloc] initWithArray:[query findObjects]];
        NSInteger knowCount = [knowRes count];
        NSMutableString *knowStr = [NSMutableString string];
        for(int i = 0; i < knowCount-1; i++) {
            NSString *tmp = knowRes[i][@"skillName"];
            [knowStr appendString:tmp];
            [knowStr appendString:@" "];
        }
        [knowStr appendString:knowRes[knowCount-1][@"skillName"]];
        cell.skills.text = knowStr;
        //        cell = [self.tableView dequeueReusableCellWithIdentifier:@"LargeCell" forIndexPath:indexPath];
        PFQuery *query2 = [PFQuery queryWithClassName:@"UserSkill"];
        [query2 whereKey:@"userId" equalTo:[object objectId]];
        [query2 whereKey:@"skillType" equalTo:@"toLearn"];
        [query2 selectKeys:@[@"skillName"]];
        wantRes = [[NSMutableArray alloc] initWithArray:[query2 findObjects]];
        NSInteger wantCount = [wantRes count];
        NSMutableString *wantStr = [NSMutableString string];
        for(int i = 0; i < wantCount-1; i++) {
            NSString *tmp = wantRes[i][@"skillName"];
            [wantStr appendString:tmp];
            [wantStr appendString:@" "];
        }
        [wantStr appendString:wantRes[wantCount-1][@"skillName"]];
        cell.wants.text = wantStr;
        //        if ([cell respondsToSelector:@selector(layoutMargins)]) {
        //            cell.layoutMargins = UIEdgeInsetsZero;
        //        }
        return cell;
    }
    
    //  else {
    //
    //       cell = [self.tableView dequeueReusableCellWithIdentifier:@"SendMessage" forIndexPath:indexPath];
    ////      if ([cell respondsToSelector:@selector(layoutMargins)]) {
    ////          cell.layoutMargins = UIEdgeInsetsZero;
    ////      }
    //      return cell;
    //    }
    
}

-(IBAction)sendMessage:(id)sender {
    //Email Subject
    NSString *emailTitle = @"Test Email";
    //Email Content
    NSString *messageBody = @"iOS programming is so fun!";
    //To address
    NSString *email = object[@"myEmail"];
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
