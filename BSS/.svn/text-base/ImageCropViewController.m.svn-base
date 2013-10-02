//
//  ImageCropViewController.m
//  BSS
//
//  Created by liuc on 13-9-28.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "ImageCropViewController.h"
#import "KICropImageView.h"

@interface ImageCropViewController ()

@property (nonatomic,strong) UIImage *image;

@property (nonatomic,strong) KICropImageView *cropperView;

@property (assign) CGFloat width;
@property (assign) CGFloat height;

@end

@implementation ImageCropViewController

-(id)initWithImage:(UIImage *)image{
    self = [super init];
    if(self) {
        _image = image;
    }
    return self;
}



-(void)loadView{
    [super loadView];
    
    [self prepareFrame];
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    //CropperView
    _cropperView = [[KICropImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _height - self.navigationController.navigationBar.bounds.size.height)];
    [_cropperView setCropSize:CGSizeMake(200, 200)];
    [_cropperView setImage:_image];
    [_cropperView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:_cropperView];
}

-(void)prepareFrame{
    _width = self.view.bounds.size.width;
    _height = self.view.bounds.size.height;
    
    self.navigationController.navigationBarHidden = NO;
    
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
    
    //Confirm button
    UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnConfirm setBackgroundColor:[UIColor clearColor]];
    [btnConfirm setFrame:CGRectMake(10,10, 46, 27)];
    [btnConfirm setBackgroundImage:[UIImage imageNamed:@"button_orange_square"] forState:UIControlStateNormal];
    [btnConfirm setBackgroundImage:[UIImage imageNamed:@"button_orange_square_pressed"] forState:UIControlStateHighlighted];
    [btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
    [btnConfirm.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btnConfirm setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnConfirm addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnConfirm setTag:101];
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btnConfirm];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;

    
}

-(void)onClick:(UIButton *)btn{
    switch(btn.tag){
        case 100:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 101:
            [self sendImage];
            break;
    }
}

-(void)sendImage{
    if(_delegate) {
        [_delegate onFinishCropping:[_cropperView cropImage]];
    }
    [self finishCropping];
}
-(void)finishCropping{
    [self.navigationController popViewControllerAnimated:YES];
}

-(id)hidesTabBarWhenPushed{
    [self setHidesBottomBarWhenPushed:YES];
    return self;
}

@end
