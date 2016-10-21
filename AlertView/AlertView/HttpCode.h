//
//  HttpCode.h
//  PersonalRecord
//
//  Created by 匹诺曹 on 16/7/21.
//  Copyright © 2016年 匹诺曹. All rights reserved.
//

#ifndef HttpCode_h
#define HttpCode_h

#define     HTTP_OK                 0               //正常返回
#define  REDIS_FAULT                100001			//redis服务器错误（服务器内部错误）
#define  DB_ERROR                   100002          //数据库错误（服务器内部错误）
#define  UNMESSAGE                  10001			//短信未收到
#define  REGISTERED                 10005			//用户已注册/已存在
#define  REGISTERED_UNPWD           10006			//用户已注册(即老用户),但未设置4位新密码
#define  UNREGISTERED               10007			//用户未注册(即新用户)
#define  REGISTERED_PWD             10008           //用户已注册(即老用户),且已设置4位新密码
#define  REGISTERED_NOT_TOURIST     10009			//设备号已被手机账号绑定，无法以游客身份登录
#define  NULL_RESULT                10100			//返回数据为空
#define  VALIDATE_ERROR             20000			//旧密码验证错误(修改密码接口)
#define  SESSION_EXPIRED            20001			//session过期
#define  ERR_USER_OR_PWD            20003			//登陆用户名或密码错误
#define  VERIFY_CODE_INVALIDATE     20011			//验证码已经失效
#define  VERIFY_CODE_ERR            20012			//验证码不正确
#define  PARAMETER_ERR              90001			//参数错误，pos > alllength等

#endif /* HttpCode_h */


