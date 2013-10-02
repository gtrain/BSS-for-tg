//
//  Res_UserInfoViewController.m
//  BSS
//
//  Created by zhangbo on 13-9-18.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "Res_UserInfoViewController.h"
#import "FormatChecker.h"
#import "AppDelegate.h"
#import "Alert.h"
#import "Location.h"
#import "ActivityIndicator.h"

@interface Res_UserInfoViewController ()

@end

@implementation Res_UserInfoViewController

#pragma mark 自定义根据手机号初始化
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
    
    [self paintPhoneNum];
    
    [self paintName];
    
    [self paintCompanyName];
    
    [self paintPassword];
    
    [self paintBtnSave];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleAndBtnBack];
    
}

#pragma mark 手机号码
-(void)paintPhoneNum
{
    //手机号码
    UILabel *lblPhoneNumTag=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
    lblPhoneNumTag.text=@"手机号码:";
    lblPhoneNumTag.textAlignment=UITextAlignmentRight;
    lblPhoneNumTag.backgroundColor=[UIColor clearColor];
    lblPhoneNumTag.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:lblPhoneNumTag];
    
    _lblPhoneNum=[[UILabel alloc] initWithFrame:CGRectMake(72, 10, 100, 20)];
    _lblPhoneNum.text=_strPhoneNum;
    _lblPhoneNum.backgroundColor=[UIColor clearColor];
    _lblPhoneNum.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_lblPhoneNum];
}

#pragma mark 姓名
-(void)paintName
{
    //姓名
    UILabel *lblUserName=[[UILabel alloc] initWithFrame:CGRectMake(10, 50, 60, 20)];
    lblUserName.text=@"姓名:";
    lblUserName.textAlignment=UITextAlignmentRight;
    lblUserName.backgroundColor=[UIColor clearColor];
    lblUserName.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:lblUserName];
    
    _txtUserName=[[UITextField alloc] initWithFrame:CGRectMake(72, 40, 220, 40)];
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    _txtUserName.leftView=imgView;
    _txtUserName.leftViewMode=UITextFieldViewModeAlways;
    _txtUserName.backgroundColor=[UIColor whiteColor];
    _txtUserName.layer.cornerRadius=8;
    _txtUserName.placeholder=@"请输入真实姓名,用于业务名片";
    _txtUserName.font=[UIFont systemFontOfSize:13];
    _txtUserName.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _txtUserName.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    _txtUserName.returnKeyType=UIReturnKeyDone;
    _txtUserName.delegate=self;
    [self.view addSubview:_txtUserName];
    
}

#pragma mark 公司全称
-(void)paintCompanyName
{
    //公司名
    UILabel *lblCompanyName=[[UILabel alloc] initWithFrame:CGRectMake(10, 100, 60, 20)];
    lblCompanyName.text=@"公司全称:";
    lblCompanyName.textAlignment=UITextAlignmentRight;
    lblCompanyName.backgroundColor=[UIColor clearColor];
    lblCompanyName.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:lblCompanyName];
    
    _txtCompanyName=[[UITextField alloc] initWithFrame:CGRectMake(72, 90, 220, 40)];
    UIImageView *imgComNameView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    _txtCompanyName.leftView=imgComNameView;
    _txtCompanyName.leftViewMode=UITextFieldViewModeAlways;
    _txtCompanyName.backgroundColor=[UIColor whiteColor];
    _txtCompanyName.layer.cornerRadius=8;
    _txtCompanyName.placeholder=@"请填写完整的公司全称（需核实）";
    _txtCompanyName.font=[UIFont systemFontOfSize:13];
    _txtCompanyName.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _txtCompanyName.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    _txtCompanyName.returnKeyType=UIReturnKeyDone;
    _txtCompanyName.delegate=self;
    [self.view addSubview:_txtCompanyName];
    
}

#pragma mark 设置密码
-(void)paintPassword
{
    //密码
    UILabel *lblPassword=[[UILabel alloc] initWithFrame:CGRectMake(10, 150, 60, 20)];
    lblPassword.text=@"设置密码:";
    lblPassword.textAlignment=UITextAlignmentRight;
    lblPassword.backgroundColor=[UIColor clearColor];
    lblPassword.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:lblPassword];
    
    _txtPassword=[[UITextField alloc] initWithFrame:CGRectMake(72, 140, 220, 40)];
    UIImageView *imgPwView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    _txtPassword.leftView=imgPwView;
    _txtPassword.leftViewMode=UITextFieldViewModeAlways;
    _txtPassword.backgroundColor=[UIColor whiteColor];
    _txtPassword.layer.cornerRadius=8;
    _txtPassword.placeholder=@"请输入密码,不少于6位";
    _txtPassword.font=[UIFont systemFontOfSize:13];
    _txtPassword.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _txtPassword.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    _txtPassword.secureTextEntry=YES;
    _txtPassword.returnKeyType=UIReturnKeyDone;
    _txtPassword.delegate=self;
    [self.view addSubview:_txtPassword];
}

#pragma mark 提交按钮
-(void)paintBtnSave
{
    //提交
    UIButton *btnSave=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnSave setTitle:@"提 交" forState:UIControlStateNormal];
    [btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSave setBackgroundImage:[UIImage imageNamed:@"button_orange"] forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(btnPressToSave:) forControlEvents:UIControlEventTouchUpInside];
    btnSave.titleLabel.textColor=[UIColor whiteColor];
    btnSave.frame=CGRectMake(72, 190, 105, 35);
    
    UIActivityIndicatorView *aiLogin=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    aiLogin.frame=CGRectMake(_width/2-90, 3.5, 30, 30);
    [btnSave addSubview:aiLogin];
    
    [self.view addSubview:btnSave];
}

#pragma mark 设置标题与返回按钮
-(void)setTitleAndBtnBack
{
    [self setTitle:@"填写您的资料"];
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

#pragma mark 返回验证码页面
-(void)btnPressToBackVerify
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 提交用户信息
-(void)btnPressToSave:(UIButton *)button
{
    [button setEnabled:NO];
    if(_txtUserName.text.length==0||_txtCompanyName.text.length==0||_txtPassword.text.length==0)
    {
        [Alert show:@"请输入您的姓名、公司名和密码"];
        [button setEnabled:YES];
        return;
    }
    if(![FormatChecker checkUserName:_txtUserName.text])
    {
        [button setEnabled:YES];
        [Alert show:@"姓名必须为2至4个中文字符"];
        return;
    }
    if (![FormatChecker checkCompanyName:_txtCompanyName.text])
    {
        [button setEnabled:YES];
        [Alert show:@"公司名称需为3至20个中文字符、数字、英文字符的组合"];
        return;
    }
    if(![FormatChecker checkPassword:_txtPassword.text])
    {
        [button setEnabled:YES];
        [Alert show:@"您设置的密码输入有误，请输入6-16位字母、数字组成的密码"];
        return;
    }
    NSString *strLocation=@"";
    if(AppDelegateShare.strCity.length!=0)
    {
        strLocation=AppDelegateShare.strCity;
    }
    [[AFNetEngine shareEngine] opVerifyUserInfoWithMobile:_strPhoneNum UserName:_txtUserName.text Company:_txtCompanyName.text Password:_txtPassword.text Location:strLocation onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"用户注册结果： %@",dictionary);
        if([dictionary[@"state"] isEqual:@"success"])
        {
            [AppDelegateShare.authEngine requestTokenWithUserName:_strPhoneNum
                                                         passWord:_txtPassword.text
                                                      onSucceeded:^{
                                                          DLog(@"获取token成功");
                                                          [self presentViewController:AppDelegateShare.tabBarController animated:YES completion:nil];
                                                          [button setEnabled:YES];
                                                          [ActivityIndicator hideActivity:button];
                                                      } onError:^(RESTError *engineError) {
                                                          ELog(engineError);
                                                          [button setEnabled:YES];
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
