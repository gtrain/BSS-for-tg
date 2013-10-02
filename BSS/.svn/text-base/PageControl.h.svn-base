//
//  PageControl.h
//  BSS
//
//  Created by liuc on 13-9-28.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PageControl;

@protocol PageControlDelegate <NSObject>

@optional
-(void)pageControlClicked:(PageControl *)control atIndex:(NSInteger)index;

@end

@interface PageControl : UIControl

@property(nonatomic, strong) UIControl *selectedHintColor;
@property(nonatomic, strong) UIControl *unselectedHintColor;
@property(nonatomic, assign) NSInteger currentPage;
@property(assign) NSInteger numberOfPage;
@property(nonatomic,assign)id<PageControlDelegate> delegate;

@end
