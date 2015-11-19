//
//  ViewController.m
//  PasswordEvaluator
//
//  Created by Christophe Biocca on 2015-11-19.
//  Copyright © 2015 Christophe Biocca. All rights reserved.
//

#import "PasswordCheckViewController.h"
#import "PasswordCheckView.h"
#import "JSEnvironment.h"

@interface PasswordCheckViewController ()

@end

@implementation PasswordCheckViewController{
    JSEnvironment* environment;
    JSValue* callback;
}

-(void)awakeFromNib{
    environment = [[JSEnvironment alloc] initWithNativePage:self];
}

-(void)loadView{
    [self setView:[[PasswordCheckView alloc] initWithFrame:CGRectZero]];
}

-(void)viewDidLoad{
    PasswordCheckView* view = (PasswordCheckView*)[self view];
    UITextField* input = [view input];
    [input setDelegate:self];
}

-(BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    NSString* laterValue = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    [callback callWithArguments:@[laterValue]];
    return YES;
}

-(void)setPasswordCallback:(JSValue*)newCallback{
    callback = newCallback;
}

-(void)setPasswordStrengthScore:(NSInteger)score crackTimeLabel:(NSString *)label warning:(JSValue*)warning{
    PasswordCheckView* view = (PasswordCheckView*)[self view];
    [[view progressBar] setProgress:score/4.0];
    [[view crackTimeLabel] setText:label];
    if([warning isString]){
        [[view warningLabel] setText:[warning toString]];
        [[view warningLabel] setHidden:NO];
    } else {
        [[view warningLabel] setHidden:YES];
    }
    [view setNeedsLayout];
}

@end
