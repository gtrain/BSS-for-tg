//
//  VirificationCodeViewController.m
//  BSS
//
//  Created by zhangbo on 13-9-18.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "VerificationCodeViewController.h"
#import "Res_UserInfoViewController.h"
#import "Forget_UserInfoViewController.h"
#import "Alert.h"
#import "ActivityIndicator.h"

@interface VerificationCodeViewController ()

@end

@implementation VerificationCodeViewController

#pragma mark 根据手机号与目的号初始化事件
-(id)initWithPhoneNumber:(NSString *)num forPurpose:(int)purpose{
    self = [super init];
    if(self){
        NSString *header = @"我们给您的手机";
        NSString *footer = @",发送了一条短信，请将短信中的数字作为验证码填写在下面。";
        header =  [header stringByAppendingString:num];
        header = [header stringByAppendingString:footer];
        _strPhoneNum=num;
        self.contentDetail  = header;
        self.purpose  = purpose;
    }
    return self;
}

#pragma mark Prepare for the basic factors
-(void)prepare{
    self.width = [[UIScreen mainScreen]bounds].size.width;
    self.heihgt = [[UIScreen mainScreen]bounds].size.height;
}

-(void)setFrameUpWithColor:(UIColor *)color{
    self.view.backgroundColor = color;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_title_orange"] forBarMetrics:UIBarMetricsDefault];
    
    [self paintBackButton];
}

#pragma mark Paint all the components/view for the cavn.
-(void)paintView{
    //Tips
    self.lblDetail = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.width-20, 60)];
    self.lblDetail.font = [UIFont fontWithName:@"Bold" size:6];
    self.lblDetail.numberOfLines = 3;
    [self.lblDetail setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:self.lblDetail];
    
    //Input area
    self.txtfCode = [[UITextField alloc]initWithFrame:CGRectMake(10, 80, ((self.width-20)/5)*3, 40)];
    self.txtfCode.borderStyle = UITextBorderStyleRoundedRect;
    self.txtfCode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtfCode.returnKeyType = UIReturnKeyDone;
    self.txtfCode.delegate = self;
    [self.view addSubview:self.txtfCode];
    
    //Next-button
    self.btnNext = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnNext.frame = CGRectMake(20+self.txtfCode.frame.size.width, 80, self.width-30-self.txtfCode.frame.size.width, 40);
    
    [self.btnNext setBackgroundImage:[UIImage imageNamed:@"button_orange"] forState:UIControlStateNormal];
    [self.btnNext setBackgroundImage:[UIImage imageNamed:@"button_orange_pressed"] forState:UIControlStateHighlighted];
    
    [self.btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.btnNext setTitle:@"下一步" forState:UIControlStateNormal];
    [self.btnNext addTarget:self action:@selector(onNextClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIActivityIndicatorView *aiLogin=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    aiLogin.frame=CGRectMake(_width/2-85, 5, 30, 30);
    [self.btnNext addSubview:aiLogin];
    
    [self.view addSubview:self.btnNext];
    
    //Tips for receiving code.
    self.btnSendCodeAgain = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnSendCodeAgain.frame = CGRectMake(self.width-90, 130, 80, 20);
    [self.btnSendCodeAgain setTitle:@"重新发送" forState:UIControlStateNormal];
    [self.btnSendCodeAgain setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnSendCodeAgain.titleLabel.font = [UIFont fontWithName:@"Bold" size:6];
    self.btnSendCodeAgain.backgroundColor = [UIColor clearColor];
    self.btnSendCodeAgain.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.btnSendCodeAgain addTarget:self action:@selector(startCountDownTimer:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.btnSendCodeAgain];
    
    self.lblNoCodeReceived = [[UILabel alloc]initWithFrame:CGRectMake(self.width-10-80-120, 130, 120, 20)];
    self.lblNoCodeReceived.text = @"没收到验证码？";
    self.lblNoCodeReceived.font = [UIFont fontWithName:@"Bold" size:6];
    self.lblNoCodeReceived.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.lblNoCodeReceived];
    
}

#pragma mark Called when the send code once again button clicked.
-(void)startCountDownTimer:(UIButton *)btn{
    if(!self.isTimerRunning){
        [[AFNetEngine shareEngine] opValidCodeFG:_strPhoneNum
                                     onSucceeded:^(NSDictionary *dic) {
                                         DLog(@"发送验证码的返回数据： %@",dic);
                                         if([dic[@"state"] isEqual:@"success"])
                                         {
                                             self.isTimerRunning = YES;
                                             [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                             self.timeForCountDown = 30;
                                             [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeText:) userInfo:nil repeats:YES];
                                         }
                                     } onError:^(RESTError *engineError) {
                                         ELog(engineError);
                                         [Alert show:engineError.errorDescription];
                                     }];
    }
}

-(void)send
{
    
}

#pragma mark Paint the back button in navigation bar
-(void)paintBackButton{
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
    [btn addTarget:self action:@selector(btnPressToBackUserNo) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btnBack=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=btnBack;
}

-(void)btnPressToBackUserNo
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Text changed
-(void)changeText:(NSTimer *)timer{
    NSLog(@"time for count down is %d",self.timeForCountDown);
    if(self.timeForCountDown <= 0){
        [timer invalidate];
        [self.btnSendCodeAgain setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.btnSendCodeAgain setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.isTimerRunning = NO;
        return;
    }
    [self.btnSendCodeAgain setTitle:[[NSString alloc]initWithFormat:@"还剩%d秒",self.timeForCountDown]forState:UIControlStateNormal];
    self.timeForCountDown--;
}

//Optional method in delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.txtfCode resignFirstResponder];
    return YES;
}

//Start
-(void)loadView{
    
    [super loadView];
    
    [self prepare];
    
    [self setFrameUpWithColor:[[UIColor alloc] initWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
    
    [self paintView];
    
    self.title=@"填写验证码";
    
    if(!self.isTimerRunning){
        self.isTimerRunning = YES;
        self.timeForCountDown = 30;
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeText:) userInfo:nil repeats:YES];
    }
}

//Set data up after painting views
-(void)viewDidLoad{
    self.lblDetail.text = self.contentDetail;
}

//Different pages will be turn into in different states
-(void)onNextClick:(UIButton *)btn{
    switch(self.purpose){
        case FOR_REGISTER:[self forRegister:btn];break;
        case FOR_FINDPASSWORD:[self forForgetPassword:btn];break;
        default:break;
            
    }
}

#pragma mark 用于处理注册相关
-(void)forRegister:(UIButton *)button
{
    [[AFNetEngine shareEngine] opVerifyCode:_txtfCode.text Mobile:_strPhoneNum
                                onSucceeded:^(NSDictionary *dic) {
                                    DLog(@"发送验证码的返回数据： %@",dic);
                                    if([dic[@"state"] isEqual:@"success"])
                                    {
                                        
                                        Res_UserInfoViewController *resUserInfo=[[Res_UserInfoViewController alloc] initWithPhoneNum:_strPhoneNum];
                                        [self.navigationController pushViewController:resUserInfo animated:YES];
                                        [ActivityIndicator hideActivity:button];
                                    }
                                    else
                                    {
                                        [Alert show:dic[@"state"]];
                                    }
                                } onError:^(RESTError *engineError) {
                                    ELog(engineError);
                                    [Alert show:engineError.errorDescription];
                                    [ActivityIndicator hideActivity:button];
                                }];
    [ActivityIndicator showActivity:button];
    
}

#pragma mark 用于处理忘记密码相关
-(void)forForgetPassword:(UIButton *)button
{
    [[AFNetEngine shareEngine] opVerifyCodeFG:_txtfCode.text Mobile:_strPhoneNum
                                  onSucceeded:^(NSDictionary *dic) {
                                      DLog(@"发送验证码的返回数据： %@",dic);
                                      if([dic[@"state"] isEqual:@"success"])
                                      {
                                          Forget_UserInfoViewController *forgetUserInfo=[[Forget_UserInfoViewController alloc] initWithPhoneNum:_strPhoneNum];
                                          [self.navigationController pushViewController:forgetUserInfo animated:YES];
                                          [ActivityIndicator hideActivity:button];
                                      }
                                      else
                                      {
                                          [Alert show:dic[@"state"]];
                                          [ActivityIndicator hideActivity:button];
                                      }
                                  } onError:^(RESTError *engineError) {
                                      ELog(engineError);
                                      [Alert show:engineError.errorDescription];
                                      [ActivityIndicator hideActivity:button];
                                  }];
    [ActivityIndicator showActivity:button];
}

@end
