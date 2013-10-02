//
//  ReAuthProcessor.m
//  BSS
//
//  Created by liuc on 13-9-29.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "ReAuthProcessor.h"
#import "DDAlertPrompt.h"
#import <QuartzCore/QuartzCore.h>

#define TEXT_LOGIN @"登录"
#define TEXT_CANCEL @"取消"
#define TEXT_CONFIRM @"确定"
#define TEXT_PLEASEWAIt @"请稍等..."
#define TEXT_TIP @"提示"

@interface ReAuthProcessor()

@property (nonatomic, strong) DDAlertPrompt *alert;

@property (nonatomic, strong) UIImage *bacImage;
@property (nonatomic, strong) UIViewController *ctrl;

@end

@implementation ReAuthProcessor

-(id)initByController:(UIViewController *)ctrl{
    self = [super init];
    if(self){
        _ctrl = ctrl;
    }
    return self;
}

-(void)initBackgroundImage{
    UIView *viewBoard = _ctrl.view;
    UIGraphicsBeginImageContext(viewBoard.bounds.size);
    [viewBoard.layer renderInContext:UIGraphicsGetCurrentContext()];
    _bacImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void)loadView{
    [super view];
    [self initBackgroundImage];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:_bacImage]];
    [self show];
}

-(void)show{
    _alert = [[DDAlertPrompt alloc]initWithTitle:TEXT_LOGIN delegate:self cancelButtonTitle:TEXT_CANCEL otherButtonTitle:TEXT_LOGIN];
    [_alert setTag:100];
    [_alert show];
    
}

- (void)didPresentAlertView:(UIAlertView *)alertView{
    if(_alert.tag == alertView.tag){
        [_alert.plainTextField becomeFirstResponder];
        [_alert setNeedsLayout];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(_alert.tag == alertView.tag){
        if(buttonIndex == alertView.cancelButtonIndex){
        }else{
            UIAlertView *alertView = [self showWaitingProgress];
            [[AFNetEngine shareEngine]requestTokenWithUserName:_alert.plainTextField.text passWord:_alert.secretTextField.text onSucceeded:^{
                [alertView dismissWithClickedButtonIndex:0 animated:YES];
            } onError:^(RESTError *engineError) {
                [alertView dismissWithClickedButtonIndex:0 animated:YES];
                [self showErrorWithTitle:TEXT_TIP message:engineError.errorDescription];
            }];
        }
    }
}

-(UIAlertView *)showWaitingProgress{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:TEXT_PLEASEWAIt message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    indicator.center = alertView.center;
    [indicator startAnimating];
    [alertView addSubview:indicator];
    [alertView show];
    
    return alertView;
}

-(void)showErrorWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:TEXT_CONFIRM otherButtonTitles:nil, nil];
    [alertView show];
}

@end
