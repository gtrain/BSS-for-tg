//
//  ImageCropViewController.h
//  BSS
//
//  Created by liuc on 13-9-27.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageCropViewControllerDelegate <NSObject>

@optional

-(void)onFinishCropping:(UIImage *)image;

@end

@interface ImageCropViewController : UIViewController

@property (atomic,assign) id<ImageCropViewControllerDelegate> delegate;

-(id)initWithImage:(UIImage*)image ;

-(id)hidesTabBarWhenPushed;

@end
