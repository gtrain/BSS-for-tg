//
//  UserTextInfoModifyViewController.h
//  BSS
//
//  Created by liuc on 13-9-23.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NOTIFICATIONNAME_MODIFY @"notificationmodify"
#define TEXT_KEY @"key"
#define KEY_NAME @"name"
#define KEY_POST @"post"
#define KEY_COMPANY @"company"
#define KEY_QQ @"qq"
#define KEY_ADDRESS @"address"
#define KEY_NAME_NUM 0
#define KEY_POST_NUM 1
#define KEY_COMPANY_NUM 2
#define KEY_QQ_NUM 3
#define KEY_ADDRESS_NUM 4

typedef NS_ENUM(NSInteger, ModifyType) {
    TypeName = 0,
    TypePost,
    TypeCompany,
    TypeQQNum,
    TypeBussinessAddress
    
};

@interface UserTextInfoModifyViewController : UIViewController

#pragma 根据类型以及相应类型的默认值初始化
-(id)initWithUserModel:(UserModel *)model forType:(ModifyType)type;

#pragma 隐藏默认的TabBar
-(id)hideTabBarWhenPushed;
@end
