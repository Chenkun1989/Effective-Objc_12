//
//  AppDelegate.m
//  DynamicMethodResolve
//
//  Created by ck8099 on 16/3/15.
//  Copyright © 2016年 ArcSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "AKAutoDictionary.h"
#import "NSString+AKAdditions.h"

#import <objc/runtime.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    AKAutoDictionary *dict = [AKAutoDictionary new];
    
    dict.date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSLog(@"date = %@", dict.date);
    
    Method originalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method swappedMethod = class_getInstanceMethod([NSString class], @selector(ak_myLowercaseString));
    
    method_exchangeImplementations(originalMethod, swappedMethod);
    
    NSString *test = @"Test";
    
    [test lowercaseString];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
