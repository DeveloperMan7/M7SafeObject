//
//  NSMutableDictionary+Safe.m
//  SafeObjectCrash
//
//  Created by Im7 on 2021/8/23.
//

#import <objc/runtime.h>
#import "NSObject+Swizzling.h"
#import "NSMutableDictionary+Safe.h"

@implementation NSMutableDictionary (Safe)
#pragma mark --- init method
#if DEBUG
#else
+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 替换 removeObjectForKey:
        NSString *tmpRemoveStr = @"removeObjectForKey:";
        NSString *tmpSafeRemoveStr = @"safeMutable_removeObjectForKey:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSDictionaryM")
                                     originalSelector:NSSelectorFromString(tmpRemoveStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRemoveStr)];
        
        
        
        // 替换 setObject:forKey:
        NSString *tmpSetStr = @"setObject:forKey:";
        NSString *tmpSafeSetRemoveStr = @"safeMutable_setObject:forKey:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSDictionaryM")
                                     originalSelector:NSSelectorFromString(tmpSetStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSetRemoveStr)];
        
    });
    
}
#endif
#pragma mark --- implement method

/**
 根据akey 移除 对应的 键值对
 
 @param aKey key
 */
- (void)safeMutable_removeObjectForKey:(id<NSCopying>)aKey {
    if (!aKey) {
        return;
    }
    [self safeMutable_removeObjectForKey:aKey];
}

/**
 将键值对 添加 到 NSMutableDictionary 内
 
 @param anObject 值
 @param aKey 键
 */
- (void)safeMutable_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject) {
        return;
    }
    if (!aKey) {
        return;
    }
    return [self safeMutable_setObject:anObject forKey:aKey];
}

@end
