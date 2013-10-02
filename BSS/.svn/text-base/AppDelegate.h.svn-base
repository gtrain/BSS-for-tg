//
//  AppDelegate.h
//  BSS
//
//  Created by YANGZQ on 13-9-11.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//


#define TestClass ProjectSDKDemo
#define IsAPIdebug 0

#define TestClassHeader "ProjectSDKDemo.h"
#import TestClassHeader

#import <UIKit/UIKit.h>
#import "AKTabBarController.h"
#import "LoginViewController.h"
#import "Location.h"

@class AFNetEngine;
@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AFNetEngine *authEngine;   //授权接口
@property (nonatomic,strong) AKTabBarController *tabBarController;
@property (nonatomic,strong) MainViewController *mainVC;
@property (nonatomic,strong) LoginViewController *loginVC;

@property (strong, nonatomic) TestClass *viewController;

@property(nonatomic,strong) NSString *strCity;

@property(nonatomic,strong)Location *currentLocation;

@end


