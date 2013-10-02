//
//  UserNoInfoViewController.m
//  BSS
//
//  Created by zhangbo on 13-9-25.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "UserNoInfoViewController.h"
#import "AFNetEngine.h"
#import "RTLabel.h"
#import "Alert.h"
#import "ActivityIndicator.h"
#import "AliPayViewController.h"

@interface UserNoInfoViewController ()

@end

@implementation UserNoInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //[self getData];
    }
    return self;
}

-(id)initWithAreaName:(NSString *)strName andAreaNo:(NSString *)strAreaNo
{
    self=[super init];
    if(self)
    {
        _strAreaName=strName;
        _strAreaNo=strAreaNo;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    _width = self.view.bounds.size.width;
    _height = self.view.bounds.size.height;
    
    [self setTitleAndNavigationBar];
    
    [self paintUserInfo];
    
    [self paintBtnPay];
}

#pragma mark 设置标题与返回按钮
-(void)setTitleAndNavigationBar
{
    [self.navigationItem setTitle:@"帐号信息"];
    
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

-(void)getProvinceData
{
    //查看缓存的地区资料
    NSString* tempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"areas.json"];
        
    NSData *data=[NSData dataWithContentsOfFile:tempFile];
    id jsonobject=nil;
    if (data)
    {
        jsonobject=[NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingAllowFragments
                                                         error:nil];
        DLog(@"%@",jsonobject);
        _jsonArea=jsonobject;
    }
    else
    {
        [[AFNetEngine shareEngine] opAreaUseCache:NO
                                      onSucceeded:^(NSArray *areaDicArray){
                                          DLog(@"获取到%d个地区资料",areaDicArray.count);
                                          _jsonArea=areaDicArray;
                                          [self getProvinceData];
                                          
                                      } onError:^(RESTError *engineError) {
                                          ELog(engineError);
                                      }];
    }

    
}

-(void)getData
{
    [[AFNetEngine shareEngine] opGetAllInfoOnSucceeded:^(JSONModel *jsonObject) {
        if ([jsonObject isKindOfClass:[UserModel class]]) {
            UserModel *user=(UserModel *)jsonObject;
            if(_user!=nil)
            {
                _user=nil;
                _user=user;
            }
            else
            {
                _user=user;
            }
            [self changeUserInfo];
            DLog(@"全部资料 %@,%@",user.name,user.permission);
            DLog(@"用户服务信息 %@, %@",user.permission,user.region);
            _user=user;
        }
        
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

-(void)paintUserInfo
{
    
    _userInfoComponent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 110)];
    [_userInfoComponent setBackgroundColor:[UIColor clearColor]];
    _imgUserIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    _imgUserIcon.layer.cornerRadius = 5.0f;
    [_imgUserIcon setImage:[UIImage imageNamed:@"icon_head_portrait" ]];
    [_userInfoComponent addSubview:_imgUserIcon];
    
    _lblUserName=[[UILabel alloc] initWithFrame:CGRectMake(70, 10, _width-120, 20)];
    //_lblUserName.text=@"谢涛";
    _lblUserName.font=[UIFont systemFontOfSize:15];
    [_userInfoComponent addSubview:_lblUserName];
    
    _lblUserIdentify=[[UILabel alloc] initWithFrame:CGRectMake(70, 35, _width-120, 20)];
    //_lblUserIdentify.text=@"正式会员";
    _lblUserIdentify.font=[UIFont systemFontOfSize:14];
    [_userInfoComponent addSubview:_lblUserIdentify];
    
    
    
    _lblInfo= [[RTLabel alloc] initWithFrame:CGRectMake(10,70,_width-10,40)];
	//[label setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20]];
    //换行
    [_lblInfo setParagraphReplacement:@""];
    [_lblInfo setBackgroundColor:[UIColor clearColor]];
    //[_lblInfo setText:@"<font face='HelveticaNeue-CondensedBold' size=14><p align=justify>还可以查看广东省的<font color=red>82</font>条工程信息,<font color=red>14</font>个设计师名片,会员服务还剩下<font color=red>70</font>天</font>"];
    [_userInfoComponent addSubview:_lblInfo];
    
    [self.view addSubview:_userInfoComponent];
}

-(void)paintBtnPay
{
    _btnPay=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[_btnPay setTitle:@"续 费" forState:UIControlStateNormal];
    [_btnPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnPay setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [_btnPay addTarget:self action:@selector(btnPressToPay:) forControlEvents:UIControlEventTouchUpInside];
    _btnPay.frame=CGRectMake(10, 110, 80, 35);
    [_btnPay setBackgroundImage:[UIImage imageNamed:@"button_orange"] forState:UIControlStateNormal];
    
    UIActivityIndicatorView *aiLogin=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    aiLogin.frame=CGRectMake(_width/2-108, 3.5, 30, 30);
    [_btnPay addSubview:aiLogin];
    
    [self.view addSubview:_btnPay];
}

-(void)changeUserInfo
{
    if([_user.permission isEqualToString:@"正式会员"])
    {
        
        _lblUserName.text=_user.name;
        _lblUserIdentify.text=@"正式会员";
        NSString *strText=[NSString stringWithFormat:@"<font face='HelveticaNeue-CondensedBold' size=14><p align=justify>还可以查看%@的<font color=red>%@</font>条工程信息,<font color=red>%@</font>个设计师名片,会员服务还剩下<font color=red>%@</font>天</font>",[self getAreaNameByAreaNo:_user.region],_user.unlock_count_left,_user.unlock_designerdetail_count_left,_user.time_left];
        [_lblInfo setText:strText];
        [_btnPay setTitle:@"续 费" forState:UIControlStateNormal];
    }
    else
    {
        _lblUserName.text=_user.name;
        _lblUserIdentify.text=@"试用会员";
        
        [_lblInfo setText:[NSString stringWithFormat:@"<font face='HelveticaNeue-CondensedBold' size=14><p align=justify>还可查看%@的<font color=red>%@</font>条工程信息,<font color=red>%@</font>个设计师名片</font>",@"广东省",_user.unlock_count_left,_user.unlock_designerdetail_count_left]];
        [_btnPay setTitle:@"购买服务" forState:UIControlStateNormal];
    }
}

-(NSString *)getAreaNameByAreaNo:(NSString *)areaNo
{
    NSInteger i=[[[areaNo componentsSeparatedByString:@"."] objectAtIndex:1] intValue];
    return [_jsonArea objectAtIndex:i-1][@"name"];
}

-(void)btnPressToPay:(UIButton *)button
{
    if([_lblUserIdentify.text isEqualToString:@"正式会员"])
    {
        AliPayViewController *aliPay=[[AliPayViewController alloc] initWithPurpose:0 andLocation:@"广东省" andAreaNo:@"1.11"];
        [aliPay setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:aliPay animated:YES];
    }
    else
    {
        AliPayViewController *aliPay=[[AliPayViewController alloc] initWithPurpose:1 andLocation:@"广东省" andAreaNo:@"1.11"];
        [aliPay setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:aliPay animated:YES];
    }
    
}

-(void)btnPressToBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getProvinceData];
    [self getData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self changeUserInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
