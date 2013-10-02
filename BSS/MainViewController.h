//
//  MainViewController.h
//  BSS
//
//  Created by YANGZQ on 13-9-16.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic) NSString *tabImageName;
@property (nonatomic) NSString *tabTitle;

@property (nonatomic,strong) UITableView *itemTable;

@end
