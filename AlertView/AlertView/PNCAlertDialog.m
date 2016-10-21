//
//  PNCAlertDialog.m
//  
//
//  Created by hzpnc on 15/7/8.
//
//

#import "PNCAlertDialog.h"

#define CriterionSpace          16
#define kTextFont               16
#define kMessagePadding         20
#define kButtonHeight           44

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation PNCDialogViewAlert

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc] init];
        self.messageLabel = [[UILabel alloc] init];
        self.buttonContainer = [[UIView alloc] init];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        return self;
    }
    return nil;
}

- (void)layoutSubviews {
    [self initSubViews];
    [super layoutSubviews];
}

- (UIView *)spliterline {
    if (!_spliterline) {
        _spliterline = [[UIView alloc] init];
        _spliterline.backgroundColor = [UIColor colorFromHexString:@"#33cc66"];
    }
    return _spliterline;
}

- (UIView *)spliterMidLine {
    if (!_spliterMidLine) {
        _spliterMidLine = [[UIView alloc] init];
        _spliterMidLine.backgroundColor = [UIColor colorFromHexString:@"33cc66"];
    }
    return _spliterMidLine;
}


- (void)button1Click {
    self.event(self.dialog, 0);
}

- (void)button2Click {
    self.event(self.dialog, 1);
}

- (void)button3Click {
    self.event(self.dialog, 0);
}

- (void) initSubViews {
    self.titleLabel.text = self.title;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:kTextFont];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIView *upView = [UIView new];
    [self addSubview:upView];
    [upView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(-66);
    }];
    
    [upView addSubview:self.messageLabel];
   
    self.messageLabel.text = self.message;
    self.messageLabel.textColor = [UIColor colorFromHexString:@"#333333"];
    self.messageLabel.font = [UIFont systemFontOfSize:kTextFont];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.numberOfLines = 0;
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(15);
        make.right.mas_equalTo(self.mas_right).with.offset(-15);
        make.height.mas_equalTo(self.messageLabel.mas_height);
        make.centerY.mas_equalTo(upView.mas_centerY);
    }];
    
    [self addSubview:self.buttonContainer];
    [self.buttonContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.top.mas_equalTo(upView.mas_bottom);

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
            [button1 setBackgroundImage:[UIColor imageFromHexString:@"#33cc66" alpha:0.7] forState:UIControlStateHighlighted];
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
            [button3 setBackgroundImage:[UIColor imageFromHexString:@"#ff3333" alpha:0.7] forState:UIControlStateHighlighted];
            [button3 setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            [self.buttonContainer addSubview:button3];
            [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self.buttonContainer);
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(44);
            }];
        }
    }
}

@end

@implementation PNCAlertDialog

+(instancetype)alertWithTitle:(NSString *)title
                   andMessage:(NSString *)message
         containsButtonTitles:(NSArray *)buttonTitles
         buttonTapEventsBlock:(PNCDialogButtonTapEvent)event {
    return [PNCAlertDialog alertWithTitle:title
                               andMessage:message
                     containsButtonTitles:buttonTitles
                   hideWhenTouchUpOutside:YES
                     buttonTapEventsBlock:event];
}

+ (instancetype)forceAlertWithTitle:(NSString*)title
                         andMessage:(NSString*)message
               containsButtonTitles:(NSArray*)buttonTitles
               buttonTapEventsBlock:(PNCDialogButtonTapEvent)event {
    return [PNCAlertDialog alertWithTitle:title
                        andMessage:message
              containsButtonTitles:buttonTitles
            hideWhenTouchUpOutside:NO
              buttonTapEventsBlock:event];
}

+ (instancetype)alertWithTitle:(NSString*)title
                    andMessage:(NSString*)message
          containsButtonTitles:(NSArray*)buttonTitles
        hideWhenTouchUpOutside:(BOOL)hideWhenTouchUpOutside
          buttonTapEventsBlock:(PNCDialogButtonTapEvent)event {
    
    PNCAlertDialog* dialog = [[PNCAlertDialog alloc] init];
    dialog.hideWhenTouchUpOutside = hideWhenTouchUpOutside;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    CGSize retSize = [message boundingRectWithSize:CGSizeMake(250, 0)
                                          options:\
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    CGFloat num = retSize.height > 60 ? retSize.height + 150 : 200;
    
    PNCDialogViewAlert* view = [[PNCDialogViewAlert alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH * 0.8, num)];
    view.title = title;
    view.message = message;
    view.buttonTitles = buttonTitles;
    view.event = event;
    view.dialog = dialog;
    
    dialog.contentView = view;
    
    return dialog;
}

@end
