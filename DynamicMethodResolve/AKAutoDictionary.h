//
//  AKAutoDictionary.h
//  DynamicMethodResolve
//
//  Created by ck8099 on 16/3/15.
//  Copyright © 2016年 ArcSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKAutoDictionary : NSObject

@property (nonatomic, copy) NSString *string;
@property (nonatomic, copy) NSNumber *number;
@property (nonatomic) NSDate *date;
@property (nonatomic, strong) id opaqueObject;

@end
