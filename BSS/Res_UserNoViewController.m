//
//  Res_UserNoViewController.m
//  BSS
//
//  Created by zhangbo on 13-9-18.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "Res_UserNoViewController.h"
#import "FormatChecker.h"
#import "VerificationCodeViewController.h"
#import "TermViewController.h"
#import "LoginViewController.h"
#import "Alert.h"
#import "Location.h"
#import "AppDelegate.h"
#import "ActivityIndicator.h"

@interface Res_UserNoViewController ()

@end

@implementation Res_UserNoViewController

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
    
    _width=self.view.bounds.size.width;
    _height=self.view.bounds.size.height;
    
    //画手机号输入框
    [self paintTxtPhoneNum];
    
    //画checkBox和协议
    [self paintCheckBox];
    
    //画下一步按钮以及登录按钮
    [self paintNextBtnAndLogin];
    
    AppDelegateShare.currentLocation=[[Location alloc] init];
    [AppDelegateShare.currentLocation start];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitleAndBtnBack];
}

#pragma mark 画手机号输入框
-(void)paintTxtPhoneNum
{
    UIColor *color=[[UIColor alloc] initWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    self.view.backgroundColor=color;
    
    _txtPhoneNum=[[UITextField alloc] initWithFrame:CGRectMake(20, 20, 280, 44)];
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
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

#pragma mark 画checkBox和协议
-(void)paintCheckBox
{
    //checkBox
    _btnAgree=[UIButton buttonWithType:UIButtonTypeCustom];
    CGRect checkBoxRect=CGRectMake(10, 64, 36, 36);
    [_btnAgree setFrame:checkBoxRect];
    [_btnAgree setImage:[UIImage imageNamed:@"false"] forState:UIControlStateNormal];
    [_btnAgree setImage:[UIImage imageNamed:@"true"] forState:UIControlStateSelected];
    _btnAgree.selected=YES;
    [_btnAgree addTarget:self action:@selector(agreeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: _btnAgree];
    
    UILabel *lblRead=[[UILabel alloc] initWithFrame:CGRectMake(38, 64, 100,36)];
    lblRead.text=@"已阅读并同意";
    lblRead.font=[UIFont systemFontOfSize:13];
    lblRead.backgroundColor=[UIColor clearColor];
    [self.view addSubview:lblRead];
    
    UIColor *colorFont=[[UIColor alloc] initWithRed:0.4 green:0.6 blue:0.8 alpha:1.0];
    
    _btnTerm=[[UIButton alloc] initWithFrame:CGRectMake(117, 73, 60,20)];
    [_btnTerm setTitle:@"使用条款" forState:UIControlStateNormal];
    [_btnTerm setTitleColor:colorFont forState:UIControlStateNormal];
    _btnTerm.titleLabel.font=[UIFont systemFontOfSize:14];
    [_btnTerm addTarget:self action:@selector(useTerm:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnTerm];
}

#pragma mark 画下一步按钮以及登录按钮
-(void)paintNextBtnAndLogin
{
    UIColor *colorFont=[[UIColor alloc] initWithRed:0.4 green:0.6 blue:0.8 alpha:1.0];
    _btnNext=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btnNext setTitle:@"下一步" forState:UIControlStateNormal];
    [_btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [_btnNext addTarget:self action:@selector(btnPressToNext:) forControlEvents:UIControlEventTouchUpInside];
    _btnNext.frame=CGRectMake(175, 100, 105, 35);
    [_btnNext setBackgroundImage:[UIImage imageNamed:@"button_orange"] forState:UIControlStateNormal];
    
    UIActivityIndicatorView *aiLogin=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    aiLogin.frame=CGRectMake(_width/2-90, 3.5, 30, 30);
    [_btnNext addSubview:aiLogin];
    
    [self.view addSubview:_btnNext];
    
    UILabel *lblUserNo=[[UILabel alloc] initWithFrame:CGRectMake(175, 145, 60,36)];
    lblUserNo.text=@"已有帐号";
    lblUserNo.font=[UIFont systemFontOfSize:11];
    lblUserNo.backgroundColor=[UIColor clearColor];
    [self.view addSubview:lblUserNo];
    
    
    _btnLogin=[[UIButton alloc] initWithFrame:CGRectMake(227, 153, 60,20)];
    [_btnLogin setTitle:@"直接登录" forState:UIControlStateNormal];
    [_btnLogin setTitleColor:colorFont forState:UIControlStateNormal];
    _btnLogin.titleLabel.font=[UIFont systemFontOfSize:14];
    [_btnLogin addTarget:self action:@selector(btnPressToLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnLogin];
}

#pragma mark 设置标题与返回按钮
-(void)setTitleAndBtnBack
{
    [self setTitle:@"填写手机号"];
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

#pragma mark 返回按钮事件
-(void)btnPressToBackLogin
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 同意使用条款事件
-(void)agreeEvent:(UIButton *)btnAgree
{
    if(btnAgree.selected==NO)
    {
        [btnAgree setSelected:YES];
        _btnNext.enabled=YES;
    }
    else
    {
        [btnAgree setSelected:NO];
        _btnNext.enabled=NO;
    }
}

#pragma mark 条款内容事件
-(void)useTerm:(UIButton *)button
{
    [_btnTerm setEnabled:NO];
    TermViewController *term=[[TermViewController alloc] initWithNibName:@"TermViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:term animated:YES];
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
        [[AFNetEngine shareEngine] opValidMobile:_txtPhoneNum.text
                                     onSucceeded:^(NSDictionary *dic) {
                                         DLog(@"验证手机的返回数据： %@",dic);
                                         if([dic[@"state"] isEqual:@"success"])
                                         {
                                             [[AFNetEngine shareEngine] opValidCode:_txtPhoneNum.text
                                                                        onSucceeded:^(NSDictionary *dic) {
                                                                            DLog(@"发送验证码的返回数据： %@",dic);
                                                                            if([dic[@"state"] isEqual:@"success"])
                                                                            {
                                                                                VerificationCodeViewController *verifVC=[[VerificationCodeViewController alloc] initWithPhoneNumber:_txtPhoneNum.text forPurpose:1];
                                                                                [self.navigationController pushViewController:verifVC animated:YES];
                                                                                [button setEnabled:YES];
                                                                                [ActivityIndicator hideActivity:button];
                                                                            }
                                                                            
                                                                        } onError:^(RESTError *engineError) {
                                                                            ELog(engineError);
                                                                            [button setEnabled:YES];
                                                                            [Alert show:engineError.errorDescription];
                                                                            [ActivityIndicator hideActivity:button];
                                                                        }];
                                             
                                             
                                         }
                                         
                                         
                                     } onError:^(RESTError *engineError) {
                                         [button setEnabled:YES];
                                         [Alert show:engineError.errorDescription];
                                         ELog(engineError);
                                         [ActivityIndicator hideActivity:button];
                                         
                                     }];
        [ActivityIndicator showActivity:button];
    }
}

#pragma mark 直接登录
-(void)btnPressToLogin:(UIButton *)button
{
    [_btnLogin setEnabled:NO];
    if(_txtPhoneNum.text.length==0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        LoginViewController *loginVC=[[LoginViewController alloc] initWithPhoneNum:_txtPhoneNum.text];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_btnTerm setEnabled:YES];
    [_btnLogin setEnabled:YES];
    [_btnAgree setEnabled:YES];
    [_btnNext setEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
