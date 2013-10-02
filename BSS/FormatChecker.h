//
//  Reminder.h
//  TestPattern
//
//  Created by liuc on 13-9-17.
//  Copyright (c) 2013年 liuc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormatChecker : NSObject

#pragma 检测手机号码格式
+(BOOL)checkPhoneNumber:(NSString *)phone;
#pragma 检测密码格式
+(BOOL)checkPassword:(NSString *)password;
#pragma 检测电子邮箱格式
+(BOOL)checkEmail:(NSString *)email;
#pragma 检测用户姓名格式
+(BOOL)checkUserName:(NSString *)userName;
#pragma 检测公司名称格式
+(BOOL)checkCompanyName:(NSString *)companyName;
#pragma 检测公司地址格式
+(BOOL)checkCompanyAddress:(NSString *)address;
#pragma 检测职位格式
+(BOOL)checkPost:(NSString *)post;
#pragma 检测QQ号码格式
+(BOOL)checkQQNum:(NSString *)qq;

@end
