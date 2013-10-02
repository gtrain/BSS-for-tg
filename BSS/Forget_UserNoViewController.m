//
//  Forget_UserNoViewController.m
//  BSS
//
//  Created by zhangbo on 13-9-18.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "Forget_UserNoViewController.h"
#import "VerificationCodeViewController.h"
#import "FormatChecker.h"
#import "Alert.h"
#import "ActivityIndicator.h"

@interface Forget_UserNoViewController ()

@end

@implementation Forget_UserNoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    UIColor *color=[[UIColor alloc] initWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    self.view.backgroundColor=color;
    
    _width=self.view.bounds.size.width;
    _height=self.view.bounds.size.height;
    
    [self paintLableAndPhoneNum];
    
    [self paintBtnNext];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self setTitleAndBtnBack];
}

#pragma mark 画提示与手机号输入框
-(void)paintLableAndPhoneNum
{
    UILabel *lblTag=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
    
    lblTag.text=@"请输入您的手机号码获得验证码,来重置密码";
    lblTag.textAlignment=UITextAlignmentLeft;
    lblTag.backgroundColor=[UIColor clearColor];
    lblTag.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:lblTag];
    
    
    _txtPhoneNum=[[UITextField alloc] initWithFrame:CGRectMake(10, 40, 300, 40)];
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    _txtPhoneNum.leftView=imgView;
    _txtPhoneNum.leftViewMode=UITextFieldViewModeAlways;
    _txtPhoneNum.backgroundColor=[UIColor whiteColor];
    _txtPhoneNum.layer.cornerRadius=8;
    _txtPhoneNum.placeholder=@"您本人的手机号";
    _txtPhoneNum.font=[UIFont systemFontOfSize:15];
    _txtPhoneNum.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _txtPhoneNum.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    _txtPhoneNum.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    _txtPhoneNum.returnKeyType=UIReturnKeyDone;
    _txtPhoneNum.delegate=self;
    
    [self.view addSubview:_txtPhoneNum];
    
}
#pragma mark 画下一步按钮
-(void)paintBtnNext
{
    _btnNext=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btnNext setTitle:@"下一步" forState:UIControlStateNormal];
    [_btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnNext addTarget:self action:@selector(btnPressToNext:) forControlEvents:UIControlEventTouchUpInside];
    _btnNext.frame=CGRectMake(205, 90, 105, 35);
    [_btnNext setBackgroundImage:[UIImage imageNamed:@"button_orange"] forState:UIControlStateNormal];
    
    UIActivityIndicatorView *aiLogin=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    aiLogin.frame=CGRectMake(_width/2-90, 3.5, 30, 30);
    [_btnNext addSubview:aiLogin];
    
    [self.view addSubview:_btnNext];
}

#pragma mark 设置标题与返回按钮
-(void)setTitleAndBtnBack
{
    [self setTitle:@"请输入您的手机号"];
    UINavigationBar *navigBar=self.navigationController.navigationBar;
    
    [navigBar setBackgroundImage:[UIImage imageNamed:@"bg_title_orange"] forBarMetrics:UIBarMetricsDefault];
    navigBar.hidden=NO;
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(10, 10, 46, 27);
    [btn setBackgroundImage:[UIImage imageNamed:@"button_orange_back"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"button_orange_back_pressed"] forState:UIControlStateHighlighted];
    UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(15, -1, 30, 27)];
    lblTitle.text=@"返回";
    lblTitle.font=[UIFont systemFontOfSize:13];
    lblTitle.textColor=[UIColor whiteColor];
    lblTitle.backgroundColor=[UIColor clearColor];
    [btn addSubview:lblTitle];
    [btn addTarget:self action:@selector(btnPressToBackLogin) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btnBack=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=btnBack;
}

#pragma mark 返回事件
-(void)btnPressToBackLogin
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 下一步事件
-(void)btnPressToNext:(UIButton *)button
{
    [button setEnabled:NO];
    if(_txtPhoneNum.text.length==0||![FormatChecker checkPhoneNumber:_txtPhoneNum.text])
    {
        [button setEnabled:YES];
        [Alert show:@"手机号码错误,请重新确认"];
    }
    else
    {
        
        [[AFNetEngine shareEngine] opValidMobileFG:_txtPhoneNum.text onSucceeded:^(NSDictionary *dictionary) {
            DLog(@"用户手机验证结果： %@",dictionary);
            if([dictionary[@"state"] isEqual:@"success"])
            {
                [[AFNetEngine shareEngine] opValidCodeFG:_txtPhoneNum.text
                                             onSucceeded:^(NSDictionary *dic) {
                                                 DLog(@"发送验证码的返回数据： %@",dic);
                                                 if([dic[@"state"] isEqual:@"success"])
                                                 {
                                                     VerificationCodeViewController *verifVC=[[VerificationCodeViewController alloc] initWithPhoneNumber:_txtPhoneNum.text forPurpose:2];
                                                     [self.navigationController pushViewController:verifVC animated:YES];
                                                     [button setEnabled:YES];
                                                     [ActivityIndicator hideActivity:button];
                                                 }
                                                 
                                             } onError:^(RESTError *engineError) {
                                                 [button setEnabled:YES];
                                                 ELog(engineError);
                                                 [Alert show:engineError.errorDescription];
                                                 [ActivityIndicator hideActivity:button];
                                             }];
            }
        } onError:^(RESTError *engineError) {
            ELog(engineError);
            [button setEnabled:YES];
            [Alert show:engineError.errorDescription];
            [ActivityIndicator hideActivity:button];
        }];
    }
    [ActivityIndicator showActivity:button];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
