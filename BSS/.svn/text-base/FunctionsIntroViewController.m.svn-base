//
//  FunctionsIntroViewController.m
//  BSS
//
//  Created by liuc on 13-9-27.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "FunctionsIntroViewController.h"

#define PAGE1_IMAGE_BACK @"intro_view_bg001"
#define PAGE2_IMAGE_BACK @"intro_view_bg002"
#define PAGE3_IMAGE_BACK @"intro_view_bg003"
#define IMG_BTN_NORMAL @"button_green"
#define IMG_BTN_HIGHTLIGHTED @"button_green_pressed"

#define TEXT_START_APP_TURTROIL @"开始体验 >"

@interface FunctionsIntroViewController ()

@property (nonatomic, strong) UIScrollView *sclvIntro;
@property (nonatomic, strong) UIPageControl *pageCtrlIntro;
@property (nonatomic, strong) UIImageView *page1;
@property (nonatomic, strong) UIImageView *page2;
@property (nonatomic, strong) UIImageView *page3;

@property (nonatomic, strong) UIButton *btnStart;

@property CGFloat width;
@property CGFloat height;

@property BOOL hidesNaveicationBar;

@end

@implementation FunctionsIntroViewController

-(void)loadView{
    [super loadView];
    
    [self prepareFrame];
    
    [self initViews];
}

-(void)prepareFrame{
    _width = self.view.bounds.size.width;
    _height = self.view.bounds.size.height;
    
    _pageCtrlIntro = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _height - 44, _width, 44)];
    [_pageCtrlIntro setNumberOfPages:3];
    [_pageCtrlIntro setBackgroundColor:[UIColor clearColor]];
    
    
    _sclvIntro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
    [_sclvIntro setBackgroundColor:[UIColor whiteColor]];
    [_sclvIntro setContentSize:CGSizeMake(_sclvIntro.bounds.size.width*3, _sclvIntro.bounds.size.height)];
    [_sclvIntro setPagingEnabled:YES];
    [_sclvIntro setShowsHorizontalScrollIndicator:NO];
    [_sclvIntro setShowsVerticalScrollIndicator:NO];
    [_sclvIntro setDelegate:self];
    
    [self.view addSubview:_sclvIntro];
    [self.view addSubview:_pageCtrlIntro];
    
    
}

-(void)initViews{
    CGFloat wSclv = _sclvIntro.bounds.size.width;
    CGFloat hSclv = _sclvIntro.bounds.size.height;
    
    _page1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, wSclv, hSclv)];
    _page2 = [[UIImageView alloc]initWithFrame:CGRectMake(wSclv, 0, wSclv, hSclv)];
    _page3 = [[UIImageView alloc]initWithFrame:CGRectMake(wSclv*2, 0, wSclv, hSclv)];
    
    [_page1 setImage:[UIImage imageNamed:PAGE1_IMAGE_BACK]];
    [_page2 setImage:[UIImage imageNamed:PAGE2_IMAGE_BACK]];
    [_page3 setImage:[UIImage imageNamed:PAGE3_IMAGE_BACK]];
    
    _btnStart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btnStart setTitle:TEXT_START_APP_TURTROIL forState:UIControlStateNormal];
    [_btnStart setFrame:CGRectMake(20 + wSclv*2, (_page3.bounds.size.height/4)*3, _page3.bounds.size.width - 40, 44)];
    [_btnStart addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btnStart setBackgroundImage:[UIImage imageNamed:IMG_BTN_NORMAL] forState:UIControlStateNormal];
    [_btnStart setBackgroundImage:[UIImage imageNamed:IMG_BTN_HIGHTLIGHTED] forState:UIControlStateHighlighted];
    [_btnStart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_sclvIntro addSubview:_page1];
    [_sclvIntro addSubview:_page2];
    [_sclvIntro addSubview:_page3];
    [_sclvIntro addSubview:_btnStart];
    
}

-(void)onClick:(UIButton *)btn{
//    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    int currentPage = (int)(offset.x/_page1.bounds.size.width);
    
    [_pageCtrlIntro setCurrentPage:currentPage];
}

//
-(id)hidesTopBar:(BOOL)tyn bottomBar:(BOOL)byn{
    [self setHidesBottomBarWhenPushed:byn];
    [self setHidesNaveicationBar:YES];
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = _hidesNaveicationBar;
}
@end
