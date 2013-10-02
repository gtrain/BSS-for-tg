//
//  Res_UserInfoViewController.h
//  BSS
//
//  Created by zhangbo on 13-9-18.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Res_UserInfoViewController : UIViewController<UITextFieldDelegate>
{
    NSString *_strPhoneNum;
    UILabel *_lblPhoneNum;
    UITextField *_txtUserName;
    UITextField *_txtCompanyName;
    UITextField *_txtPassword;
    
    CGFloat _width;
    CGFloat _height;
}

-(id)initWithPhoneNum:(NSString *)phoneNum;

@end
