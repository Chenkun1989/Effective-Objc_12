//
//  AKAutoDictionary.m
//  DynamicMethodResolve
//
//  Created by ck8099 on 16/3/15.
//  Copyright © 2016年 ArcSoft. All rights reserved.
//

#import "AKAutoDictionary.h"
#import <objc/runtime.h>

@interface AKAutoDictionary ()

@property (nonatomic) NSMutableDictionary *backingStore;

@end


id autoDictionayGetter(id self, SEL _cmd) {
    
    AKAutoDictionary *typedSelf = (AKAutoDictionary *)self;
    
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    
    NSString *key = NSStringFromSelector(_cmd);
    
    return [backingStore objectForKey:key];
}

void autoDictionarySetter(id self, SEL _cmd, id value) {
    
    AKAutoDictionary *typedSelf = (AKAutoDictionary *)self;
    
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    
    /** The selector will be for example, "setOpaqueObject:".
     * We need to remove the "set", ":" and lowercase the first
     * letter of the remainder.
     */
    
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectorString mutableCopy];
    
    // Remove the ':' at the end.
    [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
    
    // Remove the 'set' at the first.
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    // Lowercase the first character.
    NSString *lowercaseFirstChar = [[key substringWithRange:NSMakeRange(0, 1)] lowercaseString];
    
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    
    if (value) {
        [backingStore setObject:value forKey:key];
    } else {
        [backingStore removeObjectForKey:key];
    }
}


@implementation AKAutoDictionary

@dynamic string, number, date, opaqueObject;

- (id)init {
    
    if (self = [super init]) {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    NSString *selectorString = NSStringFromSelector(sel);
    
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
    } else {
        class_addMethod(self, sel, (IMP)autoDictionayGetter, "@@:");
    }
    return YES;
}

@end
