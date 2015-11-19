//
//  TimerSystem.h
//  Encircle
//
//  Created by Christophe Biocca on 2013-07-14.
//
//

#import <JavaScriptCore/JavaScriptCore.h>

@class JSRuntime;

@interface TimerSystem : NSObject{
    NSMutableDictionary* timers;
    NSMutableDictionary* callbacks;
    int nextID;
    BOOL sorted;
}

-(id)init;

-(int)setTimeout:(double)timeout forFunction:(JSValue*)function;
-(void)clearTimeout:(int)timeout;

@end
