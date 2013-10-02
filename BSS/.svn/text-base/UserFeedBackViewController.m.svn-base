//
//  UserFeedBackViewController.m
//  BSS
//
//  Created by liuc on 13-9-26.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "UserFeedBackViewController.h"
#import "EditText.h"
#import <QuartzCore/QuartzCore.h>

#define TITLE @"反馈"

#define TEXT_BACK @"  返回"
#define TEXT_UPLOAD @"提交"
#define TEXT_UPLOADED @"提交成功"
#define TEXT_CONFIRM @"确定"
#define TEXT_TIP @"提示"
#define TEST_CANNOTBEEMPTY @"请输入内容"

#define NAME_IMG_BACK_NORMAL @"button_orange_back"
#define NAME_IMG_BACK_HIGHTLIGHTED @"button_orange_back_pressed"
#define NAME_IMG_UPLOAD_NORMAL @"button_orange_square"
#define NAME_IMG_UPLOAD_HIGHTLITED @"button_orange_square_pressed"

#define INPUT_TIPS @"欢迎您提出宝贵的意见和建议，您留下的每个字都将用来改善我们的软件。"
#define INPUT_HINT @"请输入您的反馈（500字以内）"
#define UPLOAD_FINISHED_TIPS @"我们已经收到您的反馈，感谢您对天工业务通的支持，如有需要我们会与您联系"

@interface UserFeedBackViewController ()

@property (nonatomic, strong) EditText *edtxt;
@property (nonatomic, strong) UILabel *lblTips;

@property (nonatomic, strong) UIButton *hideKeyboardHelper;

@end

@implementation UserFeedBackViewController

-(void)loadView{
    [super loadView];
    
    [self prepareFrame];
    
}

//Base frame
-(void)prepareFrame{
    [self.navigationItem setTitle:TITLE];
    
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
    [btnBack setBackgroundImage:[UIImage imageNamed:NAME_IMG_BACK_NORMAL] forState:UIControlStateNormal];
    [btnBack setBackgroundImage:[UIImage imageNamed:NAME_IMG_BACK_HIGHTLIGHTED] forState:UIControlStateHighlighted];
    [btnBack setTitle:TEXT_BACK forState:UIControlStateNormal];
    [btnBack.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btnBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnBack addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnBack setTag:100];
    
    //Upload button
    UIButton *btnUpload = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnUpload setBackgroundColor:[UIColor clearColor]];
    [btnUpload setFrame:CGRectMake(10,10, 46, 27)];
    [btnUpload setBackgroundImage:[UIImage imageNamed:NAME_IMG_UPLOAD_NORMAL] forState:UIControlStateNormal];
    [btnUpload setBackgroundImage:[UIImage imageNamed:NAME_IMG_UPLOAD_HIGHTLITED] forState:UIControlStateHighlighted];
    [btnUpload setTitle:TEXT_UPLOAD forState:UIControlStateNormal];
    [btnUpload.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btnUpload setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnUpload addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnUpload setTag:101];
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btnUpload];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view setBackgroundColor:[[UIColor alloc] initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
    
    CGSize lblSize = [self obtainCGSizeOfLabelInWrapStateByString:INPUT_TIPS virtualSize:CGSizeMake(self.view.bounds.size.width-20, 1000) andFont:[UIFont systemFontOfSize:15]];
    _lblTips = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, lblSize.width, lblSize.height)];
    [_lblTips setNumberOfLines:0];
    [_lblTips setFont:[UIFont systemFontOfSize:15]];
    [_lblTips setBackgroundColor:[UIColor clearColor]];
    [_lblTips setTextColor:[UIColor blackColor]];
    [_lblTips setText:INPUT_TIPS];
    [self.view addSubview:_lblTips];
    
    _edtxt = [[EditText alloc]initWithFrame:CGRectMake(10, 20+lblSize.height, self.view.bounds.size.width-20, 44*3)];
    [_edtxt setFont:[UIFont systemFontOfSize:15]];
    _edtxt.placeholderText = INPUT_HINT;
    _edtxt.layer.cornerRadius = 10.0f;
    _edtxt.layer.borderWidth = 1.0f;
    _edtxt.layer.borderColor = [[UIColor alloc]initWithRed:207.0f/255.0f green:207.0f/255.0f blue:207.0f/255.0f alpha:1].CGColor;
    [self.view addSubview:_edtxt];
    
}

//Size of Wrap Text Content
-(CGSize)obtainCGSizeOfLabelInWrapStateByString:(NSString *)content virtualSize:(CGSize)size andFont:(UIFont *)font {
    CGSize actSize = [content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return actSize;
}

-(void)onClick:(UIButton *)btn{
    switch(btn.tag){
        case 100:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 101:
            [self uploadFeedBackMessage];
            break;
        case 111:
            if(_edtxt){
                [_edtxt resignFirstResponder];
            }
            break;
    }
}

//提交信息
-(void)uploadFeedBackMessage{
    if(_edtxt.text.length > 0){
        [[AFNetEngine shareEngine]opFeedbackMessage:_edtxt.text onSucceeded:^(NSDictionary *dictionary) {
            [self showTipsAlertWithMessage:UPLOAD_FINISHED_TIPS andTitle:TEXT_UPLOADED];
            [self.navigationController popViewControllerAnimated:YES];
        } onError:^(RESTError *engineError) {
            [self showTipsAlertWithMessage:engineError.errorDescription andTitle:TEXT_TIP];
        }];
    }else{
        [self showTipsAlertWithMessage:TEST_CANNOTBEEMPTY andTitle:TEXT_TIP];
    }
}

//弹出错误提示对话框
-(void)showTipsAlertWithMessage:(NSString *)message andTitle:(NSString *)title {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:TEXT_CONFIRM otherButtonTitles:nil, nil];
    [alertView show];
}

//隐藏TabBar
-(id)hideTabBarWhenPushed{
    [self setHidesBottomBarWhenPushed:YES];
    return self;
}

@end
