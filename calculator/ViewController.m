//
//  ViewController.m
//  calculator
//
//  Created by dongzhicheng on 2017/9/11.
//  Copyright © 2017年 dongzhicheng. All rights reserved.
//

#import "ViewController.h"

#define RECORD_COUNT        @"RECORD_COUNT"
#define LAST_RECORD_DATE    @"LAST_RECORD_DATE"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;

@property (nonatomic, assign) NSInteger recordCount;
@property (weak, nonatomic) IBOutlet UILabel *hitLabel;

@property (strong, nonatomic) NSDate *lastRecordDate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNumber *count = [[NSUserDefaults standardUserDefaults] objectForKey:RECORD_COUNT];
    self.recordCount = (count != nil) ? count.integerValue : 0;
    self.lastRecordDate = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_RECORD_DATE];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configUI) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self configUI];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)configUI{
    self.recordBtn.layer.cornerRadius = self.recordBtn.bounds.size.height / 2;
    self.recordBtn.layer.masksToBounds = YES;
    self.recordLabel.attributedText = [self recordAttributedString];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *lastRecordString =  [dateFormatter stringFromDate:self.lastRecordDate];
    
    NSString *hitLabelText = lastRecordString ?[NSString stringWithFormat:@"上次记录时间: %@", lastRecordString]: @"暂无记录！";
    self.hitLabel.text = [self isToday]? @"今天已经记录，继续坚持哟！": hitLabelText;
    
    if ([self isToday]) {
        self.recordBtn.backgroundColor = [UIColor redColor];
        self.recordBtn.userInteractionEnabled = NO;
    }else{
        self.recordBtn.backgroundColor = [UIColor colorWithRed:17 / 255.0 green:129 / 225.0 blue:64 / 255.0 alpha:1.0];
        self.recordBtn.userInteractionEnabled = YES;
    }
}

- (BOOL)isToday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDateInToday:self.lastRecordDate];
}

- (NSMutableAttributedString *)recordAttributedString{
    NSString *recordString = [NSString stringWithFormat:@"%ld", self.recordCount];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已坚持%@天", recordString]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, recordString.length)];
    [[NSUserDefaults standardUserDefaults] setValue:@(self.recordCount) forKey:RECORD_COUNT];

    return attributedString;
}

- (IBAction)recordBtnAction:(id)sender {
    if ([self isToday]) {
        return;
    }
   
    self.recordCount += 1;
    self.recordLabel.attributedText = [self recordAttributedString];
    [[NSUserDefaults standardUserDefaults] setValue:[NSDate date] forKey:LAST_RECORD_DATE];
}
@end
