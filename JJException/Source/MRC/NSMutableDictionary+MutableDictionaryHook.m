//
//  NSMutableDictionary+MutableDictionaryHook.m
//  JJException
//
//  Created by Jezz on 2018/7/15.
//  Copyright © 2018年 Jezz. All rights reserved.
//

#import "NSMutableDictionary+MutableDictionaryHook.h"
#import "NSObject+SwizzleHook.h"
#import "JJExceptionProxy.h"
#import "JJExceptionMacros.h"

JJSYNTH_DUMMY_CLASS(NSMutableDictionary_MutableDictionaryHook)

@implementation NSMutableDictionary (MutableDictionaryHook)

+ (void)jj_swizzleNSMutableDictionary{
    swizzleInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKey:), @selector(hookSetObject:forKey:));
    swizzleInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(removeObjectForKey:), @selector(hookRemoveObjectForKey:));
    swizzleInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKeyedSubscript:), @selector(hookSetObject:forKeyedSubscript:));
}

- (void) hookSetObject:(id)object forKey:(id)key {
    if (object && key) {
        [self hookSetObject:object forKey:key];
    } else {
        NSArray *stack = [NSThread callStackSymbols];
        handleCrashException(JJExceptionGuardDictionaryContainer,[NSString stringWithFormat:@"NSMutableDictionary setObject invalid object:%@ and key:%@",object,key],self,@{@"callStack":stack});
    }
}

- (void) hookRemoveObjectForKey:(id)key {
    if (key) {
        [self hookRemoveObjectForKey:key];
    } else {
        NSArray *stack = [NSThread callStackSymbols];
        handleCrashException(JJExceptionGuardDictionaryContainer,@"NSMutableDictionary removeObjectForKey nil key",self,@{@"callStack":stack});
    }
}

- (void) hookSetObject:(id)object forKeyedSubscript:(id<NSCopying>)key {
    if (key) {
        [self hookSetObject:object forKeyedSubscript:key];
    } else {
        NSArray *stack = [NSThread callStackSymbols];
        handleCrashException(JJExceptionGuardDictionaryContainer,[NSString stringWithFormat:@"NSMutableDictionary setObject object:%@ and forKeyedSubscript:%@",object,key],self,@{@"callStack":stack});
    }
}

@end
