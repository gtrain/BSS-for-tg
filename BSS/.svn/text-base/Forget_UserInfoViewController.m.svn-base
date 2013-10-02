//
//  Forget_UserInfoViewController.m
//  BSS
//
//  Created by zhangbo on 13-9-18.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "Forget_UserInfoViewController.h"
#import "Alert.h"
#import "FormatChecker.h"
#import "LoginViewController.h"
#import "ActivityIndicator.h"

@interface Forget_UserInfoViewController ()

@end

@implementation Forget_UserInfoViewController

-(id)initWithPhoneNum:(NSString *)phoneNum
{
    self=[super init];
    if(self)
    {
        _strPhoneNum=phoneNum;
    }
    return self;
}

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
    
    [self paintPw];
    
    [self paintResetPw];
    
    [self paintBtnSave];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitleAndBtnBack];
}

#pragma mark 画密码框
-(void)paintPw
{
    UILabel *lblTag=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
    lblTag.text=@"请输入新的密码";
    lblTag.textAlignment=UITextAlignmentLeft;
    lblTag.backgroundColor=[UIColor clearColor];
    lblTag.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:lblTag];
    
    UIView *newPwView=[[UIView alloc] initWithFrame:CGRectMake(10, 40, 300, 40)];
    newPwView.backgroundColor=[UIColor whiteColor];
    newPwView.layer.cornerRadius=8;
    UILabel *lblNewPw=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
    lblNewPw.text=@"新密码";
    lblNewPw.textAlignment=UITextAlignmentLeft;
    lblNewPw.backgroundColor=[UIColor clearColor];
    lblNewPw.font=[UIFont systemFontOfSize:13];
    [newPwView addSubview:lblNewPw];
    
    _txtNewPw=[[UITextField alloc] initWithFrame:CGRectMake(70, 0, 230, 40)];
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    _txtNewPw.leftView=imgView;
    _txtNewPw.leftViewMode=UITextFieldViewModeAlways;
    _txtNewPw.backgroundColor=[UIColor whiteColor];
    _txtNewPw.layer.cornerRadius=8;
    _txtNewPw.placeholder=@"不少于6位";
    _txtNewPw.font=[UIFont systemFontOfSize:13];
    _txtNewPw.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _txtNewPw.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    _txtNewPw.secureTextEntry=YES;
    _txtNewPw.returnKeyType=UIReturnKeyDone;
    _txtNewPw.delegate=self;
    
    [newPwView addSubview:_txtNewPw];
    
    [self.view addSubview:newPwView];
}

#pragma mark 画重置密码框
-(void)paintResetPw
{
    UIView *resetPwView=[[UIView alloc] initWithFrame:CGRectMake(10, 90, 300, 40)];
    resetPwView.backgroundColor=[UIColor whiteColor];
    resetPwView.layer.cornerRadius=8;
    UILabel *lblResetPw=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
    lblResetPw.text=@"重复密码";
    lblResetPw.textAlignment=UITextAlignmentLeft;
    lblResetPw.backgroundColor=[UIColor clearColor];
    lblResetPw.font=[UIFont systemFontOfSize:13];
    [resetPwView addSubview:lblResetPw];
    
    _txtResetPw=[[UITextField alloc] initWithFrame:CGRectMake(70, 0, 230, 40)];
    UIImageView *resetImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    _txtResetPw.leftView=resetImgView;
    _txtResetPw.leftViewMode=UITextFieldViewModeAlways;
    _txtResetPw.backgroundColor=[UIColor whiteColor];
    _txtResetPw.layer.cornerRadius=8;
    _txtResetPw.placeholder=@"再次输入密码";
    _txtResetPw.font=[UIFont systemFontOfSize:13];
    _txtResetPw.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _txtResetPw.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    _txtResetPw.secureTextEntry=YES;
    _txtResetPw.returnKeyType=UIReturnKeyDone;
    _txtResetPw.delegate=self;
    [resetPwView addSubview:_txtResetPw];
    
    [self.view addSubview:resetPwView];
    
    UILabel *lblPwTag=[[UILabel alloc] initWithFrame:CGRectMake(10, 140, 300, 20)];
    lblPwTag.text=@"密码长度最少6位,为保证安全,不要过于简单";
    lblPwTag.textAlignment=UITextAlignmentLeft;
    lblPwTag.backgroundColor=[UIColor clearColor];
    lblPwTag.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:lblPwTag];
}

#pragma mark 画提交按钮
-(void)paintBtnSave
{
    //提交
    UIButton *btnSave=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnSave setTitle:@"完 成" forState:UIControlStateNormal];
    [btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSave.titleLabel.font=[UIFont systemFontOfSize:13];
    [btnSave addTarget:self action:@selector(btnPressToSave:) forControlEvents:UIControlEventTouchUpInside];
    btnSave.frame=CGRectMake(90, 170, 105, 35);
    [btnSave setBackgroundImage:[UIImage imageNamed:@"button_orange"] forState:UIControlStateNormal];
    
    UIActivityIndicatorView *aiLogin=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    aiLogin.frame=CGRectMake(_width/2-95, 2.5, 30, 30);
    [btnSave addSubview:aiLogin];
    
    [self.view addSubview:btnSave];
    
}

#pragma mark 设置标题与返回按钮
-(void)setTitleAndBtnBack
{
    //设置标题以及返回按钮
    [self setTitle:@"重置密码"];
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
    [btn addTarget:self action:@selector(btnPressToBackVerify) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btnBack=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=btnBack;
}

#pragma mark 返回事件
-(void)btnPressToBackVerify
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 保存事件
-(void)btnPressToSave:(UIButton *)button
{
    [button setEnabled:NO];
    [_txtResetPw resignFirstResponder];
    if(_txtNewPw.text.length==0||_txtResetPw.text.length==0)
    {
        [button setEnabled:YES];
        [Alert show:@"请输入新密码与重复密码"];
        return;
    }
    if(![FormatChecker checkPassword:_txtNewPw.text])
    {
        [button setEnabled:YES];
        [Alert show:@"您设置的密码输入有误，请输入6-16位字母、数字组成的密码"];
        return;
    }
    if(![_txtNewPw.text isEqualToString:_txtResetPw.text])
    {
        [button setEnabled:YES];
        [Alert show:@"重复密码与新密码不一致，请重新输入"];
        return;
    }
    [[AFNetEngine shareEngine] opChangePassword:_txtNewPw.text Mobile:_strPhoneNum onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"获取验证码结果： %@",dictionary);
        LoginViewController *loginVC=[[LoginViewController alloc] initWithPhoneNum:_strPhoneNum];
        [self.navigationController pushViewController:loginVC animated:YES];
        [button setEnabled:YES];
        [ActivityIndicator hideActivity:button];
    } onError:^(RESTError *engineError) {
        ELog(engineError);
        [button setEnabled:YES];
        [Alert show:engineError.errorDescription];
        [ActivityIndicator hideActivity:button];
    }];
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
