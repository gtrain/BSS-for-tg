//
//  Global.h
//  BSS
//
//  Created by YANGZQ on 13-9-11.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#ifndef BSS_Global_h
#define BSS_Global_h

#define kAuthURL        @"https://auth.tgnet.com:443/"
#define kBaseURL        @"https://ys.tgnet.com:444/"

#define AppDelegateShare ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define kScreenBoundsSize [UIScreen mainScreen].bounds.size
#define kMainColor [UIColor colorWithRed:.9 green:.4 blue:.0 alpha:1.0]
#define kNavBarHeight       44.0
#define kRowHeight          66.0

//#ifdef DEBUG
#ifndef DLog
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#endif
#ifndef ELog
#   define ELog(err) {if(err) DLog(@"%@", err)}
#endif
//#endif


#endif
