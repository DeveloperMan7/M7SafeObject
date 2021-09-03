//
//  NSObject+Swizzling.h
//  SafeObjectCrash
//
//  Created by Im7 on 2021/8/23.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)
+ (void)exchangeInstanceMethodWithSelfClass:(Class)selfClass
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector;
@end
