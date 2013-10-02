//
//  ViewController.m
//  BSS
//
//  Created by YANGZQ on 13-9-11.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "DemoVC.h"
#import "AppDelegate.h"

@implementation DemoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

//获取UDID
- (IBAction)requestUDID:(id)sender {
    [AppDelegateShare.authEngine requestUDIDWithOsversion:nil Resolution:nil Rrademark:nil Installdate:nil parameter:nil onSucceeded:^{
        DLog(@"获取成功");
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}
//获取token
- (IBAction)requestToken:(id)sender {
    [AppDelegateShare.authEngine requestTokenWithUserName:@"13763333185"
                                                 passWord:@"1234321"
                                              onSucceeded:^{
                                                     DLog(@"获取token成功");
                                                 } onError:^(RESTError *engineError) {
                                                     ELog(engineError);
    }];
}
//获取刷新token
- (IBAction)refreshToken:(id)sender {
    [AppDelegateShare.authEngine refreshTokenOnSucceeded:^{
        DLog(@"刷新cookies成功");
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}
//卸载
- (IBAction)uninstall:(id)sender {
    [AppDelegateShare.authEngine uninstallBBSWithDate:nil onSucceeded:^{
        DLog(@"卸载成功");
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}
//获取地区资料
- (IBAction)location:(id)sender {
    [[AFNetEngine shareEngine] opAreaUseCache:NO
                                      onSucceeded:^(NSArray *areaDicArray){
                                          DLog(@"获取到%d个地区资料",areaDicArray.count);
                                      } onError:^(RESTError *engineError) {
                                          ELog(engineError);
    }];
}
//查看缓存的地区资料
- (IBAction)locationAreaData:(id)sender {
    NSString* tempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"areas.json"];
    
    NSData *data=[NSData dataWithContentsOfFile:tempFile];
    id jsonobject=nil;
    if (data) {
        jsonobject=[NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingAllowFragments
                                                        error:nil];
    }
    DLog(@"%@",jsonobject);
}
//取消地区资料的请求
- (IBAction)cancelArea:(id)sender {
    [[AFNetEngine shareEngine] cancelOpArea];
}

//获取分类信息
- (IBAction)classify:(id)sender {
    [[AFNetEngine shareEngine] opProjectClassify:YES onSucceeded:^(NSArray *dicArray) {
        DLog(@"获取到%d个分类信息",dicArray.count);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}
//取消分类信息的请求
- (IBAction)cancelClassify:(id)sender {
    [[AFNetEngine shareEngine] cancelOpProjectClassify];
}
//查看本地的分类信息数据
- (IBAction)classifyCacheData:(id)sender {
    NSString* tempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"ProjectClassify.json"];
    
    NSData *data=[NSData dataWithContentsOfFile:tempFile];
    id jsonobject=nil;
    if (data) {
        jsonobject=[NSJSONSerialization JSONObjectWithData:data
                                                   options:NSJSONReadingAllowFragments
                                                     error:nil];
    }
    DLog(@"%@",jsonobject);
}
//验证手机
- (IBAction)valid:(id)sender {
    [[AFNetEngine shareEngine] opValidMobile:@"15976784391"
                                    onSucceeded:^(NSDictionary *dic) {
                                        DLog(@"验证手机的返回数据： %@",dic);
                                    } onError:^(RESTError *engineError) {
                                        ELog(engineError);
    }];
}
//取消验证手机
- (IBAction)cancelValidMobile:(id)sender {
    [[AFNetEngine shareEngine] cancelOpValidMobile];
}

//请求手机验证码
- (IBAction)questValidCode:(id)sender {
    [[AFNetEngine shareEngine] opValidCode:@"15976784300"
                                    onSucceeded:^(NSDictionary *dic) {
                                        DLog(@"发送验证码的返回数据： %@",dic);
                                    } onError:^(RESTError *engineError) {
                                        ELog(engineError);
                                    }];
}
//取消请求验证码
- (IBAction)cancelQuestValidCode:(id)sender {
    [[AFNetEngine shareEngine] cancelOpValidCode];
}
//验证手机验证码
- (IBAction)verify:(id)sender {
    [[AFNetEngine shareEngine] opVerifyCode:@"656510" Mobile:@"15976784300"
                                   onSucceeded:^(NSDictionary *dic) {
                                       DLog(@"发送验证码的返回数据： %@",dic);
                                   } onError:^(RESTError *engineError) {
                                       ELog(engineError);
    }];
}
//取消验证手机验证码
- (IBAction)cancelVerify:(id)sender {
    [[AFNetEngine shareEngine] cancelOpVerifyCode];
}

//用户注册
- (IBAction)regUserInfo:(id)sender {
    [[AFNetEngine shareEngine] opVerifyUserInfoWithMobile:@"13800138000" UserName:@"" Company:@"" Password:@"" Location:@"" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"用户注册结果： %@",dictionary);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}
//取消用户注册响应
- (IBAction)cancelUserReg:(id)sender {
    [[AFNetEngine shareEngine] cancelOpVerifyUserInfo];
}

//验证手机（找回密码）
- (IBAction)forgotVfMobile:(id)sender {
    [[AFNetEngine shareEngine] opValidMobileFG:@"13763333185" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"用户手机验证结果： %@",dictionary);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)cancelVfMobile:(id)sender {
    [[AFNetEngine shareEngine] cancelOpValidMobileFG];
}

//获取验证码（找回密码）
- (IBAction)getCodeFG:(id)sender {
    [[AFNetEngine shareEngine] opValidCodeFG:@"13763333185" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"获取验证码结果： %@",dictionary);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)cancelGetCodeFG:(id)sender {
    [[AFNetEngine shareEngine] cancelOpValidCodeFG];
}

- (IBAction)verifyCodeFG:(id)sender {
    [[AFNetEngine shareEngine] opVerifyCodeFG:@"332020" Mobile:@"13763333185" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"获取验证码结果： %@",dictionary);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)cancelVerifyCodeFG:(id)sender {
    [[AFNetEngine shareEngine] cancelOpValidMobileFG];
}

- (IBAction)updateInfo:(id)sender {
    [[AFNetEngine shareEngine] opChangePassword:@"1234321" Mobile:@"13763333185" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"获取验证码结果： %@",dictionary);
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)cancelUpdate:(id)sender {
    [[AFNetEngine shareEngine] cancelOpChangePassword];
}


- (IBAction)getAllInfo:(id)sender {
    [[AFNetEngine shareEngine] opGetAllInfoOnSucceeded:^(JSONModel *jsonObject) {
        if ([jsonObject isKindOfClass:[UserModel class]]) {
            UserModel *user=(UserModel *)jsonObject;
            DLog(@"全部资料 %@,%@,%@",user.name,user.rssRegion,user.rssType);
        }
        
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)cancelAllInfo:(id)sender {
    [[AFNetEngine shareEngine] cancelOpGetAllInfo];
}


- (IBAction)baseInfo:(id)sender {
    [[AFNetEngine shareEngine] opGetUserInfoOnSucceeded:^(JSONModel *jsonObject) {
        if ([jsonObject isKindOfClass:[UserModel class]]) {
            UserModel *user=(UserModel *)jsonObject;
            DLog(@"用户信息 %@",user.name);
        }
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)cancelBaseInfo:(id)sender {
    [[AFNetEngine shareEngine] cancelOpGetUserInfo];
}

- (IBAction)serverInfo:(id)sender {
    [[AFNetEngine shareEngine] opGetServiceInfoOnSucceeded:^(JSONModel *jsonObject) {
        if ([jsonObject isKindOfClass:[UserModel class]]) {
            UserModel *user=(UserModel *)jsonObject;
            DLog(@"用户服务信息 %@, %@",user.permission,user.region);
        }
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)cancelServerInfo:(id)sender {
    [[AFNetEngine shareEngine] cancelOpGetServiceInfo];
}



- (IBAction)markLogin:(id)sender {
    [[AFNetEngine shareEngine] markUserLoginOnSucceeded:^(NSDictionary *dictionary) {
        DLog(@"标记登陆状态 成功");
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)markLogout:(id)sender {
    [[AFNetEngine shareEngine] markUserLogoutOnSucceeded:^(NSDictionary *dictionary) {
        DLog(@"标记退出状态 成功");
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)markStart:(id)sender {
    [[AFNetEngine shareEngine] markAppLaunchingOnSucceeded:^(NSDictionary *dictionary) {
        DLog(@"标记程序启动 成功");
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)markClose:(id)sender {
    [[AFNetEngine shareEngine] markAppClosureOnSucceeded:^(NSDictionary *dictionary) {
        DLog(@"标记程序关闭成功");
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
    
}

//更新资料

- (IBAction)cName:(id)sender {
    [[AFNetEngine shareEngine] opUpdateUsername:@"test" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"更新姓名成功");
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)cGender:(id)sender {
    [[AFNetEngine shareEngine] opUpdateUserGender:@"1" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"更新性别成功");
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
     
}

- (IBAction)cQQ:(id)sender {
    [[AFNetEngine shareEngine] opUpdateUserQQ:@"123456789" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"更新QQ成功");
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)cAddr:(id)sender {
    [[AFNetEngine shareEngine] opUpdateUserAddress:@"五羊" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"更新地址成功");
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)cCompany:(id)sender {
    [[AFNetEngine shareEngine] opUpdateUserCompany:@"天工" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"更新公司成功");
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];
}

- (IBAction)cPost:(id)sender {
    [[AFNetEngine shareEngine] opUpdateUserPost:@"没有职位" onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"更新职位成功");
    } onError:^(RESTError *engineError) {
        ELog(engineError);
    }];

}

- (IBAction)dismissView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


@end












