//
//  LoginViewController.m
//  BSS
//
//  Created by YANGZQ on 13-9-16.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "LoginViewController.h"
#import "FormatChecker.h"
#import "AppDelegate.h"
#import "Res_UserNoViewController.h"
#import "Forget_UserNoViewController.h"
#import "Location.h"
#import "Alert.h"
#import "ActivityIndicator.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(id)initWithPhoneNum:(NSString *)phoneNum
{
    self=[super init];
    if(self)
    {
        _strPhoneNum=phoneNum;
    }
    return self;
}

-(void)loadView{
    [super loadView];
    
    [self prepare];
    
    //设置背景颜色
    UIColor *startColor = [[UIColor alloc]initWithRed:1 green:0.35 blue:0.003 alpha:1];
    UIColor *endColor = [[UIColor alloc]initWithRed:1 green:0.71 blue:0.09 alpha:1];
    [self paintBackgroundColorWithStartColor:endColor centerColor:startColor andEndColor:startColor];
    //画出控件
    [self paintViews];
    //画账号密码输入框
    [self paintTxtView];
    //画注册与忘记密码
    [self paintResAndForget];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)prepare{
    self.width = [[UIScreen mainScreen] bounds].size.width;
    self.height = [[UIScreen mainScreen] bounds].size.height;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _txtUserNo.text=@"13726223584";
    _txtPassword.text=@"123321";
    if(_strPhoneNum.length!=0)
    {
        _txtUserNo.text=_strPhoneNum;
    }
}

#pragma mark Setup the background.
-(void)paintBackgroundColorWithStartColor:(UIColor *)startColor centerColor:(UIColor *) centerColor andEndColor:(UIColor *)endColor{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = [[UIScreen mainScreen]bounds];
    gradient.colors = [NSArray arrayWithObjects:(id)startColor.CGColor,(id)centerColor.CGColor,(id)endColor.CGColor,nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

#pragma mark 先画出TG的Logo
-(void)paintViews{
    UIImage *image = [UIImage imageNamed:@"yewutong_logo_login"];
    self.imgvLogo = [[UIImageView alloc]initWithImage:image];
    self.imgvLogo.frame = CGRectMake((self.width-image.size.width)/2, 20,image.size.width, image.size.height);
    [self.view addSubview:self.imgvLogo];  
}

#pragma mark 帐号密码输入框
-(void)paintTxtView
{
    //txt
    UIView *loginView=[[UIView alloc] initWithFrame:CGRectMake(20, 73, self.width-40, 90)];
    loginView.layer.borderWidth=1;
    loginView.layer.borderColor=[[UIColor alloc] initWithRed:0.77 green:0.20 blue:0.01 alpha:1.0].CGColor;
    loginView.layer.cornerRadius=8;
    loginView.backgroundColor=[UIColor whiteColor];
    UILabel *lblUserNo=[[UILabel alloc] initWithFrame:CGRectMake(5, 0.5, 60, 44)];
    lblUserNo.font=[UIFont systemFontOfSize:15];
    lblUserNo.text=@"帐 号";
    lblUserNo.textAlignment=NSTextAlignmentCenter;
    _txtUserNo=[[UITextField alloc] initWithFrame:CGRectMake(70, 2, self.width-40-70, 44)];
    _txtUserNo.font=[UIFont systemFontOfSize:15];
    _txtUserNo.placeholder=@"请输入手机号";
    _txtUserNo.textAlignment=NSTextAlignmentLeft;
    _txtUserNo.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _txtUserNo.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    _txtUserNo.returnKeyType = UIReturnKeyDone;
    _txtUserNo.delegate = self;
    
    UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, 44, self.width-40, 1)];
    lblLine.backgroundColor=[UIColor lightGrayColor];
    
    UILabel *lblPassword=[[UILabel alloc] initWithFrame:CGRectMake(5, 45.5, 60, 44)];
    lblPassword.font=[UIFont systemFontOfSize:15];
    lblPassword.text=@"密 码";
    lblPassword.textAlignment=NSTextAlignmentCenter;
    _txtPassword=[[UITextField alloc] initWithFrame:CGRectMake(70, 47, self.width-40-70, 44)];
    _txtPassword.font=[UIFont systemFontOfSize:15];
    _txtPassword.placeholder=@"密 码";
    _txtPassword.textAlignment=NSTextAlignmentLeft;
    _txtPassword.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _txtPassword.clearsOnBeginEditing=YES;
    _txtPassword.secureTextEntry=YES;
    _txtPassword.returnKeyType = UIReturnKeyDone;
    _txtPassword.delegate = self;
    
    [loginView addSubview:lblUserNo];
    [loginView addSubview:_txtUserNo];
    [loginView addSubview:lblLine];
    [loginView addSubview:lblPassword];
    [loginView addSubview:_txtPassword];
    
    UIButton *btnLogin=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnLogin.frame=CGRectMake(20, 185, self.width-40, 44);
    [btnLogin setBackgroundImage:[UIImage imageNamed:@"button_login"] forState:UIControlStateNormal];
    [btnLogin setBackgroundImage:[UIImage imageNamed:@"button_login_press"] forState:UIControlStateHighlighted];
    btnLogin.titleLabel.font=[UIFont systemFontOfSize:16];
    [btnLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLogin setTitle:@"登 录" forState:UIControlStateNormal];
    
    UIActivityIndicatorView *aiLogin=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    aiLogin.frame=CGRectMake(self.width/2-20-50, 7, 30, 30);
    [btnLogin addSubview:aiLogin];
    
    [btnLogin addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnLogin];
    [self.view addSubview:loginView];
}

#pragma mark 注册与忘记密码
-(void)paintResAndForget
{
    _btnRegister=[[UIButton alloc] initWithFrame:CGRectMake(self.width/2-20+3, self.height/2+7, 40,20)];
    [_btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    [_btnRegister addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnRegister];
    
    
    _btnForgetPW=[[UIButton alloc] initWithFrame:CGRectMake(self.width/2+55, self.height/2+7, 85,20)];
    [_btnForgetPW setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_btnForgetPW addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnForgetPW];
}

#pragma mark 登录按钮
-(void)btnPress:(UIButton *)button
{
    [button setEnabled:FALSE];
    [_txtPassword resignFirstResponder];
    
    //todo:验证数据
    if(_txtUserNo.text.length==0||_txtPassword.text.length==0)
    {
        [Alert show:@"帐号或密码不能为空"];
        [button setEnabled:YES];
        return;
    }

    if (![FormatChecker checkPhoneNumber:_txtUserNo.text]) {
        [Alert show:@"帐号错误,请确认是否输入错误"];
        [button setEnabled:YES];
        return;
    }
    
    if (![FormatChecker checkPassword:_txtPassword.text]) {
        [Alert show:@"密码错误,请重新输入"];
        [button setEnabled:YES];
        return;
    }
    
    
    [AppDelegateShare.authEngine requestTokenWithUserName:_txtUserNo.text
                                                 passWord:_txtPassword.text
                                              onSucceeded:^{
                                                  DLog(@"获取token成功");
                                                 [ActivityIndicator hideActivity:button];
                                                  
                                                  
                                                  
                                                  [self.navigationController pushViewController:AppDelegateShare.tabBarController animated:YES];
                                                [button setEnabled:YES];
                                                  
                                              } onError:^(RESTError *engineError) {
                                                  ELog(engineError);
                                                  [ActivityIndicator hideActivity:button];
                                                  UIAlertView *alert=[[UIAlertView alloc] initWithTitle:engineError.errorDescription message:NULL delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                                  [alert show];
                                                  [button setEnabled:YES];

                                              }];
    
    
    
   [ActivityIndicator showActivity:button];
    
}

#pragma mark 注册点击事件
-(void)registerUser:(UIButton *)button
{
    [_btnRegister setEnabled:NO];
    Res_UserNoViewController *resUserNo=[[Res_UserNoViewController alloc] init];
   [self.navigationController pushViewController:resUserNo animated:YES];
}

#pragma mark 忘记密码点击事件
-(void)forgetPassword:(UIButton *)button
{
    [_btnForgetPW setEnabled:NO];
    Forget_UserNoViewController *forgetUserNo=[[Forget_UserNoViewController alloc] init];
      [self.navigationController pushViewController:forgetUserNo animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    [_btnRegister setEnabled:YES];
    [_btnForgetPW setEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
