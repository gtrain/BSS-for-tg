//
//  VirificationCodeViewController.h
//  BSS
//
//  Created by zhangbo on 13-9-18.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FOR_REGISTER 1
#define FOR_FINDPASSWORD 2

@interface VerificationCodeViewController : UIViewController<UITextFieldDelegate>
{
    NSString *_strPhoneNum;
    UIActivityIndicatorView *_rollingView;
}
@property (nonatomic ,strong) UILabel *lblDetail;
@property (nonatomic ,strong) UIButton *btnNext;
@property (nonatomic ,strong) UITextField *txtfCode;

@property (nonatomic ,strong) UILabel *lblNoCodeReceived;
@property (nonatomic ,strong) UIButton *btnSendCodeAgain;

@property (nonatomic ,strong) NSString *contentDetail;
@property long timeInMillis;

@property CGFloat width;
@property CGFloat heihgt;

@property int timeForCountDown;
@property BOOL isTimerRunning;

@property int purpose;

-(id)initWithPhoneNumber:(NSString *)num forPurpose:(int)purpose;

@end
