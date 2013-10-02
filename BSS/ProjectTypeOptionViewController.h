//
//  ProjectTypeOptionViewController.h
//  BSS
//
//  Created by liuc on 13-9-25.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectTypeOptionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

#pragma 隐藏默认的TabBar
-(id)hideTabBarWhenPushed;

@end
