//
//  ConsoleView.m
//  JSConsole
//
//  Created by Christophe Biocca on 2015-11-19.
//  Copyright © 2015 Christophe Biocca. All rights reserved.
//

#import "ConsoleView.h"

@implementation ConsoleView{
    UIScrollView* scroll;
    UITextView* input;
    UIButton* run;
    UITextView* output;
}

@synthesize input, run, output;

-(id)initWithFrame:(CGRect)frame{
    if((self = [super initWithFrame:frame])){
        scroll = [[UIScrollView alloc] initWithFrame:frame];
        [self addSubview:scroll];
        input = [[UITextView alloc] initWithFrame:CGRectZero];
        [[input layer] setBorderColor:[[UIColor blackColor] CGColor]];
        [[input layer] setBorderWidth:1];
        [input setClipsToBounds:YES];
        [input setText:@"(function(){return 1+1;})()"];
        [input setFont:[UIFont systemFontOfSize:16]];
        [scroll addSubview:input];
        run = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [run setTitle:@"Run" forState:UIControlStateNormal];
        [scroll addSubview:run];
        output = [[UITextView alloc] initWithFrame:CGRectZero];
        [output setEditable:NO];
        [[output layer] setBorderColor:[[UIColor blackColor] CGColor]];
        [[output layer] setBorderWidth:1];
        [output setClipsToBounds:YES];
        [output setFont:[UIFont boldSystemFontOfSize:16]];
        [scroll addSubview:output];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(void)layoutSubviews{
    CGRect bounds = [self bounds];
    bounds.origin.y += 20;
    bounds.size.height -= 20;
    [scroll setFrame:bounds];
    CGRect inputFrame = {
        .size = {
            .width = bounds.size.width,
            .height = (bounds.size.height - 40)/2,
        },
    };
    CGRect buttonFrame = {
        .origin = {
            .y = inputFrame.origin.y + inputFrame.size.height,
        },
        .size = {
            .width = bounds.size.width,
            .height = 40,
        },
    };
    CGRect outputFrame = {
        .origin = {
            .y = buttonFrame.origin.y + buttonFrame.size.height,
        },
        .size = {
            .width = bounds.size.width,
            .height = (bounds.size.height - 40)/2,
        }
    };
    [input setFrame:inputFrame];
    [run setFrame:buttonFrame];
    [output setFrame:outputFrame];
    [scroll setContentSize:(CGSize){
        .width = bounds.size.width,
        .height = 2*bounds.size.height,
    }];
}

@end
