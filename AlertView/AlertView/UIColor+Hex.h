//
//  UIColor+Hex.h
//  Project61
//
//  Created by hzpnc on 15/6/2.
//  Copyright (c) 2015年 hzpnc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorFromHexString:(NSString *)hexString;

+ (UIImage*)imageFromHexString:(NSString*)hexString;

+ (UIImage*) createImageFromColor: (UIColor*) color;

+ (UIImage*)imageFromHexString:(NSString*)hexString alpha:(float)alpha;

@end
