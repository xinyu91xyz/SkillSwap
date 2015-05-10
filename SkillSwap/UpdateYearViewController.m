//
//  UpdateYearViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "UpdateYearViewController.h"
#import <Parse/Parse.h>

@interface UpdateYearViewController () <UIPickerViewDelegate>
@property (nonatomic,strong) NSMutableArray *yearArray;

@end

@implementation UpdateYearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.yearPicker.delegate = self;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *yearInString = [dateFormatter stringFromDate:[NSDate date]];
    self.yearTextField.text = yearInString;
    
    self.yearArray = [[NSMutableArray alloc] init];
    for (int i = 2000; i <= [yearInString intValue]; i++) {
        [self.yearArray addObject:[NSString stringWithFormat: @"%ld", (long)(i)]];
    }
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    self.yearEnrolled =[dateFormatter stringFromDate:[NSDate date]];
    NSInteger yearInInteger = [self.yearEnrolled intValue];
    [self.yearPicker selectRow:(yearInInteger-2000) inComponent:0 animated:NO];
}

- (IBAction)goButtonPressed:(id)sender {
    if (![self.yearTextField.text isEqualToString:@""]) {
        
        // update user real name
        PFQuery *useryear = [PFUser query];
        [useryear whereKey:@"objectId" equalTo:[PFUser currentUser]];
        
        [useryear getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         {
             PFUser *currentUser = [PFUser currentUser];
             [currentUser setObject:self.yearTextField.text forKey:@"enrollYear"];
             [[PFUser currentUser] saveInBackground];
             
         }];
    }
}

#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return  [self.yearArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.yearArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.yearTextField.text = self.yearArray[row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
