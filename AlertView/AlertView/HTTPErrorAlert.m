
//
//  HTTPErrorAlert.m
//  Project61
//
//  Created by hzpnc on 15/7/9.
//  Copyright (c) 2015年 hzpnc. All rights reserved.
//

#import "HTTPErrorAlert.h"
#import "PNCAlertDialog.h"

static id<UnhandleableErrorhandler> staticHandler;

@implementation HTTPErrorAlert

+ (void)setUnhandleableErrorHandler:(id<UnhandleableErrorhandler>)handler {
    staticHandler = handler;
}

- (void)handleError:(int)error {
    [self handleError:error andData:nil];
}

- (void)handleError:(int)error andData:(id)data {
    NSString* message = [NSString stringWithFormat:@"发生未知的错误(%d),请稍候重试", error];
    
    if (error == REDIS_FAULT) {
        message = @"redis服务器错误";
    }else if (error == DB_ERROR) {
        message = @"数据库错误";
    }else if (error == UNMESSAGE){
        message = @"短信未收到";
    }else if (error == REGISTERED){
        message = @"用户已注册/已存在";
    }else if (error == REGISTERED_UNPWD){
        message = @"用户已注册(即老用户),但未设置4位新密码";
    }else if (error == UNREGISTERED){
        message = @"用户未注册(即新用户)";
    }else if (error == REGISTERED_PWD){
        message = @"用户已注册(即老用户),且已设置4位新密码";
    }else if (error == REGISTERED_NOT_TOURIST){
        message = @"设备号已被手机账号绑定，无法以游客身份登录";
    }else if (error == NULL_RESULT){
        message = @"返回数据为空";
    }else if (error == VALIDATE_ERROR){
        message = @"旧密码验证错误(修改密码接口)";
    }else if (error == SESSION_EXPIRED){
        message = @"session过期";
    }else if (error == ERR_USER_OR_PWD){
        message = @"登陆用户名或密码错误";
    }else if (error == VERIFY_CODE_INVALIDATE) {
        message = @"验证码已经失效";
    }else if (error == VERIFY_CODE_ERR) {
        message = @"验证码不正确";
    }else if (error == PARAMETER_ERR) {
        message = @"网络故障， 请稍后再试";
    } else {
        message = [NSString stringWithFormat:@"发生未知的错误(%d),请稍候重试", error];
    }
    [[PNCAlertDialog alertWithTitle:@"提示"
                         andMessage:message
               containsButtonTitles:@[@"确定"]
               buttonTapEventsBlock:^(PNCDialog *dialog, int buttonIndex) {
                   if(self.callback) {
                       self.callback(error);
                   }
                   [dialog hide];
               }] show];
}

+ (void)handleError:(int)error {
    [[[HTTPErrorAlert alloc] init] handleError:error];
}

+ (void)handleError:(int)error andData:(id)data {
    [[[HTTPErrorAlert alloc] init] handleError:error andData:data];
}

+ (void)handleError:(int)error withCallback:(ErrorHandleCallback)callback {
    HTTPErrorAlert* alert = [[HTTPErrorAlert alloc] init];
    alert.callback = callback;
    [alert handleError:error];
}
@end
