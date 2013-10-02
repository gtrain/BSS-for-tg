//
//  AppInfoViewController.m
//  BSS
//
//  Created by liuc on 13-9-26.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "AppInfoViewController.h"
#import "TermViewController.h"

#define TITLE @"关于"

#define TEXT_BACK @"  返回"
#define NAME_IMG_BACK_NORMAL @"button_orange_back"
#define NAME_IMG_BACK_HIGHTLIGHTED @"button_orange_back_pressed"

#define APPNAME @"天工业务通"
#define LEVEL @"v1.0"
#define SERVER_TEL_KEY @"客服电话："
#define SERVER_TEL_VALUE @"020-37570264"
#define SERVER_TEL_ACTUAL @"02037570264"
#define OFFICAL_WS_KEY @"官方网站："
#define OFFICAL_WS_VALUE @"tgnet.com/IOS"

#define TEXT_LICENCE @"天工业务通服务使用协议"
#define TEXT_CN_COPYRIGHT @"天工网 版权所有"
#define TEXT_EN_COPYRIGHT @"Copyright© 2013 Tgnet.com All Rights Reserved"

@interface AppInfoViewController ()

@property (assign) CGFloat width ;
@property (assign) CGFloat height;

@property (nonatomic, strong) UIView *centerComponent;
@property (nonatomic, strong) UIView *bottomComponent;

@property (nonatomic, strong) UILabel *lblAppName;
@property (nonatomic, strong) UILabel *lblAppLevel;
@property (nonatomic, strong) UILabel *lblServerTelKey;
@property (nonatomic, strong) UIButton *btnServerTelValue;
@property (nonatomic, strong) UILabel *lblOfficalWSKey;
@property (nonatomic, strong) UIButton *btnOfficalWSValue;

@property (nonatomic, strong) UIButton *btnLicence;
@property (nonatomic, strong) UILabel *lblCNCopyRight;
@property (nonatomic, strong) UILabel *lblENCopyRight;
    
@end

@implementation AppInfoViewController

-(void)loadView{
    [super loadView];
    
    [self prepareFrame];
    
    [self arrangeComponents];
    
}

-(void)prepareFrame{
    [self.navigationItem setTitle:TITLE];
    
    _width = self.view.bounds.size.width;
    _height = self.view.bounds.size.height;
    
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
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.view setBackgroundColor:[[UIColor alloc] initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
    
}

-(void)arrangeComponents{
    
    [self packCenterComponent];
    [self packBottomComponent];
    
    
    CGFloat spaceH = (_height - _centerComponent.bounds.size.height - _bottomComponent.bounds.size.height - self.navigationController.navigationBar.bounds.size.height)/2-4;
    
    [_centerComponent setFrame:CGRectMake(0, spaceH, _centerComponent.bounds.size.width, _centerComponent.bounds.size.height)];
    [_bottomComponent setFrame:CGRectMake(0, 2*spaceH+_centerComponent.bounds.size.height, _bottomComponent.bounds.size.width, _bottomComponent.bounds.size.height)];
    
    [self.view addSubview:_centerComponent];
    [self.view addSubview:_bottomComponent];
    
}


-(void)packCenterComponent{
    
    UIColor *clearColor = [UIColor clearColor];
    CGFloat acHeight = 0.0f;
    _lblAppName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width, 44)];
    [_lblAppName setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:25]];
    [_lblAppName setTextAlignment:NSTextAlignmentCenter];
    [_lblAppName setText:APPNAME];
    [_lblAppName setBackgroundColor:clearColor];
    acHeight = acHeight + _lblAppName.bounds.size.height;
    
    UIFont *font = [UIFont systemFontOfSize:18];
    
    _lblAppLevel = [[UILabel alloc]initWithFrame:CGRectMake(0, acHeight, _width, 13)];
    [_lblAppLevel setFont:font];
    [_lblAppLevel setTextAlignment:NSTextAlignmentCenter];
    [_lblAppLevel setText:LEVEL];
    [_lblAppLevel setBackgroundColor:clearColor];
    acHeight = acHeight + _lblAppLevel.bounds.size.height;
    
    CGSize sizeKey = [self obtainCGSizeOfLabelInWrapStateByString:SERVER_TEL_KEY virtualSize:CGSizeMake(_width, _height) andFont:font];
    CGSize sizeValue = [self obtainCGSizeOfLabelInWrapStateByString:SERVER_TEL_VALUE virtualSize:CGSizeMake(_width, _height) andFont:font];
    CGFloat spaceW = (_width - sizeKey.width - sizeValue.width)/2;
    
    _lblServerTelKey = [[UILabel alloc]initWithFrame:CGRectMake(spaceW, acHeight, sizeKey.width, sizeKey.height)];
    [_lblServerTelKey setText:SERVER_TEL_KEY];
    [_lblServerTelKey setFont:font];
    [_lblServerTelKey setTextColor:[UIColor grayColor]];
    [_lblServerTelKey setBackgroundColor:clearColor];
    
    _btnServerTelValue = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnServerTelValue setFrame:CGRectMake(spaceW+sizeKey.width, acHeight, sizeValue.width, sizeValue.height)];
    [_btnServerTelValue setBackgroundColor:clearColor];
    [_btnServerTelValue setTitle:SERVER_TEL_VALUE forState:UIControlStateNormal];
    [_btnServerTelValue setTitle:SERVER_TEL_VALUE forState:UIControlStateHighlighted];
    [_btnServerTelValue setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_btnServerTelValue setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [_btnServerTelValue.titleLabel setFont:font];
    [_btnServerTelValue setTag:101];
    [_btnServerTelValue addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    acHeight = acHeight + sizeKey.height;
    
    sizeKey = [self obtainCGSizeOfLabelInWrapStateByString:OFFICAL_WS_KEY virtualSize:CGSizeMake(_width, _height) andFont:font];
    sizeValue = [self obtainCGSizeOfLabelInWrapStateByString:OFFICAL_WS_VALUE virtualSize:CGSizeMake(_width, _height) andFont:font];
    spaceW = (_width - sizeKey.width - sizeValue.width)/2;
    
    _lblOfficalWSKey = [[UILabel alloc]initWithFrame:CGRectMake(spaceW, acHeight, sizeKey.width, sizeKey.height)];
    [_lblOfficalWSKey setText:OFFICAL_WS_KEY];
    [_lblOfficalWSKey setFont:font];
    [_lblOfficalWSKey setTextColor:[UIColor grayColor]];
    [_lblOfficalWSKey setBackgroundColor:clearColor];
    
    _btnOfficalWSValue = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnOfficalWSValue setFrame:CGRectMake(spaceW+sizeKey.width, acHeight, sizeValue.width, sizeValue.height)];
    [_btnOfficalWSValue setBackgroundColor:clearColor];
    [_btnOfficalWSValue setTitle:OFFICAL_WS_VALUE forState:UIControlStateNormal];
    [_btnOfficalWSValue setTitle:OFFICAL_WS_VALUE forState:UIControlStateHighlighted];
    [_btnOfficalWSValue setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_btnOfficalWSValue setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [_btnOfficalWSValue.titleLabel setFont:font];
    [_btnOfficalWSValue setBackgroundColor:clearColor];
    [_btnOfficalWSValue setTag:102];
    [_btnOfficalWSValue addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    acHeight = acHeight + sizeKey.height;
    
    
    _centerComponent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, acHeight)];
    
    [_centerComponent addSubview:_lblAppName];
    [_centerComponent addSubview:_lblAppLevel];
    [_centerComponent addSubview:_lblServerTelKey];
    [_centerComponent addSubview:_lblOfficalWSKey];
    [_centerComponent addSubview:_btnServerTelValue];
    [_centerComponent addSubview:_btnOfficalWSValue];
    
}

-(void)packBottomComponent{
    UIColor *clearColor = [UIColor clearColor];
    CGFloat acHeight = 0.0f;
    UIFont *font = [UIFont systemFontOfSize:12];
    
    
    CGSize sizeCtn = [self obtainCGSizeOfLabelInWrapStateByString:TEXT_LICENCE virtualSize:CGSizeMake(_width, _height) andFont:font];
    
    _btnLicence = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnLicence setFrame:CGRectMake((_width - sizeCtn.width)/2, acHeight, sizeCtn.width, sizeCtn.height+1)];
    [_btnLicence setBackgroundColor:clearColor];
    [_btnLicence setTitle:TEXT_LICENCE forState:UIControlStateNormal];
    [_btnLicence setTitle:TEXT_LICENCE forState:UIControlStateHighlighted];
    [_btnLicence setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_btnLicence setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [_btnLicence.titleLabel setFont:font];
    [_btnLicence setBackgroundColor:clearColor];
    [_btnLicence setTag:103];
    [_btnLicence addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btnLicence setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    acHeight = sizeCtn.height+acHeight;
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, sizeCtn.height, sizeCtn.width, 1)];
    [_btnLicence addSubview:line];
    [line setBackgroundColor:[UIColor blueColor]];
    acHeight = 1 + acHeight;
    
    _lblCNCopyRight = [[UILabel alloc]initWithFrame:CGRectMake(0, acHeight, _width, sizeCtn.height+4)];
    [_lblCNCopyRight setText:TEXT_CN_COPYRIGHT];
    [_lblCNCopyRight setBackgroundColor:clearColor];
    [_lblCNCopyRight setFont:font];
    [_lblCNCopyRight setTextColor:[UIColor grayColor]];
    [_lblCNCopyRight setTextAlignment:NSTextAlignmentCenter];
    acHeight = _lblCNCopyRight.bounds.size.height+acHeight;
    
    _lblENCopyRight  = [[UILabel alloc]initWithFrame:CGRectMake(0, acHeight, _width, sizeCtn.height)];
    [_lblENCopyRight setText:TEXT_EN_COPYRIGHT];
    [_lblENCopyRight setBackgroundColor:clearColor];
    [_lblENCopyRight setFont:font];
    [_lblENCopyRight setTextColor:[UIColor grayColor]];
    [_lblENCopyRight setTextAlignment:NSTextAlignmentCenter];
    acHeight = sizeCtn.height+acHeight;
    
    
    _bottomComponent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, acHeight)];
    
    [_bottomComponent addSubview:_btnLicence];
    [_bottomComponent addSubview:_lblCNCopyRight];
    [_bottomComponent addSubview:_lblENCopyRight];
    
}

//Size of Wrap Text Content
-(CGSize)obtainCGSizeOfLabelInWrapStateByString:(NSString *)content virtualSize:(CGSize)size andFont:(UIFont *)font {
    CGSize actSize = [content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return actSize;
}


//隐藏TabBar
-(id)hideTabBarWhenPushed{
    [self setHidesBottomBarWhenPushed:YES];
    return self;
}

-(void)onClick:(UIButton *)btn{
    switch(btn.tag){
        case 100:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 101:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:SERVER_TEL_ACTUAL]]];
            break;
        case 102:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"http://" stringByAppendingString:OFFICAL_WS_VALUE]]];
            break;
        case 103:
        {
            TermViewController *tvCtrl = [[TermViewController alloc]init];
            [tvCtrl setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:tvCtrl animated:YES];
        }
            break;
    }
}

@end
