//
//  PasswordCheckView.h
//  PasswordEvaluator
//
//  Created by Christophe Biocca on 2015-11-19.
//  Copyright © 2015 Christophe Biocca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordCheckView : UIView

@property(nonatomic,readonly)UITextField* input;
@property(nonatomic,readonly)UIProgressView* progressBar;
@property(nonatomic,readonly)UILabel* crackTimeLabel;
@property(nonatomic,readonly)UILabel* warningLabel;

@end
