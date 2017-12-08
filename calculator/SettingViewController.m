//
//  SettingViewController.m
//  calculator
//
//  Created by dongzhicheng on 2017/9/12.
//  Copyright © 2017年 dongzhicheng. All rights reserved.
//

#import "SettingViewController.h"


@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}

- (IBAction)clearRecordBtnAction:(id)sender {
    
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LAST_RECORD_DATE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:RECORD_COUNT];
}

@end
