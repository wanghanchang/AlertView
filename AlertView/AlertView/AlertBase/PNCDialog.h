//
//  PNCDialog.h
//  Project61
//
//  Created by hzpnc on 15/7/8.
//  Copyright (c) 2015年 hzpnc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIColor+Hex.h"

#define STYLE_BUTTON_1(button) \
[button.titleLabel setFont: [button.titleLabel.font fontWithSize:17]];\
[button setTitleColor:[UIColor colorFromHexString:@"#2f74bb"] forState:UIControlStateNormal];\
[button setTitleColor:[UIColor colorFromHexString:@"#7b9bc6"] forState:UIControlStateDisabled];\
[button setTitleColor:[UIColor colorFromHexString:@"#ffffff"] forState:UIControlStateHighlighted];\
[button setBackgroundImage:[UIColor imageFromHexString:@"#eeeeee"] forState:UIControlStateNormal];\
[button setBackgroundImage:[UIColor imageFromHexString:@"#2f74bb"] forState:UIControlStateHighlighted];\
[button setBackgroundImage:[UIColor imageFromHexString:@"#cccccc"] forState:UIControlStateDisabled];\
[button setContentEdgeInsets:UIEdgeInsetsMake(10, 30, 10, 30)];\
[button.layer setBorderColor:[UIColor colorFromHexString:@"#2f74bb"].CGColor];\
[button.layer setBorderWidth:1];\
[button.layer setCornerRadius:9.0f];\
[button.layer setMasksToBounds:YES];

#define STYLE_BUTTON_7(button) \
[button.titleLabel setFont: [button.titleLabel.font fontWithSize:14]];\
[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];\
[button setBackgroundImage:[UIColor imageFromHexString:@"#47a8ef"] forState:UIControlStateNormal];\
[button setBackgroundImage:[UIColor imageFromHexString:@"#3883cf"] forState:UIControlStateHighlighted];\
[button setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];\
[button.layer setCornerRadius:5.0f];\
[button.layer setMasksToBounds:YES];
@class PNCDialog;

typedef void(^PNCDialogButtonTapEvent)(PNCDialog* dialog, int buttonIndex);

@interface PNCDialog : UIView

@property (nonatomic, strong) UIView*   contentView;

@property BOOL      hideWhenTouchUpOutside;

//显示对话框
- (void)show;

//隐藏对话框
- (void)hide;
//.s后自动隐藏
- (void)hideWithinSecond:(CGFloat)seconds after:(CGFloat)scs;

@end
