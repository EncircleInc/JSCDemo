//
//  ConsoleView.h
//  JSConsole
//
//  Created by Christophe Biocca on 2015-11-19.
//  Copyright © 2015 Christophe Biocca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsoleView : UIView

@property(nonatomic,readonly)UITextView* input;
@property(nonatomic,readonly)UIButton* run;
@property(nonatomic,readonly)UITextView* output;

@end
