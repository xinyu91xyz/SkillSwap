//
//  UpdateSchoolViewController.m
//  SkillSwap
//
//  Created by Xinyu Zheng on 5/9/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "UpdateSchoolViewController.h"
#import <Parse/Parse.h>

@interface UpdateSchoolViewController () <UIPickerViewDelegate>
@property(nonatomic,strong) NSArray *schoolArray;

@end

@implementation UpdateSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.schoolPicker.delegate = self;
    self.schoolArray = @[@"The Information School",
                         @"College of Built Environments",
                         @"College of Education",
                         @"College of Engineering",
                         @"School of Business Administration",
                         @"School of Nursing",
                         @"School of Pharmacy"];
    self.schoolTextField.text = @"The Information School";

    // Do any additional setup after loading the view.
}

- (IBAction)goButtonPressed:(id)sender {
    if (![self.schoolTextField.text isEqualToString:@""]) {
        
        // update user real name
        PFQuery *userschool = [PFUser query];
        [userschool whereKey:@"objectId" equalTo:[PFUser currentUser]];
        
        [userschool getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         {
             PFUser *currentUser = [PFUser currentUser];
             [currentUser setObject:self.schoolTextField.text forKey:@"school"];
             [[PFUser currentUser] saveInBackground];
             
         }];
    }
}

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return  [self.schoolArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.schoolArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.schoolTextField.text = self.schoolArray[row];
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
