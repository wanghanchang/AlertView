//
//  PNCAutoAlertDialog.m
//  PersonalRecord
//
//  Created by 匹诺曹 on 16/9/2.
//  Copyright © 2016年 匹诺曹. All rights reserved.
//

#import "PNCAutoAlertDialog.h"

@implementation PNCAutoAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.imgView];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor cyanColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.layer.frame.size.width * 4.0
                                       , self.layer.frame.size.height / 3.0 * 2.0);
    self.imgView.frame = CGRectMake(self.bounds.origin.x, self.layer.frame.size.height / 3.0 * 2.0, self.layer.frame.size.width * 4.0
                                    , self.layer.frame.size.height / 3.0 * 2.0 * 2.0);
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.layer.backgroundColor = [UIColor redColor].CGColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor blueColor];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView;
}

@end

@implementation PNCAutoAlertDialog

+ (instancetype)autoAlertWithPic:(NSString *)picName andTitle:(NSString *)titleName {
    PNCAutoAlertDialog *dialog = [[PNCAutoAlertDialog alloc] init];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    CGSize retSize = [titleName boundingRectWithSize:CGSizeMake(250, 0)
                                           options:\
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    CGFloat num = retSize.height > 60 ? retSize.height + 200 : 250;
    
    PNCAutoAlertView* view = [[PNCAutoAlertView alloc] initWithFrame:CGRectMake(0, 0, num, 150)];
    view.titleLabel.text = titleName;
    view.imgView.image = [UIImage imageNamed:picName];
    
    view.dialog  = dialog;
    dialog.contentView = view;
    return dialog;
}

@end
