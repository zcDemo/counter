//
//  SettingViewController.m
//  calculator
//
//  Created by dongzhicheng on 2017/9/12.
//  Copyright © 2017年 dongzhicheng. All rights reserved.
//

#import "SettingViewController.h"


@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (nonatomic, copy) NSString *dateString
;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datePicker.hidden = YES;
    self.commitBtn.hidden = YES;
}

- (IBAction)setAlertTime:(id)sender {
    [self updatePickViewStatus];
}

- (IBAction)commitBtnAction:(id)sender {
    [self updatePickViewStatus];
    [[NSUserDefaults standardUserDefaults] setObject:self.dateString forKey:ALERT_TIME];
}

- (void)updatePickViewStatus{
    self.datePicker.hidden = !self
    .datePicker.hidden;
    self.commitBtn.hidden = self.datePicker.hidden;
}

- (IBAction)datePickViewAction:(id)sender {
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    NSDate *date = datePicker.date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    self.dateString = [formatter stringFromDate:date];
    NSLog(@"%@", self.dateString);
}

- (IBAction)clearRecordBtnAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LAST_RECORD_DATE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:RECORD_COUNT];
}

@end
