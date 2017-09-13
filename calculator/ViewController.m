//
//  ViewController.m
//  calculator
//
//  Created by dongzhicheng on 2017/9/11.
//  Copyright © 2017年 dongzhicheng. All rights reserved.
//

#import "ViewController.h"

#define RECORD_COUNT  @"RECORD_COUNT"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;

@property (nonatomic, assign) NSInteger recordCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNumber *count = [[NSUserDefaults standardUserDefaults] objectForKey:RECORD_COUNT];
    self.recordCount = (count != nil) ? count.integerValue : 0;
    
    [self configUI];
}

- (void)configUI{
    self.recordBtn.layer.cornerRadius = self.recordBtn.bounds.size.height / 2;
    self.recordBtn.layer.masksToBounds = YES;
    
    self.recordLabel.attributedText = [self recordAttributedString];
}

- (NSMutableAttributedString *)recordAttributedString{
    NSString *recordString = [NSString stringWithFormat:@"%ld", self.recordCount];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已坚持%@天", recordString]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, recordString.length)];
    [[NSUserDefaults standardUserDefaults] setValue:@(self.recordCount) forKey:RECORD_COUNT];

    return attributedString;
}

- (IBAction)recordBtnAction:(id)sender {
    self.recordCount += 1;
    self.recordLabel.attributedText = [self recordAttributedString];
}

@end
