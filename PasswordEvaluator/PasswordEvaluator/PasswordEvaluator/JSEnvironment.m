//
//  JSEnvironment.m
//  PasswordEvaluator
//
//  Created by Christophe Biocca on 2015-11-19.
//  Copyright © 2015 Christophe Biocca. All rights reserved.
//

#import "JSEnvironment.h"
#import <JavaScriptCore/JSVirtualMachine.h>
#import "TimerSystem.h"

@implementation JSEnvironment{
    JSVirtualMachine* vm;
    JSContext* context;
    TimerSystem* timers;
}

-(id)initWithNativePage:(id)nativePage{
    if((self = [super init])){
        vm = [JSVirtualMachine new];
        context = [[JSContext alloc] initWithVirtualMachine:vm];
        timers = [[TimerSystem alloc] init];
        
        [context setExceptionHandler:^(JSContext* ctx, JSValue* value){
            NSLog(@"JSValue: %@ [%@]", value, [value valueForProperty:@"stack"]);
        }];
        
        context[@"setTimeout"] = ^(JSValue* function,double timeout){
            return [timers setTimeout:timeout forFunction:function];
        };
        
        context[@"clearTimeout"] = ^(int timeoutID){
            [timers clearTimeout:timeoutID];
        };
        
        context[@"nativePage"] = nativePage;
        
        {
            for (NSString* libraryName in
                 @[@"underscore-min", @"zxcvbn",@"app"]){
                NSURL* libraryURL = [[NSBundle mainBundle] URLForResource:libraryName withExtension:@"js"];
                NSError* libraryLoadError = nil;
                NSString* library = [NSString stringWithContentsOfURL:libraryURL encoding:NSUTF8StringEncoding error:&libraryLoadError];
                NSAssert1(!libraryLoadError, @"Couldn't load library (%@)", libraryLoadError);
                [context evaluateScript:library];
            }
        }
    }
    
    return self;
}

@end
