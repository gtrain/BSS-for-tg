//
//  API.h
//  TGYWT
//
//  Created by YANGZQ on 13-9-6.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//


#ifndef TGYWT_API_h
#define TGYWT_API_h

#pragma mark -
#pragma mark 证书

#define kClientID       @"4325982D49471B4756A0074289CC8214"
#define kClientSecret   @"01DE63CFAB788F4C84D8764CD6EF0AD267EE2DE2"

//Name:天工业务通iOS_Development
//Client ID:910CE678FA510AC89B42439209D03A08
//Client Secret:4F70F148AB8109C6F419AD0D5547100434BB122E

#pragma mark -
#pragma mark 接口参数

#define kParamUDID          @"UDID"             //设备唯一标识符
#define kParamSecret        @"secret"           //设备密钥

#define kParamToken         @"access_token"     //令牌
#define kParamReToken       @"refresh_token"    //重新获取令牌
#define kParamExpiresIN     @"expires_in"       //过期时间

#define kParamMobile        @"mobile"           //手机号码
#define kParamCode          @"code"             //验证码

#define kParamUserName      @"username"         //登陆时的用户名
#define kParamPassWord      @"password"         //登陆时的密码

#define kParamName          @"name"             //用户名-注册
#define kParamCompany       @"company"          //公司  -注册
#define kParamLocation      @"location"         //地区  -注册
#define kParamFace          @"face"             //用户头像

#define kParamValue         @"value"            //用户更新的信息值

#define kParamRegion        @"region"           //信息订阅的地区属性
#define kParamType          @"type"             //类型属性

#define kParamPage          @"page"             //类型属性
#define kParamCount         @"count"            //类型属性
#define kParamKeyword       @"keyword"          //搜索关键字
#define kParamProId         @"id"               //项目id
#define kParamContent       @"content"          //反馈信息

#define kParamArea          @"area_no"          //支付时的地区信息


#define kOsversion   @"osversion"
#define kResolution  @"resolution"
#define kTrademark   @"trademark"
#define kInstalldate @"installdate"
#define kParameter   @"parameter"

#define kUninstalldate   @"uninstalldate"




#pragma mark -
#pragma mark 接口链接

//验证，应用模块
#define kPathToken      @"oauth/2.0/token/"
#define kPathUDID       @"device/register/"
#define kPathUninstall  @"device/uninstall/"

#define kPathArea       @"basedata/area/get/"
#define kPathProjclass  @"basedata/projclass/get/"

//注册模块
#define kPathValidMobile        @"register/valid_mobile/"
#define kPathGetValidCode       @"register/get_valid_code/"
#define kPathValidCode          @"register/valid_code/"
#define kPathPostUserInfo       @"register/post_user_info/"
#define kPathFGValidMobile      @"register/forget/valid_mobile/"
#define kPathFGGetValidCode     @"register/forget/get_valid_code/"
#define kPathFGValidCode        @"register/forget/valid_code/"
#define kPathUpdatePassword     @"register/forget/update_passowrd/"

//帐号模块
#define kPathGetAllInfo         @"account/get_all_info/"
#define kPathGetUserInfo        @"account/get_user_info/"
#define kPathGetServiceInfo     @"account/get_service_info/"

#define kPathMarkLogin          @"account/login/"
#define kPathMarkLogout         @"account/logout/"
#define kPathMarkAppStart       @"account/app_start/"
#define kPathMarkAppClose       @"account/app_close/"

#define kPathUpdateName         @"account/user_info/set/name/"
#define kPathUpdateGender       @"account/user_info/set/gender/"
#define kPathUpdatePost         @"account/user_info/set/post/"
#define kPathUpdateCompany      @"account/user_info/set/company/"
#define kPathUpdateQQ           @"account/user_info/set/qq/"
#define kPathUpdateAddress      @"account/user_info/set/business_address/"
#define kPathUpdateFace         @"account/user_info/set/face/"

//工程信息订阅
#define kPathGetSubInfo         @"project/subscription/get/"
#define kPathSetSubRegion       @"project/subscription/set_region/"
#define kPathSetSubType         @"project/subscription/set_type/"
#define kPathSetSubAll          @"project/subscription/set_all/"
#define kPathGetSubList         @"project/subscription/get_list/"
//搜索 查看工程信息
#define kPathSearchList         @"project/search/get_list/"
#define kPathProjectList        @"project/view/view/"
#define kPathUpdateViewTime     @"project/view/update_view_time/"
#define kPathCostForView        @"project/view/cost/"
//工程信息收藏
#define kPathGetCostedProjectList @"project/view/get_cost_project_list/"
#define kPathFavAdd             @"project/fav/add/"
#define kPathFavRemove          @"project/fav/remove/"
#define kPathFavGetList         @"project/fav/get_list/"
#define kPathFavUpdateList      @"project/fav/get_update_list/"

#define kPathFeedback           @"feedback/leave_message/"

#define kPathZhiFuOrder         @"service/payment/ali/post_order_info/"



#endif













