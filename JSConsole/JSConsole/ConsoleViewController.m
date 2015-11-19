//
//  ViewController.m
//  JSConsole
//
//  Created by Christophe Biocca on 2015-11-19.
//  Copyright © 2015 Christophe Biocca. All rights reserved.
//

#import "ConsoleViewController.h"
#import "ConsoleView.h"
#import <JavaScriptCore/JSVirtualMachine.h>

@interface ConsoleViewController ()

@end

@implementation ConsoleViewController{
    JSVirtualMachine* vm;
    JSContext* context;
}

-(void)awakeFromNib{
    vm = [JSVirtualMachine new];
    context = [[JSContext alloc] initWithVirtualMachine:vm];
}

-(void)loadView{
    [self setView:[[ConsoleView alloc] initWithFrame:CGRectZero]];
}

-(void)viewDidLoad{
    ConsoleView* view = (ConsoleView*)[self view];
    [[view run] addTarget:self action:@selector(runCode:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)runCode:(UIButton*)notifier{
    ConsoleView* view = (ConsoleView*)[self view];
    NSString* code = [[view input] text];
    JSValue* returnValue = [context evaluateScript:code];
    NSString* result = [returnValue toString];
    [[view output] setText:result];
}

@end
