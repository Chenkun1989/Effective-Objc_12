//
//  NSString+AKAdditions.m
//  DynamicMethodResolve
//
//  Created by ck8099 on 16/3/15.
//  Copyright © 2016年 ArcSoft. All rights reserved.
//

#import "NSString+AKAdditions.h"

@implementation NSString (AKAdditions)

- (NSString *)ak_myLowercaseString {
    
    NSString *lowercase = [self ak_myLowercaseString];
    
    NSLog(@"%@ => %@", self, lowercase);
    
    return lowercase;
}

@end
