//
//  ViewController.h
//  PasswordEvaluator
//
//  Created by Christophe Biocca on 2015-11-19.
//  Copyright © 2015 Christophe Biocca. All rights reserved.
//

#import <JavaScriptCore/JSExport.h>
#import <UIKit/UIViewController.h>

@protocol PasswordPage<JSExport>

-(void)setPasswordCallback:(JSValue*)callback;

JSExportAs(setPasswordStrengthInfo,
-(void)setPasswordStrengthScore:(NSInteger)score crackTimeLabel:(NSString*)label warning:(JSValue*)warning
);

@end

@interface PasswordCheckViewController : UIViewController<PasswordPage,UITextFieldDelegate>

@end

