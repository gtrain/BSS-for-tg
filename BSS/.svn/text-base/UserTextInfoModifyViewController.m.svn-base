//
//  UserTextInfoModifyViewController.m
//  BSS
//
//  Created by liuc on 13-9-23.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "UserTextInfoModifyViewController.h"
#import "UserProfileViewController.h"
#import "FormatChecker.h"
#import "EditText.h"
#import <QuartzCore/QuartzCore.h>

#define ERROR_NAME_FORMAT @"用户名必须为2到4个中文字符"
#define ERROR_POST_FORMAT @"职位名称必须为2到10个中文字符"
#define ERROR_COMPANYNAME_FORMAT @"企业名称必须为3到20个中文字符、数字、英文字符的组合"
#define ERROR_QQNUM_FORMAT @"QQ号码必须为4到20位的数字"
#define ERROR_COMPANYADDRESS_FORMAT @"地址必须为3到50个中文字符、数字、英文字符的组合，可以包含括号、破折号"

@interface UserTextInfoModifyViewController ()

@property (nonatomic, strong) NSString *topTitle;
@property (assign) ModifyType type;
@property (nonatomic, strong) UserModel *uModel;

@property (nonatomic, strong) EditText *inputArea;
@property (nonatomic, strong) UIButton *hideKeyboardHelper;

@end

@implementation UserTextInfoModifyViewController


//构造方法
-(id)initWithUserModel:(UserModel *)model forType:(ModifyType)type{
    self = [super init];
    if(self) {
        self.type = type;
        _uModel = model;
    }
    return self;
}

-(void)loadView{
    
    [super loadView];
    
    [self prepareFrame];
    
    [self initViews];
}

//隐藏TabBar
-(id)hideTabBarWhenPushed{
    [self setHidesBottomBarWhenPushed:YES];
    return self;
}

//Base frame
-(void)prepareFrame{
    //For hiding the keyboard
    _hideKeyboardHelper = [UIButton buttonWithType:UIButtonTypeCustom];
    _hideKeyboardHelper.frame = self.view.bounds;
    [_hideKeyboardHelper setBackgroundColor:[UIColor clearColor]];
    [_hideKeyboardHelper setTag:111];
    [_hideKeyboardHelper addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_hideKeyboardHelper];

    //Back button
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setBackgroundColor:[UIColor clearColor]];
    [btnBack setFrame:CGRectMake(10,10, 46, 27)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"button_orange_back"] forState:UIControlStateNormal];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"button_orange_back_pressed"] forState:UIControlStateHighlighted];
    [btnBack setTitle:@" 返回" forState:UIControlStateNormal];
    [btnBack.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btnBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnBack addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnBack setTag:100];
    
    //Upload button
    UIButton *btnUpload = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnUpload setBackgroundColor:[UIColor clearColor]];
    [btnUpload setFrame:CGRectMake(10,10, 46, 27)];
    [btnUpload setBackgroundImage:[UIImage imageNamed:@"button_orange_square"] forState:UIControlStateNormal];
    [btnUpload setBackgroundImage:[UIImage imageNamed:@"button_orange_square_pressed"] forState:UIControlStateHighlighted];
    [btnUpload setTitle:@"提交" forState:UIControlStateNormal];
    [btnUpload.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btnUpload setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnUpload addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnUpload setTag:101];

    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btnUpload];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)onClick:(UIButton *)btn{
    switch(btn.tag){
        case 100:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 101:
            [self uploadModifiedInfo];
            break;
        case 111:
            [_inputArea resignFirstResponder];
            break;
    }
}

//Upload diff data according to the type.
-(void)uploadModifiedInfo{
    NSString *inputContent = _inputArea.text;
    switch(self.type){
        case TypeName://修改姓名
            if(![inputContent isEqualToString:_uModel.name]){
                if([FormatChecker checkUserName:inputContent]){
                    [self.navigationController popViewControllerAnimated:YES];
                    [[AFNetEngine shareEngine] opUpdateUsername:inputContent onSucceeded:^(NSDictionary *dictionary) {
                        [self sendNotificationForModifyingInfoWithValue:inputContent forKey:KEY_NAME whichWithAnIndex:KEY_NAME_NUM];
                    } onError:^(RESTError *engineError) {
                        NSLog(@"Error:%@",engineError.errorDescription);
                        [self showErrorTipsAlertWithMessage:engineError.errorDescription];
                    }];
                }else{
                    [self showErrorTipsAlertWithMessage:ERROR_NAME_FORMAT];
                }
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        case TypePost://修改职位
            if(![inputContent isEqualToString:_uModel.post]){
                if([FormatChecker checkPost:inputContent]){
                    [self.navigationController popViewControllerAnimated:YES];
                    [[AFNetEngine shareEngine]opUpdateUserPost:inputContent onSucceeded:^(NSDictionary *dictionary) {
                        [self sendNotificationForModifyingInfoWithValue:inputContent forKey:KEY_POST whichWithAnIndex:KEY_POST_NUM];
                    } onError:^(RESTError *engineError) {
                        NSLog(@"Error:%@",engineError.errorDescription);
                        [self showErrorTipsAlertWithMessage:engineError.errorDescription];
                    }];
                }else{
                    [self showErrorTipsAlertWithMessage:ERROR_POST_FORMAT];
                }
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        case TypeCompany://修改公司
            if(![inputContent isEqualToString:_uModel.company]){
                if([FormatChecker checkCompanyName:inputContent]){
                    [self.navigationController popViewControllerAnimated:YES];
                    [[AFNetEngine shareEngine]opUpdateUserCompany:inputContent onSucceeded:^(NSDictionary *dictionary) {
                        [self sendNotificationForModifyingInfoWithValue:inputContent forKey:KEY_COMPANY whichWithAnIndex:KEY_COMPANY_NUM];
                    } onError:^(RESTError *engineError) {
                        NSLog(@"Error:%@",engineError.errorDescription);
                        [self showErrorTipsAlertWithMessage:engineError.errorDescription];
                    }];
                }else{
                    [self showErrorTipsAlertWithMessage:ERROR_COMPANYNAME_FORMAT];
                }
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        case TypeQQNum://修改QQ
            if(![inputContent isEqualToString:_uModel.qq]){
                if([FormatChecker checkQQNum:inputContent]){
                    [self.navigationController popViewControllerAnimated:YES];
                    [[AFNetEngine shareEngine]opUpdateUserQQ:inputContent onSucceeded:^(NSDictionary *dictionary) {
                        [self sendNotificationForModifyingInfoWithValue:inputContent forKey:KEY_QQ whichWithAnIndex:KEY_QQ_NUM];
                    } onError:^(RESTError *engineError) {
                        NSLog(@"Error:%@",engineError.errorDescription);
                        [self showErrorTipsAlertWithMessage:engineError.errorDescription];
                }];
                }else{
                    [self showErrorTipsAlertWithMessage:ERROR_QQNUM_FORMAT];
                }
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        case TypeBussinessAddress://修改公司地址
            if(![inputContent isEqualToString:_uModel.business_address]){
                if([FormatChecker checkCompanyAddress:inputContent]){
                    [self.navigationController popViewControllerAnimated:YES];
                    [[AFNetEngine shareEngine]opUpdateUserAddress:inputContent onSucceeded:^(NSDictionary *dictionary) {
                    [self sendNotificationForModifyingInfoWithValue:inputContent forKey:KEY_ADDRESS whichWithAnIndex:KEY_ADDRESS_NUM];
                } onError:^(RESTError *engineError) {
                    NSLog(@"Error:%@",engineError.errorDescription);
                    [self showErrorTipsAlertWithMessage:engineError.errorDescription];
                }];
                }else{
                    [self showErrorTipsAlertWithMessage:ERROR_COMPANYADDRESS_FORMAT];
                }
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
    }

}

-(void)sendNotificationForModifyingInfoWithValue:(NSString *)value forKey:(NSString *)key whichWithAnIndex:(NSInteger)index{
//    [NSThread sleepForTimeInterval:3];
    NSNotification *notification = [NSNotification notificationWithName:NOTIFICATIONNAME_MODIFY object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:value,key,[NSNumber numberWithInteger:index],TEXT_KEY, nil]];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}



//弹出错误提示对话框
-(void)showErrorTipsAlertWithMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

//初始化View以及加上本地数据
-(void)initViews{
    [[self view]setBackgroundColor:[[UIColor alloc] initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
    switch(self.type){
        case TypeName:
            [self.navigationItem setTitle:@"修改姓名"];
            [self setupInputAreaWithNumberOfLines:1 defaultContent:_uModel.name andHint:@"请输入姓名"];
            break;
        case TypePost:
            [self.navigationItem setTitle:@"修改职位"];
            [self setupInputAreaWithNumberOfLines:1 defaultContent:_uModel.post andHint:@"请输入职位"];
            break;
        case TypeCompany:
            [self.navigationItem setTitle:@"修改公司名称"];
            [self setupInputAreaWithNumberOfLines:1 defaultContent:_uModel.company andHint:@"请输入公司名称"];
            break;
        case TypeQQNum:
            [self.navigationItem setTitle:@"修改QQ号码"];
            [self setupInputAreaWithNumberOfLines:1 defaultContent:_uModel.qq andHint:@"请输入QQ号码"];
            break;
        case TypeBussinessAddress:
            [self.navigationItem setTitle:@"修改地址"];
            [self setupInputAreaWithNumberOfLines:3 defaultContent:_uModel.business_address andHint:@"请输入办公地址"];
            break;
    }
    [self.view addSubview:_inputArea];
}

//初始化输入框
-(void)setupInputAreaWithNumberOfLines:(int)num defaultContent:(NSString *)content andHint:(NSString*)hint {
    _inputArea = [[EditText alloc]initWithFrame:CGRectMake(10, 10, [[UIScreen mainScreen]bounds].size.width-20, 44*num)];
    [_inputArea setBackgroundColor: [UIColor whiteColor]];
    [_inputArea setPlaceholderText:hint];
    [_inputArea setText:content];
    [_inputArea setFont:[UIFont systemFontOfSize:15]];
    [_inputArea setTextColor:[UIColor blackColor]];
    _inputArea.layer.cornerRadius = 10.0f;
    _inputArea.layer.borderWidth = 1.0f;
    _inputArea.layer.borderColor = [[UIColor alloc]initWithRed:207.0f/255.0f green:207.0f/255.0f blue:207.0f/255.0f alpha:1].CGColor;
}

@end
