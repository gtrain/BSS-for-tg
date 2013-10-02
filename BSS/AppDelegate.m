//
//  AppDelegate.m
//  BSS
//
//  Created by YANGZQ on 13-9-11.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetEngine.h"
#import "MainViewController.h"
#import "MyProjectViewController.h"
#import "SettingViewController.h"
#import "MyNavigationBar.h"
#import "AlixPay.h"
#import "AlixPayResult.h"
#import "AliPayViewController.h"

#define	_SYS_NAMELEN	256
//
//struct	utsname {
//	char	sysname[_SYS_NAMELEN];	/* [XSI] Name of OS */
//	char	nodename[_SYS_NAMELEN];	/* [XSI] Name of this network node */
//	char	release[_SYS_NAMELEN];	/* [XSI] Release level */
//	char	version[_SYS_NAMELEN];	/* [XSI] Version level */
//	char	machine[_SYS_NAMELEN];	/* [XSI] Hardware type */
//};
//
//__BEGIN_DECLS
//int uname(struct utsname *);
//__END_DECLS

@implementation AppDelegate
//
//- (BOOL)isSingleTask{
//	struct utsname name;
//	uname(&name);
//	float version = [[UIDevice currentDevice].systemVersion floatValue];//判定系统版本。
//	if (version < 4.0 || strstr(name.machine, "iPod1,1") != 0 || strstr(name.machine, "iPod2,1") != 0) {
//		return YES;
//	}
//	else {
//		return NO;
//	}
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.authEngine=[[AFNetEngine alloc] initWithBaseURL:[NSURL URLWithString:kAuthURL]];
    _authEngine.allowsInvalidSSLCertificate=YES;
    [self setupTabbar];
    
    if (IsAPIdebug) {
        self.viewController=[[TestClass alloc] init];
        self.window.rootViewController=_viewController;
        [self.window makeKeyAndVisible];
        return YES;        
        
        self.window.rootViewController = _tabBarController;
        [self.window makeKeyAndVisible];
        return YES;
    }
    
    self.loginVC=[[LoginViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[MyNavigationBar class] toolbarClass:nil];
    [navigationController setViewControllers:[NSArray arrayWithObject:_loginVC]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
//    /*
//	 *单任务handleURL处理
//	 */
//	if ([self isSingleTask]) {
//		NSURL *url = [launchOptions objectForKey:@"UIApplicationLaunchOptionsURLKey"];
//		
//		if (nil != url) {
//			[self parseURL:url application:application];
//		}
//	}
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [self parseURL:url application:application];
	return YES;
}

- (void)parseURL:(NSURL *)url application:(UIApplication *)application {
	AlixPay *alixpay = [AlixPay shared];
	AlixPayResult *result = [alixpay handleOpenURL:url];
	if (result) {
		//是否支付成功
		if (9000 == result.statusCode) {
			
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:@"支付成功"
                                                                delegate:self
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:nil];
            [alertView show];
		}
		//如果支付失败,可以通过result.statusCode查询错误码
		else {
			UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
																 message:result.statusMessage
																delegate:nil
													   cancelButtonTitle:@"确定"
													   otherButtonTitles:nil];
			[alertView show];
		}
        
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UINavigationController *navigation = [self.tabBarController.viewControllers lastObject];
    [navigation popViewControllerAnimated:YES];
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView
{

}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) setupTabbar{
    MainViewController *mainVC=[[MainViewController alloc] init];
    mainVC.tabImageName=@"AKTabBarController.bundle/toolbar_icon_home";
    mainVC.tabTitle=@"业务通";
    UINavigationController *newNav=[[UINavigationController alloc] initWithRootViewController:mainVC];
    [newNav.navigationBar setTintColor:kMainColor];
    
    MyProjectViewController *myProVC=[[MyProjectViewController alloc] init];
    myProVC.tabImageName=@"AKTabBarController.bundle/toorbar_icon_building";
    myProVC.tabTitle=@"我的项目";
    UINavigationController *myProNav=[[UINavigationController alloc] initWithRootViewController:myProVC];
    [myProNav.navigationBar setTintColor:kMainColor];
    
    SettingViewController *setVC=[[SettingViewController alloc] init];
    setVC.tabImageName=@"AKTabBarController.bundle/toolbar_icon_setting";
    setVC.tabTitle=@"设置";
    UINavigationController *setNav=[[UINavigationController alloc] initWithRootViewController:setVC];
    [setNav.navigationBar setTintColor:kMainColor];
    
    self.tabBarController=[[AKTabBarController alloc] init];
    [_tabBarController setViewControllers:[NSMutableArray arrayWithObjects:newNav,myProNav,setNav, nil]];
    
    
    [_tabBarController setSelectedIconColors:@[[UIColor colorWithRed:255/255.0 green:125/255.0 blue:2/255.0 alpha:1],
     [UIColor colorWithRed:255/255.0 green:210/255.0 blue:71/255.0 alpha:1]]]; // MAX 2 Colors
    
    // Text Color
    //[_tabBarController setTextColor:[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0]];
    [_tabBarController setSelectedTextColor:[UIColor colorWithRed:255/255.0 green:125/255.0 blue:2/255.0 alpha:1.0]];
    
    // Hide / Show glossy on tab icons
    [_tabBarController setIconGlossyIsHidden:YES];
}

@end










