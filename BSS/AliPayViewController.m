//
//  AliPayViewController.m
//  BSS
//
//  Created by zhangbo on 13-9-25.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "AliPayViewController.h"
#import "Alert.h"
#import "ActionSheet.h"
#import "AlixPay.h"

@interface AliPayViewController ()

@end

@implementation AliPayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithPurpose:(NSInteger)iPurpose andLocation:(NSString *)strLocation andAreaNo:(NSString *)strAreaNo
{
    self=[super init];
    if(self)
    {
        _strAreaNo=strAreaNo;
        _purpose=iPurpose;
        _strLocation=strLocation;
        
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    _width = self.view.bounds.size.width;
    _height = self.view.bounds.size.height;
    
    [self setTitleAndNavigationBar];
    
    [self paintAlertAndServiceBtn];
    
    [self paintBtnPay];
    
    [self paintAlert];
}

#pragma mark 设置标题与返回按钮
-(void)setTitleAndNavigationBar
{
    [self.navigationItem setTitle:@"购买服务"];
    self.view.backgroundColor=[[UIColor alloc] initWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(10, 10, 46, 27);
    [btn setBackgroundImage:[UIImage imageNamed:@"button_orange_back"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"button_orange_back_pressed"] forState:UIControlStateHighlighted];
    UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(12, -1, 30, 27)];
    lblTitle.text=@"返回";
    lblTitle.font=[UIFont systemFontOfSize:13];
    lblTitle.textColor=[UIColor whiteColor];
    lblTitle.backgroundColor=[UIColor clearColor];
    [btn addSubview:lblTitle];
    [btn addTarget:self action:@selector(btnPressToBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btnBack=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=btnBack;
}

-(void)paintAlertAndServiceBtn
{
    _lblAlert=[[UILabel alloc] initWithFrame:CGRectMake(10,10,_width-10,40)];
    _lblAlert.backgroundColor=[[UIColor alloc] initWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    _lblAlert.text=[NSString stringWithFormat:@"温馨提示:您当前服务区域是%@，若需改变服务地区，请再下面选择。",@"广东省"];
    _lblAlert.font=[UIFont systemFontOfSize:13];
    _lblAlert.lineBreakMode=UILineBreakModeWordWrap;
    _lblAlert.numberOfLines=0;
    [self.view addSubview:_lblAlert];
    
    _btnProvince=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btnProvince setImage:[UIImage imageNamed:@"button_service_press"] forState:UIControlStateHighlighted];
    _btnProvince.frame=CGRectMake(10,60,_width-20,44);
    [_btnProvince addTarget:self action:@selector(btnPressToSelectProvince:) forControlEvents:UIControlEventTouchUpInside];
    [_btnProvince addTarget:self action:@selector(btnPressToHighLight:) forControlEvents:UIControlEventTouchDown];
    
    _lblService=[[UILabel alloc] initWithFrame:CGRectMake(_width/2-150,10,60,20)];
    _lblService.text=@"服务区域";
    _lblService.backgroundColor=[UIColor clearColor];
    [_lblService setTextColor:[UIColor blackColor]];
    [_lblService setHighlightedTextColor:[UIColor whiteColor]];
    _lblService.font=[UIFont systemFontOfSize:13];
    [_btnProvince addSubview:_lblService];
    
    _lblProvince=[[UILabel alloc] initWithFrame:CGRectMake(_width-130,10,100,20)];
    _lblProvince.backgroundColor=[UIColor clearColor];
    _lblProvince.text=[NSString stringWithFormat:@"%@ >",@"广东省"];
    [_lblProvince setHighlightedTextColor:[UIColor whiteColor]];
    _lblProvince.textAlignment=UITextAlignmentRight;
    _lblProvince.font=[UIFont systemFontOfSize:13];
    [_btnProvince addSubview:_lblProvince];
    
    [self.view addSubview:_btnProvince];
    
}

-(void)changeAlert
{
    if(_purpose==0)
    {
        _lblAlert.text=[NSString stringWithFormat:@"温馨提示:您当前服务区域是%@，若需改变服务地区，请再下面选择。",_strLocation];
    }
    else
    {
        _lblAlert.text=[NSString stringWithFormat:@"选择购买工程信息服务地区"];
    }
}

-(void)btnPressToHighLight:(UIButton *)button
{
    _lblProvince.highlighted=YES;
    _lblService.highlighted=YES;
}

-(void)btnPressToSelectProvince:(UIButton *)button
{
    _lblProvince.highlighted=NO;
    _lblService.highlighted=NO;
    
    _sheet = [[ActionSheet alloc] initWithHeight:400.0f WithSheetTitle:@"选择服务地区"];
    _tbProvince=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 400-88)];
    _tbProvince.dataSource=self;
    _tbProvince.delegate=self;
    [_sheet.view addSubview:_tbProvince];
	
    
    if(_arrProvince==nil)
    {
        [[AFNetEngine shareEngine] opAreaUseCache:NO
                                      onSucceeded:^(NSArray *areaDicArray){
                                          DLog(@"获取到%d个地区资料",areaDicArray.count);
                                          _arrProvince=areaDicArray;
                                          
                                          [_tbProvince reloadData];
                                          
                                          [_sheet showInView:[UIApplication sharedApplication].keyWindow];
                                          
                                      } onError:^(RESTError *engineError) {
                                          ELog(engineError);
                                      }];
        
    }
    else
    {
        //[_tbProvince reloadData];
        [_sheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    
}

-(void)paintBtnPay
{
    _btnPay=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btnPay setTitle:@"确 定" forState:UIControlStateNormal];
    [_btnPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnPay setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [_btnPay addTarget:self action:@selector(btnPressToPay:) forControlEvents:UIControlEventTouchUpInside];
    _btnPay.frame=CGRectMake(_width/2-50, 130, 100, 35);
    [_btnPay setBackgroundImage:[UIImage imageNamed:@"button_orange"] forState:UIControlStateNormal];
    
    UIActivityIndicatorView *aiLogin=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    aiLogin.frame=CGRectMake(_width/2-108, 3.5, 30, 30);
    [_btnPay addSubview:aiLogin];
    
    [self.view addSubview:_btnPay];
}

-(void)paintAlert
{
    UILabel *lblAlert=[[UILabel alloc] initWithFrame:CGRectMake(10,190,_width-20,20)];
    NSString *strAlert=@"注意：1）服务区域选择后，在服务期内不可修改";
    lblAlert.text=strAlert;
    lblAlert.backgroundColor=[[UIColor alloc] initWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    lblAlert.font=[UIFont systemFontOfSize:13];
    lblAlert.lineBreakMode=UILineBreakModeWordWrap;
    lblAlert.numberOfLines=0;
    [self.view addSubview:lblAlert];
    
    UILabel *lblAlert2=[[UILabel alloc] initWithFrame:CGRectMake(50,210,_width-20,20)];
    NSString *strAlert2=@"2）一个帐号不可开通多个省份";
    lblAlert2.text=strAlert2;
    lblAlert2.backgroundColor=[[UIColor alloc] initWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    lblAlert2.font=[UIFont systemFontOfSize:13];
    lblAlert2.lineBreakMode=UILineBreakModeWordWrap;
    lblAlert2.numberOfLines=0;
    [self.view addSubview:lblAlert2];
    
    
}

-(void)btnPressToPay:(UIButton *)button
{
    
    if(_strAreaNo.length==0)
    {
        [Alert show:@"没有选取服务地区"];
    }
    
    [[AFNetEngine shareEngine] opPaymentWithArea:_strAreaNo onSucceeded:^(NSString *aString) {
        DLog(@"支付返回信息是：%@",aString);
        //提交地区信息获取订单信息
        NSString *strOrder=aString;
        //应用注册scheme,在BSS-Info.plist定义URL types,用于快捷支付成功后重新唤起商户应用
        NSString *strAppScheme=@"BSS";
        
        
        
        //获取快捷支付单例并调用快捷支付接口
        AlixPay * alixpay = [AlixPay shared];
        int ret = [alixpay pay:strOrder applicationScheme:strAppScheme];
        
        if (ret == kSPErrorAlipayClientNotInstalled) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:@"您还没有安装支付宝快捷支付，请先安装。"
                                                                delegate:self
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:nil];
            [alertView setTag:123];
            [alertView show];
        }
        else if (ret == kSPErrorSignError) {
            NSLog(@"签名错误！");
            [Alert show:@"签名错误"];
        }
        
        
    } onError:^(RESTError *engineError) {
        ELog(engineError);
        [Alert show:engineError.errorDescription];

    }];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 123) {
		NSString * URLString = @"http://itunes.apple.com/cn/app/id535715926?mt=8";
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
	}
}

-(void)btnPressToBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 34;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    static NSString *cellID = @"cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil)
    {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [self processTbProvince:cell indexPath:indexPath];
    return cell;
}

-(void)processTbProvince:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[_arrProvince objectAtIndex:indexPath.row];
    cell.textLabel.text = dic[@"name"];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.textLabel.textAlignment=UITextAlignmentCenter;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.opaque=NO;
    if(indexPath.row%2==0)
    {
        UIView *bgV = [[UIView alloc]initWithFrame:cell.contentView.bounds];
        [bgV setBackgroundColor:[[UIColor alloc] initWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1.0]];
        [cell setBackgroundView:bgV];
    }
    else
    {
        UIView *bgV = [[UIView alloc]initWithFrame:cell.contentView.bounds];
        [bgV setBackgroundColor:[[UIColor alloc] initWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0]];
        [cell setBackgroundView:bgV];
    }
    cell.layer.borderWidth=0.5;
    
    cell.layer.borderColor=[[UIColor alloc] initWithRed:0.00 green:0.20 blue:0.01 alpha:0.1].CGColor;
    
    UIView *bgV = [[UIView alloc]initWithFrame:cell.contentView.bounds];
    [bgV setBackgroundColor:[[UIColor alloc] initWithRed:1.0 green:0.0 blue:0 alpha:1.0]];
    [cell setSelectedBackgroundView:bgV];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_arrProvince==nil)
    {
        return;
    }
    NSDictionary *dic=[_arrProvince objectAtIndex:indexPath.row];
    _lblProvince.text=[NSString stringWithFormat:@"%@ >",dic[@"name"]];
    _strAreaNo=dic[@"no"];
    [_sheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self changeAlert];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
