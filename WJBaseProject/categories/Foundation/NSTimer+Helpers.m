//
//  NSTimer+Helpers.m
//  WJBaseProject
//
//  Created by 王杰 on 2019/3/21.
//  Copyright © 2019 和信金谷. All rights reserved.
//

#import "NSTimer+Helpers.h"

@implementation NSTimer (Helpers)

+ (NSTimer *)wj_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void(^)(NSTimer *timer))block
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(wj_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}
+ (void)wj_blockInvoke:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

@end
