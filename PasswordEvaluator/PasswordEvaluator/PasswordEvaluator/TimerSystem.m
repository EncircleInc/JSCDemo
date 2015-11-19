//
//  TimerSystem.m
//  Encircle
//
//  Created by Christophe Biocca on 2013-07-14.
//
//

#import "TimerSystem.h"

@implementation TimerSystem

-(id)init{
    if((self = [super init])){
        timers = [[NSMutableDictionary alloc] initWithCapacity:1024];
        callbacks = [[NSMutableDictionary alloc] initWithCapacity:1024];
    }
    return self;
}

-(int)addTimerForFunction:(JSValue*)function interval:(NSTimeInterval)interval{
    int timerID;
    @synchronized(self){
        timerID = ++nextID;
        NSNumber* timerIDNumber = @(timerID);
        NSTimer* timer = [NSTimer timerWithTimeInterval:interval
                                                 target:self
                                               selector:@selector(fire:)
                                               userInfo:@{@"id":timerIDNumber}
                                                repeats:NO];
        [callbacks setObject:function forKey:timerIDNumber];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [timers setObject:timer forKey:timerIDNumber];
    }
    return timerID;
}

-(void)fire:(NSTimer*)timer{
    NSDictionary* info = [timer userInfo];
    NSNumber* idNumber = [info objectForKey:@"id"];
    JSValue* callback = [callbacks objectForKey:idNumber];
    [callback callWithArguments:@[]];
    @synchronized(self){
        [timers removeObjectForKey:idNumber];
        [callbacks removeObjectForKey:idNumber];
    }
}

-(void)removeTimerID:(int)timerID{
    @synchronized(self){
        NSNumber* key = @(timerID);
        NSTimer* timer = [timers objectForKey:key];
        [timer performSelectorOnMainThread:@selector(invalidate) withObject:nil waitUntilDone:NO];
        [timers removeObjectForKey:key];
        [callbacks removeObjectForKey:key];
    }
}

-(int)setTimeout:(double)timeout forFunction:(JSValue*)function{
    return [self addTimerForFunction:function interval:timeout/1000];
}

-(void)clearTimeout:(int)timeout{
    [self removeTimerID:timeout];
}

@end
