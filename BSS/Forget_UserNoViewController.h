//
//  Forget_UserNoViewController.h
//  BSS
//
//  Created by zhangbo on 13-9-18.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Forget_UserNoViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *_txtPhoneNum;
    UIButton *_btnNext;
    
    CGFloat _width;
    CGFloat _height;
}

@end
