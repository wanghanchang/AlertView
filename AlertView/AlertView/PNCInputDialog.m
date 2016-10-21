//
//  PNCInputDialog.m
//  Project61
//
//  Created by hzpnc on 15/7/8.
//  Copyright (c) 2015年 hzpnc. All rights reserved.
//

#import "PNCInputDialog.h"
#import "PNCDialogView.h"
#import "Masonry.h"

@interface PNCDialogViewInput : PNCDialogView

@property (nonatomic, strong) UITextField*  textField;
@property (nonatomic, strong) NSArray*  buttonTitles;
@property UILabel*      hintLabel;   //问题框
@property UILabel*      titleLabel;  //头现在没了.
@property (nonatomic,strong) UIView*   buttonContainer;
@property (copy) PNCDialogInputOnSubmitBlock event;
@property (weak) PNCDialog* dialog;

@end

@interface PNCDialogViewInput ()<UITextFieldDelegate>

@end

@implementation PNCDialogViewInput

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.containerView.layer.cornerRadius = 5;
        self.containerView.layer.masksToBounds = YES;
        self.titleLabel = [[UILabel alloc] init];
        self.textField = [[UITextField alloc] init];
        self.textField.delegate = self;
        self.buttonContainer = [[UIView alloc] init];
        
        self.hintLabel = [[UILabel alloc] init];
        [self.containerView addSubview:self.textField];
        [self.containerView addSubview:self.hintLabel];
        [self.containerView addSubview:self.buttonContainer];
        
        return self;
    }
    return nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.textField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 7) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.spliter.layer.opacity = 0.0f;

    self.hintLabel.textColor = [UIColor colorFromHexString:@"#444444"];
    self.hintLabel.font = [UIFont systemFontOfSize:16];
    self.textField.backgroundColor = [UIColor colorFromHexString:@"#eeeeee"];
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView.mas_left).with.offset(10);
        make.right.mas_equalTo(self.containerView.mas_right).with.offset(-10);
        make.top.mas_equalTo(self.containerView.mas_top).with.offset(10);
        make.height.mas_equalTo(30);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hintLabel.mas_left);
        make.right.mas_equalTo(self.hintLabel.mas_right);
        make.top.mas_equalTo(self.hintLabel.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
    [self.buttonContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView.mas_left);
        make.right.mas_equalTo(self.containerView.mas_right);
        make.bottom.mas_equalTo(self.containerView.mas_bottom);
        make.height.mas_equalTo(66);
    }];

    if(self.buttonTitles) {
        assert(self.buttonTitles.count <= 2 && self.buttonTitles.count > 0);
        
        if(self.buttonTitles.count == 2) {
            NSString* buttonTitle1 = self.buttonTitles[0];
            NSString* buttonTitle2 = self.buttonTitles[1];
            
            UIButton* button1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button1 setTitle:buttonTitle1 forState:UIControlStateNormal];
            button1.layer.cornerRadius = 22;
            button1.layer.masksToBounds = YES;
            [button1 setBackgroundImage:[UIColor imageFromHexString:@"#33cc66"] forState:(UIControlStateNormal)];
            [button1 setBackgroundImage:[UIColor imageFromHexString:@"#008000"] forState:UIControlStateHighlighted];
            [button1 setTitleColor:[UIColor colorFromHexString:@"#ffffff"] forState:UIControlStateHighlighted];
            [button1 setTitleColor:[UIColor colorFromHexString:@"#ffffff"] forState:UIControlStateNormal];
            [button1.titleLabel setFont: [button1.titleLabel.font fontWithSize:17]];
            [button1 setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            [self.buttonContainer addSubview:button1];
            
            [button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button2 setTitle:buttonTitle2 forState:UIControlStateNormal];
            [self.buttonContainer addSubview:button2];
            button2.backgroundColor = [UIColor clearColor];
            button2.layer.cornerRadius = 22;
            button2.layer.masksToBounds = YES;
            button2.layer.borderWidth = 1;
            button2.layer.borderColor = [UIColor colorFromHexString:@"#999999"].CGColor;
            [button2 setBackgroundImage:[UIColor imageFromHexString:@"#ffffff"] forState:(UIControlStateNormal)];
            [button2 setTitleColor:[UIColor colorFromHexString:@"#999999"] forState:UIControlStateNormal];
            [button2 setBackgroundImage:[UIColor imageFromHexString:@"#999999"] forState:UIControlStateHighlighted];
            [button2 setTitleColor:[UIColor colorFromHexString:@"#ffffff"] forState:UIControlStateHighlighted];
            [button2 setBackgroundImage:[UIColor imageFromHexString:@"#CCCCCC"] forState:UIControlStateDisabled];
            
            [button2 addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
            
            [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.buttonContainer.mas_left).with.offset(30);
                make.centerY.mas_equalTo(self.buttonContainer.mas_centerY);
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(44);
            }];
            
            [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.buttonContainer.mas_right).with.offset(-30);
                make.centerY.mas_equalTo(self.buttonContainer);
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(44);
            }];
        } else {
            UIButton* button3 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button3 addTarget:self action:@selector(button3Click) forControlEvents:UIControlEventTouchUpInside];
            [button3 setTitle:[self.buttonTitles firstObject] forState:UIControlStateNormal];
            [button3.titleLabel setFont: [button3.titleLabel.font fontWithSize:14]];
            button3.layer.cornerRadius = 22;
            button3.layer.masksToBounds = YES;
            [button3 setTitleColor:[UIColor colorFromHexString:@"#ffffff"] forState:UIControlStateNormal];
            [button3 setTitleColor:[UIColor colorFromHexString:@"#ffffff"] forState:UIControlStateHighlighted];
            [button3 setBackgroundImage:[UIColor imageFromHexString:@"#ff3333"] forState:UIControlStateNormal];
            [button3 setBackgroundImage:[UIColor imageFromHexString:@"#800000"] forState:UIControlStateHighlighted];
            [button3 setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            [self.buttonContainer addSubview:button3];
            [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self.buttonContainer);
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(44);
            }];
        }
    }
    [self.textField becomeFirstResponder];
}

- (void)button1Click {
    self.event(self.dialog,self.textField.text, 0);
}

- (void)button2Click {
    self.event(self.dialog,self.textField.text, 1);
}

- (void)button3Click {
    self.event(self.dialog,self.textField.text, 0);
}


@end

@implementation PNCInputDialog

+ (instancetype)inputWithTitle:(NSString *)title
                       andHint:(NSString *)hint
                 andOriginText:(NSString *)originText
          containsButtonTitles:(NSArray*)buttonTitles
                andCommitBlock:(PNCDialogInputOnSubmitBlock)block {
    
    PNCInputDialog* dialog = [[PNCInputDialog alloc] init];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    CGSize retSize = [hint boundingRectWithSize:CGSizeMake(250, 0)
                                           options:\
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    NSLog(@"%@", NSStringFromCGSize(retSize));
    CGFloat num = retSize.height > 60 ? retSize.height + 150 : 200;

    PNCDialogViewInput* input = [[PNCDialogViewInput alloc] initWithFrame:CGRectMake(0, 0, 300, num)];
    input.textField.placeholder = originText;
    input.titleLabel.text = title;
    input.hintLabel.text = hint;
    input.event = block;
    input.dialog = dialog;
    input.buttonTitles = buttonTitles;
    dialog.contentView = input;
    
    return dialog;
}

@end
