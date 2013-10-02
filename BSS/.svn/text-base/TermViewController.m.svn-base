//
//  TermViewController.m
//  BSS
//
//  Created by zhangbo on 13-9-22.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "TermViewController.h"

@interface TermViewController ()

@end

@implementation TermViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitleAndBtnBack];
}

#pragma mark 设置标题与返回按钮
-(void)setTitleAndBtnBack
{
    //设置标题与返回按钮
	[self setTitle:@"业务通服务使用协议"];
    
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
    [btn addTarget:self action:@selector(btnPressToBackResUserNo) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btnBack=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=btnBack;
    
    self.view.backgroundColor=[UIColor whiteColor];
}

#pragma mark 返回事件
-(void)btnPressToBackResUserNo
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
