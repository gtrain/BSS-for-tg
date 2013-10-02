//
//  Reminder.m
//  TestPattern
//
//  Created by liuc on 13-9-17.
//  Copyright (c) 2013年 liuc. All rights reserved.
//

#import "FormatChecker.h"

@implementation FormatChecker

+(BOOL)checkPhoneNumber:(NSString *)phone{
    NSString *patternUserNo = @"^(13[0-9]|15[0|3|6|7|8|9]|18[0,5-9])\\d{8}$";
    
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:patternUserNo options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger num = [re numberOfMatchesInString:phone options:NSMatchingReportProgress range:NSMakeRange(0, phone.length)];
    
    return num > 0;
}

+(BOOL)checkQQNum:(NSString *)qq{
    NSString *patternQQ = @"^[0-9]{4,20}$";
    
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:patternQQ options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger num = [re numberOfMatchesInString:qq options:NSMatchingReportProgress range:NSMakeRange(0, qq.length)];
    
    return num > 0;
}


+(BOOL)checkPassword:(NSString *)password{
    NSString *patternPassword = @"^[0-9a-zA-Z~`\\!\\@#\\$%\\^&\\*\\(\\)\\-_\\+=\\[\\]\\{\\}:;\\|\\\\\\<\\>\\?\\/]{6,16}$";
    
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:patternPassword options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger num = [re numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    return num > 0;
}
+(BOOL)checkEmail:(NSString *)email{
  
    return NO;
}

+(BOOL)checkUserName:(NSString *)userName{
    NSString *patternUserName = @"^[\u4E00-\u9FA5]{2,4}$";
    
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:patternUserName options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger num = [re numberOfMatchesInString:userName options:NSMatchingReportProgress range:NSMakeRange(0, userName.length)];
    
    return num > 0;
}

+(BOOL)checkCompanyName:(NSString *)companyName{

    NSString *patterncompanyName = @"^[\u4E00-\u9FA5|0-9a-zA-Z]{3,20}$";
    
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:patterncompanyName options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger num = [re numberOfMatchesInString:companyName options:NSMatchingReportProgress range:NSMakeRange(0, companyName.length)];
    
    return num > 0;
}


+(BOOL)checkCompanyAddress:(NSString *)address{
    NSString *patternAddress = @"^[\u4E00-\u9FA5|0-9a-zA-Z|()（）\\-\\-]{3,50}$";
    
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:patternAddress options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger num = [re numberOfMatchesInString:address options:NSMatchingReportProgress range:NSMakeRange(0, address.length)];
    
    return num > 0;
}

+(BOOL)checkPost:(NSString *)post{
    if(post == nil){
        return NO;
    }else{
        int len = post.length;
        if(len <2 ||len>4){
            return NO;
        }
    }
    NSString *patternPost = @"^[\u4E00-\u9FA5]+$";
    
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:patternPost options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger num = [re numberOfMatchesInString:post options:NSMatchingReportProgress range:NSMakeRange(0, post.length)];
    
    return num > 0;
}

@end
