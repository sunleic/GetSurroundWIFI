//
//  AppDelegate.m
//  GetSurroundWIFI
//
//  Created by 孙磊 on 16/10/1.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import "AppDelegate.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NetworkExtension.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //获取周边WiFi信息
    
    /**
     *  法一：：
     *  此方法只能获取到当前连接的WiFi的信息
     *
     */
    NSArray *names = (__bridge NSArray*)CNCopySupportedInterfaces();
    
    NSDictionary *info = nil;
    NSLog(@"++++%@",names);
    for (NSString *name in names) {
        info = (__bridge NSDictionary*)CNCopyCurrentNetworkInfo((__bridge CFStringRef)name);
        
        if (info && [info count]) {
            break;
        }
    }
    //一个路由可以有多个ssid，不能用ssid唯一标识一个路由
    NSString *ssid = [[info objectForKey:(__bridge NSString*)kCNNetworkInfoKeySSID] lowercaseString];
    //标示LAN状态下的硬件地址，可以唯一标识一个路由
    NSString *bssid = [[info objectForKey:(__bridge NSString*)kCNNetworkInfoKeyBSSID] lowercaseString];
    
    NSLog(@"ssid：%@-----bssid:%@",ssid,bssid);
    
    
    /**
     *  法二：：：
     *  此法可以获取WiFi列表，但是使用比较麻烦，需要给苹果发送邮件获取权限，还有可能要重新配置证书
     *  相关连接 http://blog.csdn.net/huangmindong/article/details/51579729
     *          http://www.jianshu.com/p/15e90bf11c51
     */
    NSArray * networkInterfaces = [NEHotspotHelper supportedNetworkInterfaces];
    NSLog(@"Networks %@",networkInterfaces);
    //获取wifi列表
    for(NEHotspotNetwork *hotspotNetwork in networkInterfaces) {
        NSString *ssid = hotspotNetwork.SSID;
        NSString *bssid = hotspotNetwork.BSSID;
        //        BOOL secure = hotspotNetwork.secure;
        //        BOOL autoJoined = hotspotNetwork.autoJoined;
        //        double signalStrength = hotspotNetwork.signalStrength;
        
        NSLog(@"-ssid:%@----bssid:%@",ssid,bssid);
    }

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
