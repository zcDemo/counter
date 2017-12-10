//
//  AppDelegate.m
//  calculator
//
//  Created by dongzhicheng on 2017/9/11.
//  Copyright © 2017年 dongzhicheng. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@property (nonatomic, copy) NSString *pushTime;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.pushTime = [[NSUserDefaults standardUserDefaults] objectForKey:ALERT_TIME]?:@"23:30:00";
    [self registerNotification];
    return YES;
}

- (void)registerNotification{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        UNUserNotificationCenter  *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        
        [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                [self schduleUNLocalNotificaiton];
            } else{
                NSLog(@"授权失败");
            }
            
        }];
    } else{
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound)categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
}

- (void)schduleUNLocalNotificaiton{
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Hi~ o(*￣▽￣*)ブ" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:@"今天还没有记录哟！"
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];

    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateComponetnts = [calender components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    dateComponetnts.hour = [[self.pushTime componentsSeparatedByString:@":"].firstObject integerValue];
    dateComponetnts.minute = [[self.pushTime componentsSeparatedByString:@":"][1] integerValue];
    dateComponetnts.second = 00;
    UNCalendarNotificationTrigger *calendarTriggier = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponetnts repeats:YES];
    
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"zc_notification"
                                                                          content:content trigger:calendarTriggier];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
    
    }];
}

- (void)scheduleLocalNotification{
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm:ss";
    notification.fireDate = [dateFormatter dateFromString:self.pushTime];
    notification.repeatInterval = kCFCalendarUnitDay;
    notification.alertTitle = @"Hi~ o(*￣▽￣*)ブ";
    notification.alertBody = @"今天还没有记录哟！";
    notification.alertAction = @"取消";
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        [self scheduleLocalNotification];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"%@", notification.alertBody);
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

@end
