//
//  ActivityIndicator.m
//  BSS
//
//  Created by zhangbo on 13-9-23.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "ActivityIndicator.h"

@implementation ActivityIndicator

+(void)hideActivity:(UIButton *)button
{
    UIActivityIndicatorView *aiLogin=(UIActivityIndicatorView *) [button.subviews lastObject];
    if(aiLogin)
    {
        [aiLogin stopAnimating];
        aiLogin.hidden=YES;
    }
}

+(void)showActivity:(UIButton *)button
{
    UIActivityIndicatorView *aiLogin=(UIActivityIndicatorView *) [button.subviews lastObject];
    aiLogin.hidden=NO;
    [aiLogin startAnimating];
}

@end
