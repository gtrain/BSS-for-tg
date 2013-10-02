//
//  AliPayViewController.h
//  BSS
//
//  Created by zhangbo on 13-9-25.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActionSheet;
@interface AliPayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_btnPay;
    CGFloat _width;
    CGFloat _height;
    UIButton *_btnProvince;
    UILabel *_lblService;
    UILabel *_lblProvince;
    UILabel *_lblAlert;
    NSArray *_arrProvince;
    NSString *_strAreaNo;
    UITableView *_tbProvince;
    ActionSheet *_sheet;
    NSInteger _purpose;
    NSString *_strLocation;
}

//0:续费 1:首次购买(地区默认为广东)
-(id)initWithPurpose:(NSInteger)iPurpose andLocation:(NSString *)strLocation andAreaNo:(NSString *)strAreaNo;

@end
