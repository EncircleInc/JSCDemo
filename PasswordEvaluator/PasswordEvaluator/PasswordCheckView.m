
//
//  PasswordCheckView.m
//  PasswordEvaluator
//
//  Created by Christophe Biocca on 2015-11-19.
//  Copyright © 2015 Christophe Biocca. All rights reserved.
//

#import "PasswordCheckView.h"

@implementation PasswordCheckView{
    UITextField* input;
    UIProgressView* progressBar;
    UILabel* crackTimeLabel;
    UILabel* warningLabel;
}

@synthesize input, progressBar, crackTimeLabel, warningLabel;

-(id)initWithFrame:(CGRect)frame{
    if((self = [super initWithFrame:frame])){
        input = [[UITextField alloc] initWithFrame:CGRectZero];
        [input setBorderStyle:UITextBorderStyleRoundedRect];
        [self addSubview:input];
        progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        [self addSubview:progressBar];
        crackTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:crackTimeLabel];
        warningLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [warningLabel setNumberOfLines:0];
        [self addSubview:warningLabel];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(void)layoutSubviews{
    CGSize bounds = [self bounds].size;
    CGSize limit = (CGSize){.width = bounds.width - 10, .height = 600};
    CGRect inputFrame = {
        .origin = {
            .x = 5,
            .y = 25,
        },
        .size = {
            .width = bounds.width - 10,
            .height = 30,
        },
    };
    [input setFrame:inputFrame];
    CGSize progressSize = [progressBar sizeThatFits:limit];
    CGRect progressFrame = {
        .origin = {
            .x = 5,
            .y = inputFrame.origin.y + inputFrame.size.height + 5,
        },
        .size = progressSize,
    };
    [progressBar setFrame:progressFrame];
    CGSize cracktimeSize = [crackTimeLabel sizeThatFits:limit];
    CGRect cracktimeFrame = {
        .origin = {
            .x = 5,
            .y = progressFrame.origin.y + progressFrame.size.height + 5,
        },
        .size = cracktimeSize,
    };
    [crackTimeLabel setFrame:cracktimeFrame];
    CGSize warningSize = [warningLabel sizeThatFits:limit];
    CGRect warningFrame = {
        .origin = {
            .x = 5,
            .y = cracktimeFrame.origin.y + cracktimeFrame.size.height + 5,
        },
        .size = warningSize,
    };
    [warningLabel setFrame:warningFrame];
}

@end
