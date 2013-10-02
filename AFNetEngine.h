//
//  AFNetEngine.h
//  BSS
//
//  Created by YANGZQ on 13-9-11.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "AFHTTPClient.h"
#import "JSONModel.h"
#import "UserModel.h"
#import "ProjectModel.h"
#import "ProjectDetailModel.h"
#import "RESTError.h"

typedef void (^VoidBlock)(void);
typedef void (^NSStringBlock)(NSString *aString);
typedef void (^ModelBlock)(JSONModel *aModelBaseObj);
typedef void (^DictionaryBlock)(NSDictionary *dictionary);
typedef void (^ArrayBlock)(NSArray *dicArray);
typedef void (^ModelArrayBlock)(NSArray *modelArray);
typedef void (^ModelArrayAndInfoBlock)(NSArray *modelArray,NSDictionary *info);
typedef void (^ErrorBlock)(RESTError* engineError);

@interface AFNetEngine : AFHTTPClient{
    NSString *_accessToken;
    NSString *_refreshToken;
    NSDate *_expiresDate;
    NSString *_accessUDID;
    NSString *_secret;
}
@property (nonatomic,strong) NSString *accessToken;
@property (nonatomic,strong) NSString *refreshToken;
@property (nonatomic,strong) NSDate   *expiresDate;

+(AFNetEngine *) shareEngine;



#pragma mark - 认证模块
/** 请求UDID，参数均为可选
 @param osversion   操作系统及其版本号.
 @param resolution  屏幕分辨率
 @param trademark   品牌信息
 @param installdate 安装时间
 @param parameter   扩展参数
 @return void
 */
-(void) requestUDIDWithOsversion:(NSString *)osversion
                      Resolution:(NSString *)resolution
                       Rrademark:(NSString *) trademark
                     Installdate:(NSString *) installdate
                       parameter:(NSDictionary *)parameter
                     onSucceeded:(VoidBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock;
//参数均为nil
-(void) requestUDIDOnSucceeded:(VoidBlock) succeededBlock
                       onError:(ErrorBlock) errorBlock;



/** 请求token，默认grant_type:password.
 @param UserName    用户名.
 @param passWord    密码.
 @param onSucceeded 成功时的回调.
 @param onError     错误时的回调.
 @return void
 */
-(void) requestTokenWithUserName:(NSString *)username
                        passWord:(NSString *)password
                     onSucceeded:(VoidBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock;



/** 卸载设备.
 @param uninstalldate 卸载时间.
 @return void
 */
-(void) uninstallBBS;

-(void) uninstallBBSWithDate:(NSString *)date
                 onSucceeded:(VoidBlock) succeededBlock
                     onError:(ErrorBlock) errorBlock;



/** 获取地区数据.
 @param  useCache YES-先检查是否有缓存数据可用，NO-直接从服务器获取
 @return void.
 */
-(void) opAreaUseCache:(BOOL)useCache
              onSucceeded:(ArrayBlock) succeededBlock
                  onError:(ErrorBlock) errorBlock;

-(void) cancelOpArea;



/** 刷新token，默认grant_type:refresh_token.
 @param refresh_token    刷新token.
 @return void
 */
-(void) refreshTokenOnSucceeded:(VoidBlock) succeededBlock
                        onError:(ErrorBlock) errorBlock;

-(void) refreshTokenByRefreshToken;





/** 获取工程信息分类.
 @param  useCache YES-先检查是否有缓存数据可用，NO-直接从服务器获取
 @return void.
 */
-(void) opProjectClassify:(BOOL)useCache
                 onSucceeded:(ArrayBlock) succeededBlock
                     onError:(ErrorBlock) errorBlock;

-(void) cancelOpProjectClassify;


#pragma mark -
#pragma mark 注册模块

/** 验证手机号码.
 @param  mobile：手机号码
 @return void.
 */
-(void) opValidMobile:(NSString *)mobileNo
             onSucceeded:(DictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock;

-(void) cancelOpValidMobile;



/** 发送验证码到手机.
 @param  mobile：手机号码
 @return void.
 */
-(void) opValidCode:(NSString *)mobileNo
             onSucceeded:(DictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock;

-(void) cancelOpValidCode;




/** 验证输入的验证码.
 @param  mobile ：手机号码
 @param  code   ：验证码
 @return void.
 */
-(void) opVerifyCode:(NSString *)code
                 Mobile:(NSString *)mobileNo
            onSucceeded:(DictionaryBlock) succeededBlock
                onError:(ErrorBlock) errorBlock;

-(void) cancelOpVerifyCode;



/** 用户资料注册.
 @param  mobile ：手机号码
 @param  name   ：姓名
 @param  company：公司名称
 @param  password：帐号密码
 @param  location：地区信息
 @return void.
 */
-(void) opVerifyUserInfoWithMobile:(NSString *)mobileNo
                             UserName:(NSString *)name
                              Company:(NSString *)company
                             Password:(NSString *)password
                          onSucceeded:(DictionaryBlock) succeededBlock
                              onError:(ErrorBlock) errorBlock;

-(void) opVerifyUserInfoWithMobile:(NSString *)mobileNo
                             UserName:(NSString *)name
                              Company:(NSString *)company
                             Password:(NSString *)password
                             Location:(NSString *)location
                          onSucceeded:(DictionaryBlock) succeededBlock
                              onError:(ErrorBlock) errorBlock;

-(void) cancelOpVerifyUserInfo;



/** 验证手机号码是否存在.(找回密码)
 @param  mobile：手机号码
 @return void.
 */
-(void) opValidMobileFG:(NSString *)mobileNo
                   onSucceeded:(DictionaryBlock) succeededBlock
                       onError:(ErrorBlock) errorBlock;

-(void) cancelOpValidMobileFG;



/** 发送验证码到手机.(找回密码)
 @param  mobile：手机号码
 @return void.
 */
-(void) opValidCodeFG:(NSString *)mobileNo
             onSucceeded:(DictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock;

-(void) cancelOpValidCodeFG;



/** 验证输入的验证码.(找回密码)
 @param  mobile ：手机号码
 @param  code   ：验证码
 @return void.
 */
-(void) opVerifyCodeFG:(NSString *)code
                   Mobile:(NSString *)mobileNo
              onSucceeded:(DictionaryBlock) succeededBlock
                  onError:(ErrorBlock) errorBlock;

-(void) cancelOpVerifyCodeFG;



/** 更新用户密码
 @param  password：密码
 @param  mobile  ：手机号码
 
 @return void.
 */
-(void) opChangePassword:(NSString *)passwd
                   Mobile:(NSString *)mobileNo
              onSucceeded:(DictionaryBlock) succeededBlock
                  onError:(ErrorBlock) errorBlock;

-(void) cancelOpChangePassword;

#pragma mark - 用户模块
/** 获取用户全部账户信息（用户档案、工程信息服务属性、工程信息订阅属性）
 @return user_info：用户档案对象
 @return user_service：工程信息服务属性对象
 @return user_subscription：工程信息订阅属性对象
 */
-(void) opGetAllInfoOnSucceeded:(ModelBlock) succeededBlock
                           onError:(ErrorBlock) errorBlock;
-(void) cancelOpGetAllInfo;



/** 获取用户基本信息
 @return user_info：用户档案对象
 */
-(void) opGetUserInfoOnSucceeded:(ModelBlock) succeededBlock
                        onError:(ErrorBlock) errorBlock;
-(void) cancelOpGetUserInfo;



/** 获取用户工程信息服务属性
 @return user_service：工程信息服务属性对象
 */
-(void) opGetServiceInfoOnSucceeded:(ModelBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock;

-(void) cancelOpGetServiceInfo;




/** 标记用户登录帐号
 @return state：验证结果
 */
-(void) markUserLoginOnSucceeded:(DictionaryBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock;

/** 标记用户退出帐号
 @return state：验证结果
 */
-(void) markUserLogoutOnSucceeded:(DictionaryBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock;

/** 标记应用程序启动
 @return state：验证结果
 */
-(void) markAppLaunchingOnSucceeded:(DictionaryBlock) succeededBlock
                          onError:(ErrorBlock) errorBlock;


/** 标记应用程序关闭
 @return state：验证结果
 */
-(void) markAppClosureOnSucceeded:(DictionaryBlock) succeededBlock
                          onError:(ErrorBlock) errorBlock;



#pragma mark 更新信息

/** 更新用户姓名
 @param  value：姓名
 @return void.
 */
-(void) opUpdateUsername:(NSString *)name
             onSucceeded:(DictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock;

/** 更新用户性别
 @param  value：性别
 @return void.
 */
-(void) opUpdateUserGender:(NSString *)gender
             onSucceeded:(DictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock;

/** 更新职位名称
 @param  value：职位
 @return void.
 */
-(void) opUpdateUserPost:(NSString *)post
               onSucceeded:(DictionaryBlock) succeededBlock
                   onError:(ErrorBlock) errorBlock;

/** 更新企业名称
 @param  value：公司
 @return void.
 */
-(void) opUpdateUserCompany:(NSString *)company
             onSucceeded:(DictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock;


/** 更新QQ
 @param  value：QQ
 @return void.
 */
-(void) opUpdateUserQQ:(NSString *)qq
                onSucceeded:(DictionaryBlock) succeededBlock
                    onError:(ErrorBlock) errorBlock;

/** 更新地址
 @param  value：地址
 @return void.
 */
-(void) opUpdateUserAddress:(NSString *)address
                onSucceeded:(DictionaryBlock) succeededBlock
                    onError:(ErrorBlock) errorBlock;



/** 更新用户头像
 @param  face：头像的文件流
 @param  mobile  ：手机号码
 
 @return void. face_path 头像缩略图路径
 */
-(void) opUpdateUserFace:(UIImage *)faceImg
             onSucceeded:(DictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock;

-(void) cancelUpdateUserFace;


#pragma mark - 项目模块
#pragma mark 设置

/** 设置工程信息订阅地区属性
 @param  Region :订阅地区
 @return void   :验证结果
 */
-(void) opSetSubRegion:(NSString *)regionNo
           onSucceeded:(DictionaryBlock) succeededBlock
               onError:(ErrorBlock) errorBlock;

-(void) opCancelSetSubRegion;

/** 设置工程信息订阅类型属性
 @param  type :订阅类型
 @return void：验证结果
 */
-(void) opSetSubType:(NSString *)type
           onSucceeded:(DictionaryBlock) succeededBlock
               onError:(ErrorBlock) errorBlock;

-(void) opCancelSetSubType;

/** 同时设置工程信息订阅地区跟类型属性
 @param  Region :订阅地区
 @param  type   :订阅类型
 
 @return void   :验证结果
 */
-(void) opSetSubType:(NSString *)type
              region:(NSString *)regionNo
         onSucceeded:(DictionaryBlock) succeededBlock
             onError:(ErrorBlock) errorBlock;

-(void) opCancelSetSubTypeNregion;

#pragma mark 获取
/** 获取用户工程信息订阅属性
 @return void：地区属性跟类型属性
 */
-(void) opGetSubInfoOnSucceeded:(DictionaryBlock) succeededBlock
                        onError:(ErrorBlock) errorBlock;

-(void) opCancelGetSubInfo;


/** 获取订阅的最新工程信息列表（分页）
 @param  page   :指定返回结果的页码  (可选)
 @param  count  :指定要返回的记录条数(可选)

 @return void：项目模型对象数组跟页数信息
 */
-(void) opGetSubProjectListWithPage:(NSString *)page
                              count:(NSString *)count
                        onSucceeded:(ModelArrayAndInfoBlock) succeededBlock
                            onError:(ErrorBlock) errorBlock;

-(void) opCancelGetSubProjectList;


/** 获取工程信息搜索列表（分页）
 @param  page   :指定返回结果的页码  (可选)
 @param  count  :指定要返回的记录条数(可选)
 
 @param  region ：搜索的工程信息地区编号
 @param  type   ：搜索的工程信息类别编号
 @param  keyword：搜索的工程信息关键字"
 （不可全缺）
 
 @return void：项目模型对象
 */
-(void) opSearchProjectWithPage:(NSString *)page
                          count:(NSString *)count
                         region:(NSString *)regionNo
                        keyword:(NSString *)keyword
                           type:(NSString *)type
                    OnSucceeded:(ModelArrayAndInfoBlock) succeededBlock
                        onError:(ErrorBlock) errorBlock;

-(void) opCancelSearchProject;



/** 查看工程的详细信息
 @param  id     ：项目编号
 @return void   ：项目详细信息的模型对象
 */
-(void) opQueryProjectDetailWithId:(NSString *)projectId
                       onSucceeded:(ModelBlock) succeededBlock
                           onError:(ErrorBlock) errorBlock;

-(void) opCancelQueryProjectDetail;



/** 查看工程的详细信息（￥付费）
 @param  id     ：项目编号
 @return void   ：项目详细信息的模型对象
 */
-(void) opPayProjectDetailWithId:(NSString *)projectId
                     onSucceeded:(ModelBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock;



/** 标记项目已查看
 @param  id     ：项目编号
 @return void   ：验证结果
 */
-(void) opSignViewTimeWithId:(NSString *)projectId
           onSucceeded:(DictionaryBlock) succeededBlock
               onError:(ErrorBlock) errorBlock;



/**  收藏工程信息
 @param  id     ：项目编号
 @return void   ：验证结果
 */
-(void) opFavAddWithId:(NSString *)projectId
                 onSucceeded:(DictionaryBlock) succeededBlock
                     onError:(ErrorBlock) errorBlock;



/** 取消收藏工程信息
 @param  id     ：项目编号
 @return void   ：验证结果
 */
-(void) opFavRemoveWithId:(NSString *)projectId
                 onSucceeded:(DictionaryBlock) succeededBlock
                     onError:(ErrorBlock) errorBlock;



/** 获取收藏的项目列表
 @param  page   :指定返回结果的页码  (可选)
 @param  count  :指定要返回的记录条数(可选)
 
 @return void   ：验证结果
 */
-(void) opGetFavProjListWithPage:(NSString *)page
                           count:(NSString *)count
                     onSucceeded:(ModelArrayAndInfoBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock;

-(void) opCancelGetFavProjList;



/** 获取已查看的项目列表（付费）
 @param  page   :指定返回结果的页码  (可选)
 @param  count  :指定要返回的记录条数(可选)
 
 @return void   ：验证结果
 */
-(void) opGetCostProjListWithPage:(NSString *)page
                           count:(NSString *)count
                     onSucceeded:(ModelArrayAndInfoBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock;

-(void) opCancelGetCostProjList;



/** 获取我的项目列表（收藏）
 @param  page   :指定返回结果的页码  (可选)
 @param  count  :指定要返回的记录条数(可选)
 
 @return void   ：验证结果
 */
-(void) opGetFavUpdateListWithPage:(NSString *)page
                            count:(NSString *)count
                      onSucceeded:(ModelArrayAndInfoBlock) succeededBlock
                          onError:(ErrorBlock) errorBlock;

-(void) opCancelGetFavUpdateList;


#pragma mark -  其他
#pragma mark 反馈
/**  意见反馈
 @param  content：反馈的内容
 @return void   ：验证结果
 */
-(void) opFeedbackMessage:(NSString *)message
           onSucceeded:(DictionaryBlock) succeededBlock
               onError:(ErrorBlock) errorBlock;


#pragma mark - 支付
/**  用户支付
 @param  area_no：会员购买的服务地区，至少到省级以下，也就是必须包含两项。如1.24
 @return void   ：验证结果
 */
-(void) opPaymentWithArea:(NSString *)area_no
              onSucceeded:(NSStringBlock) succeededBlock
                  onError:(ErrorBlock) errorBlock;


@end


















