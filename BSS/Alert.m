//
//  Alert.m
//  BSS
//
//  Created by zhangbo on 13-9-22.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "Alert.h"

@implementation Alert

+(void)show:(NSString *)str
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:str message:NULL delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

@end
