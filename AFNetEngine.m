//
//  AFNetEngine.m
//  BSS
//
//  Created by YANGZQ on 13-9-11.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "AFNetEngine.h"
#import "AFJSONRequestOperation.h"
#import "API.h"
#import "AppDelegate.h"

@interface AFHTTPClient()
@property (nonatomic,strong) NSString *accessUDID;
@property (nonatomic,strong) NSString *secret;

@end

@implementation AFNetEngine
static NSInteger EXPIRES_IN = -3500;

+(AFNetEngine *) shareEngine{
    static AFNetEngine *_engine=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _engine=[[AFNetEngine alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
        [_engine setAllowsInvalidSSLCertificate:YES];
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    });
    return _engine;
}
-(id) initWithBaseURL:(NSURL *)url{
    self=[super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
	[self setDefaultHeader:@"Accept" value:@"application/json"];     
    self.defaultSSLPinningMode = AFSSLPinningModeNone;

    return self;
}

#pragma mark -
#pragma mark custom function
//是否加入头信息
-(void) prepareHeadersWithUDID:(BOOL)useUdid Certificate:(BOOL)useCertificate{
    [self.defaultHeaders removeObjectForKey:kParamUDID];
    [self.defaultHeaders removeObjectForKey:@"Authorization"];

    if(useUdid && self.accessUDID){
        [self setDefaultHeader:kParamUDID value:self.accessUDID];
        //_mark 若没有uuid的话怎么处理？每次发起请求之前都确认所需的信息，若为空，则先请求
        if (!_accessUDID) {
            [self requestUDIDOnSucceeded:nil onError:nil];  //            DLog(@"没有uuid!!");
        }
    }
    if (useCertificate) {
        [self setAuthorizationHeaderWithUsername:kClientID password:kClientSecret];
    }
}
//处理获取到的数据
-(id) handleResponseData:(NSData *)data{
    RESTError *customError=nil;
    if (data) {
        NSError *error=nil;
        id responseDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        if (error) {
            customError=[[RESTError alloc] initWithCode:error.code description:error.localizedDescription];
            return customError;
        }else if([responseDic isKindOfClass:[NSDictionary class]] && [responseDic objectForKey:@"error"]){
            customError=[[RESTError alloc] initWithDictionary:responseDic];
            return customError;
        }else{
            return responseDic;
        }
    }
    return customError;
}

//判断是否过期
-(BOOL) isExpiresToken{
    if (!self.accessToken)
        return YES;
    double timeInterval = [[self expiresDate] timeIntervalSinceNow];
    return timeInterval < EXPIRES_IN;
}

#pragma mark -
#pragma mark request function
-(void) commonOpWithUrlPath:(NSString *)path
                onSucceeded:(DictionaryBlock) succeededBlock
                    onError:(ErrorBlock) errorBlock{
    [self commonOpWithUrlPath:path params:nil udidOnly:YES needToken:YES onSucceeded:succeededBlock onError:errorBlock];
}

-(void) commonOpWithUrlPath:(NSString *)path
                     params:(NSDictionary *)paramsDic
                onSucceeded:(DictionaryBlock) succeededBlock
                    onError:(ErrorBlock) errorBlock{
    [self commonOpWithUrlPath:path params:paramsDic udidOnly:YES needToken:YES onSucceeded:succeededBlock onError:errorBlock];
}

-(void) commonOpWithUrlPath:(NSString *)path
                     params:(NSDictionary *)paramsDic
                   udidOnly:(BOOL)udidOnly
                  needToken:(BOOL)needToken
                onSucceeded:(DictionaryBlock) succeededBlock
                    onError:(ErrorBlock) errorBlock{
    //make sure token is newest
    if (needToken && [self isExpiresToken]){
        [AppDelegateShare.authEngine refreshTokenOnSucceeded:^{
            [self opWithUrlPath:path params:paramsDic udidOnly:udidOnly needToken:needToken onSucceeded:succeededBlock onError:errorBlock];
        } onError:^(RESTError *engineError) {
            errorBlock(engineError);
        }];
        return;
    }
    [self opWithUrlPath:path params:paramsDic udidOnly:udidOnly needToken:needToken onSucceeded:succeededBlock onError:errorBlock];
}

-(void) opWithUrlPath:(NSString *)path
               params:(NSDictionary *)paramsDic
             udidOnly:(BOOL)udidOnly
            needToken:(BOOL)needToken
          onSucceeded:(DictionaryBlock) succeededBlock
              onError:(ErrorBlock) errorBlock{

    udidOnly ? [self prepareHeadersWithUDID:YES Certificate:NO] : [self prepareHeadersWithUDID:YES Certificate:YES];

    
    if (needToken){
        if (!paramsDic) {
            paramsDic =[NSDictionary dictionaryWithObject:self.accessToken forKey:kParamToken];
        }else{
            NSMutableDictionary *dicWithToken=[NSMutableDictionary dictionaryWithDictionary:paramsDic];
            [dicWithToken setValue:self.accessToken forKey:kParamToken];
            paramsDic=dicWithToken;
        }
    }
    [self postPath:path parameters:paramsDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result=[self handleResponseData:operation.responseData];
        if ([result isKindOfClass:[RESTError class]] && ![[(RESTError *)result errorCode] isEqualToString:@"3840"]) {
            errorBlock(result);
            return;
        }else if([result isKindOfClass:[NSDictionary class]]){
            //返回验证结果
            succeededBlock(result);
        }
        else if(operation.responseString){
            //返回字符串结果
            succeededBlock((NSDictionary *)operation.responseString);
        }
        else{
            RESTError *customError=[[RESTError alloc] initWithCode:10005 description:nil];
            errorBlock(customError);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([error code] != NSURLErrorCancelled) {
            RESTError *customError=[[RESTError alloc] initWithCode:error.code description:error.localizedDescription];
            errorBlock(customError);
        }
    }];
}

#pragma mark 设备
-(void) requestUDIDOnSucceeded:(VoidBlock) succeededBlock
                       onError:(ErrorBlock) errorBlock{
    [self requestUDIDWithOsversion:nil Resolution:nil Rrademark:nil Installdate:nil parameter:nil onSucceeded:succeededBlock onError:errorBlock];
}

-(void) requestUDIDWithOsversion:(NSString *)osversion
                      Resolution:(NSString *)resolution
                       Rrademark:(NSString *) trademark
                     Installdate:(NSString *) installdate
                       parameter:(NSDictionary *)parameter
                     onSucceeded:(VoidBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock{
    
    if ([self.baseURL.absoluteString isEqualToString:kAuthURL]) {
        //参数处理
        NSMutableDictionary *paramsDic=[NSMutableDictionary new];
        [parameter setValue:osversion forKey:kOsversion];
        [parameter setValue:resolution forKey:kResolution];
        [parameter setValue:trademark forKey:kTrademark];
        [parameter setValue:installdate forKey:kInstalldate];
        
        [paramsDic addEntriesFromDictionary:parameter];
        [self prepareHeadersWithUDID:NO Certificate:YES];
        [self postPath:kPathUDID parameters:paramsDic
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        //_mark success是指请求，还需要处理服务器的error
                                        id result=[self handleResponseData:operation.responseData];
                                        
                                        if ([result isKindOfClass:[RESTError class]]) {
                                            errorBlock(result);
                                            return;
                                        }else if([result isKindOfClass:[NSDictionary class]]){
                                            self.accessUDID=[result objectForKey:kParamUDID];
                                            self.secret=[result objectForKey:kParamSecret];
                                            //DLog(@"获取成功&保存udid：%@",result);
                                        }
                                        succeededBlock();
                                    }
                                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        RESTError *customError=[[RESTError alloc] initWithCode:error.code description:error.localizedDescription];
                                        errorBlock(customError);
                                    }];
    }else{
        if (errorBlock) {
            RESTError *customError=[[RESTError alloc] initWithCode:10001 description:nil];
            errorBlock(customError);
        }
    }
}

-(void) uninstallBBS{
    [self uninstallBBSWithDate:nil onSucceeded:nil onError:nil];
}

-(void) uninstallBBSWithDate:(NSString *)date
                 onSucceeded:(VoidBlock) succeededBlock
                     onError:(ErrorBlock) errorBlock{
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:date,kUninstalldate,nil];
    [self prepareHeadersWithUDID:YES Certificate:YES];
    [self postPath:kPathUninstall parameters:paramsDic
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               //_mark success是指请求，还需要处理服务器的error
               id result=[self handleResponseData:operation.responseData];
               
               if ([result isKindOfClass:[RESTError class]]) {
                   errorBlock(result);
                   return;
               }else if([result isKindOfClass:[NSDictionary class]]){
                   DLog(@"卸载信息发送完成：%@",result);
                   self.accessToken=nil;
                   self.accessUDID=nil;
                   self.secret=nil;
                   self.refreshToken=nil;
                   self.expiresDate=nil;
               }
               succeededBlock();
           }
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               RESTError *customError=[[RESTError alloc] initWithCode:error.code description:error.localizedDescription];
               errorBlock(customError);
           }];
    
}

#pragma mark 令牌
-(void) requestTokenWithUserName:(NSString *)username passWord:(NSString *)password onSucceeded:(VoidBlock) succeededBlock onError:(ErrorBlock) errorBlock{
    if (![self.baseURL.absoluteString isEqualToString:kAuthURL]) {
        RESTError *error=[[RESTError alloc] initWithCode:10001 description:nil];
        errorBlock(error);
    }else if(!username || !password || [username isEqualToString:@""] || [password isEqualToString:@""]){
        RESTError *error=[[RESTError alloc] initWithCode:10002 description:nil];
        errorBlock(error);
    }else{
        [self requestTokenWithUserName:username passWord:password grantType:@"password" onSucceeded:succeededBlock onError:errorBlock];
    }
}
-(void) requestTokenWithUserName:(NSString *)username
                        passWord:(NSString *)password
                       grantType:(NSString *)granttype
                     onSucceeded:(VoidBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock{
    NSDictionary *paramsDic=[NSDictionary dictionaryWithObjectsAndKeys:granttype,@"grant_type", username,kParamUserName,password,kParamPassWord,nil];
    if (!_accessUDID) {
        [self requestUDIDOnSucceeded:^{
            [self prepareHeadersWithUDID:YES Certificate:YES];
            [self postPath:kPathToken parameters:paramsDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                id result=[self handleResponseData:operation.responseData];
                
                if ([result isKindOfClass:[RESTError class]]) {
                    errorBlock(result);
                    return;
                }else if([result isKindOfClass:[NSDictionary class]]){
                    DLog(@"获取成功&保存token：%@",result);
                    self.accessToken=[result objectForKey:kParamToken];
                    self.refreshToken=[result objectForKey:kParamReToken];
                    self.expiresDate=[NSDate date];
                }
                succeededBlock();
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                RESTError *customError=[[RESTError alloc] initWithCode:error.code description:error.localizedDescription];
                errorBlock(customError);
            }];
        } onError:^(RESTError *engineError) {
            [engineError setErrorCode:[NSString stringWithFormat:@"%d",10003]];
            errorBlock(engineError);
        }];
    }else{
        [self prepareHeadersWithUDID:YES Certificate:YES];
        [self postPath:kPathToken parameters:paramsDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            id result=[self handleResponseData:operation.responseData];
            
            if ([result isKindOfClass:[RESTError class]]) {
                errorBlock(result);
                return;
            }else if([result isKindOfClass:[NSDictionary class]]){
                DLog(@"获取&保存token：%@",result);
                self.accessToken=[result objectForKey:kParamToken];
                self.refreshToken=[result objectForKey:kParamReToken];
                self.expiresDate=[NSDate date];
            }
            succeededBlock();
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            RESTError *customError=[[RESTError alloc] initWithCode:error.code description:error.localizedDescription];
            errorBlock(customError);
        }];
    }
}

-(void) refreshTokenByRefreshToken{
    [self refreshTokenOnSucceeded:nil onError:nil];
}
-(void) refreshTokenOnSucceeded:(VoidBlock) succeededBlock onError:(ErrorBlock) errorBlock{
    if (!self.refreshToken && errorBlock) {
        RESTError *customError=[[RESTError alloc] initWithCode:10004 description:nil];
        errorBlock(customError);
        return;
    }
    
    NSDictionary *paramsDic=[NSDictionary dictionaryWithObjectsAndKeys:@"refresh_token",@"grant_type",[self refreshToken],kParamReToken,nil];
    [self prepareHeadersWithUDID:YES Certificate:YES];
    [self postPath:kPathToken parameters:paramsDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result=[self handleResponseData:operation.responseData];
        
        if ([result isKindOfClass:[RESTError class]]) {
            errorBlock(result);
            return;
        }else if([result isKindOfClass:[NSDictionary class]]){
            DLog(@"刷新 token：%@",result);
            self.accessToken=[result objectForKey:kParamToken];
            self.refreshToken=[result objectForKey:kParamReToken];
            self.expiresDate=[NSDate date];
        }
        succeededBlock();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        RESTError *customError=[[RESTError alloc] initWithCode:error.code description:error.localizedDescription];
        errorBlock(customError);
    }];
}

#pragma mark 基础数据
-(void) opAreaUseCache:(BOOL)useCache
               onSucceeded:(ArrayBlock) succeededBlock
                   onError:(ErrorBlock) errorBlock{
    if (useCache) {
        NSString* areaJsonPath =[NSTemporaryDirectory() stringByAppendingPathComponent:@"areas.json"];
        if([[NSFileManager defaultManager] fileExistsAtPath:areaJsonPath]){
            NSString* tempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"areas.json"];
            
            NSData *data=[NSData dataWithContentsOfFile:tempFile];
            if (data) {
                NSArray *areaArray =[NSJSONSerialization JSONObjectWithData:data
                                                           options:NSJSONReadingAllowFragments
                                                             error:nil];
                succeededBlock(areaArray);
                DLog(@"从缓存取到地区数据");
                return;
            }
        }
    }
    
    [self prepareHeadersWithUDID:YES Certificate:NO];
    [self getPath:kPathArea parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result=[self handleResponseData:operation.responseData];
        if ([result isKindOfClass:[RESTError class]]) {
            errorBlock(result);
            return;
        }else if([result isKindOfClass:[NSArray class]]){
            NSString* areaJsonPath =[NSTemporaryDirectory() stringByAppendingPathComponent:@"areas.json"];
            [operation.responseData writeToFile:areaJsonPath atomically:YES];
            succeededBlock(result);
        } else{
            RESTError *customError=[[RESTError alloc] initWithCode:10005 description:nil];
            errorBlock(customError);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([error code] != NSURLErrorCancelled) {
            RESTError *customError=[[RESTError alloc] initWithCode:error.code description:error.localizedDescription];
            errorBlock(customError);
        }
    }];
}
-(void) cancelOpArea{
    [self cancelAllHTTPOperationsWithMethod:@"GET" path:kPathArea];
}

-(void) opProjectClassify:(BOOL)useCache
                 onSucceeded:(ArrayBlock) succeededBlock
                     onError:(ErrorBlock) errorBlock{
    if (useCache) {
        NSString* areaJsonPath =[NSTemporaryDirectory() stringByAppendingPathComponent:@"ProjectClassify.json"];
        if([[NSFileManager defaultManager] fileExistsAtPath:areaJsonPath]){
            NSString* tempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"ProjectClassify.json"];
            NSData *data=[NSData dataWithContentsOfFile:tempFile];
            if (data) {
                NSArray *classify =[NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingAllowFragments
                                                                      error:nil];
                succeededBlock(classify);
                DLog(@"从缓存取到分类数据");
                return;
            }
        }
    }
    [self prepareHeadersWithUDID:YES Certificate:NO];
    [self getPath:kPathProjclass parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result=[self handleResponseData:operation.responseData];
        if ([result isKindOfClass:[RESTError class]]) {
            errorBlock(result);
            return;
        }else if([result isKindOfClass:[NSArray class]]){
            NSString* classifyJsonPath =[NSTemporaryDirectory() stringByAppendingPathComponent:@"ProjectClassify.json"];
            [operation.responseData writeToFile:classifyJsonPath atomically:YES];
            succeededBlock(result);
        } else{
            RESTError *customError=[[RESTError alloc] initWithCode:10005 description:nil];
            errorBlock(customError);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([error code] != NSURLErrorCancelled) {
            RESTError *customError=[[RESTError alloc] initWithCode:error.code description:error.localizedDescription];
            errorBlock(customError);
        }
    }];
}

-(void) cancelOpProjectClassify{
    [self cancelAllHTTPOperationsWithMethod:@"GET" path:kPathProjclass];
}

#pragma mark 注册-验证
-(void) opValidMobile:(NSString *)mobileNo
             onSucceeded:(DictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock{
    NSDictionary *paramsDic=[NSDictionary dictionaryWithObjectsAndKeys:mobileNo,kParamMobile,nil];
    //[self commonOp:paramsDic urlPath:kPathValidMobile udidOnly:YES onSucceeded:succeededBlock onError:errorBlock];
    [self commonOpWithUrlPath:kPathValidMobile params:paramsDic udidOnly:YES needToken:NO onSucceeded:succeededBlock onError:errorBlock];
}
-(void) cancelOpValidMobile{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathValidMobile];
}


-(void) opValidCode:(NSString *)mobileNo
           onSucceeded:(DictionaryBlock) succeededBlock
               onError:(ErrorBlock) errorBlock{
    NSDictionary *paramsDic=[NSDictionary dictionaryWithObjectsAndKeys:mobileNo,kParamMobile,nil];
    [self commonOpWithUrlPath:kPathGetValidCode params:paramsDic udidOnly:YES needToken:NO onSucceeded:succeededBlock onError:errorBlock];
}

-(void) cancelOpValidCode{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathValidCode];
}


-(void) opVerifyCode:(NSString *)code
                 Mobile:(NSString *)mobileNo
            onSucceeded:(DictionaryBlock) succeededBlock
                onError:(ErrorBlock) errorBlock{
    NSDictionary *paramsDic=[NSDictionary dictionaryWithObjectsAndKeys:mobileNo,kParamMobile,code,kParamCode,nil];
    [self commonOpWithUrlPath:kPathValidCode params:paramsDic udidOnly:YES needToken:NO onSucceeded:succeededBlock onError:errorBlock];
}

-(void) cancelOpVerifyCode{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathValidCode];
}
#pragma mark 注册-信息

-(void) opVerifyUserInfoWithMobile:(NSString *)mobileNo
                             UserName:(NSString *)name
                              Company:(NSString *)company
                             Password:(NSString *)password
                          onSucceeded:(DictionaryBlock) succeededBlock
                              onError:(ErrorBlock) errorBlock{
    [self opVerifyUserInfoWithMobile:mobileNo UserName:name Company:company Password:password Location:nil onSucceeded:succeededBlock onError:errorBlock];
}

-(void) opVerifyUserInfoWithMobile:(NSString *)mobileNo
                             UserName:(NSString *)name
                              Company:(NSString *)company
                             Password:(NSString *)password
                             Location:(NSString *)location
                          onSucceeded:(DictionaryBlock) succeededBlock
                              onError:(ErrorBlock) errorBlock{
    NSDictionary *paramsDic=nil;
    if (location) {
//#warning 对地区进行一个转换
        paramsDic=[NSDictionary dictionaryWithObjectsAndKeys:mobileNo,kParamMobile,name,kParamName,company,kParamCompany,password,kParamPassWord,location,kParamLocation,nil];
    }else{
        paramsDic=[NSDictionary dictionaryWithObjectsAndKeys:mobileNo,kParamMobile,name,kParamName,company,kParamCompany,password,kParamPassWord,nil];
    }
    [self commonOpWithUrlPath:kPathPostUserInfo params:paramsDic udidOnly:YES needToken:NO onSucceeded:succeededBlock onError:errorBlock];
}

-(void) cancelOpVerifyUserInfo{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathPostUserInfo];
}

//#pragma mark 找回密码
-(void) opValidMobileFG:(NSString *)mobileNo
                   onSucceeded:(DictionaryBlock) succeededBlock
                       onError:(ErrorBlock) errorBlock{
    NSDictionary *paramsDic=[NSDictionary dictionaryWithObjectsAndKeys:mobileNo,kParamMobile,nil];
    [self commonOpWithUrlPath:kPathFGValidMobile params:paramsDic udidOnly:YES needToken:NO onSucceeded:succeededBlock onError:errorBlock];
}

-(void) cancelOpValidMobileFG{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathFGValidMobile];
}

-(void) opValidCodeFG:(NSString *)mobileNo
             onSucceeded:(DictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock{
    NSDictionary *paramsDic=[NSDictionary dictionaryWithObjectsAndKeys:mobileNo,kParamMobile,nil];
    [self commonOpWithUrlPath:kPathFGGetValidCode params:paramsDic udidOnly:YES needToken:NO onSucceeded:succeededBlock onError:errorBlock];
}

-(void) cancelOpValidCodeFG{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathFGGetValidCode];
}

-(void) opVerifyCodeFG:(NSString *)code
                   Mobile:(NSString *)mobileNo
              onSucceeded:(DictionaryBlock) succeededBlock
                  onError:(ErrorBlock) errorBlock{
    NSDictionary *paramsDic=[NSDictionary dictionaryWithObjectsAndKeys:mobileNo,kParamMobile,code,kParamCode,nil];
    [self commonOpWithUrlPath:kPathFGValidCode params:paramsDic udidOnly:YES needToken:NO onSucceeded:succeededBlock onError:errorBlock];
}

-(void) cancelOpVerifyCodeFG{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathFGValidCode];
}

-(void) opChangePassword:(NSString *)passwd
                  Mobile:(NSString *)mobileNo
             onSucceeded:(DictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock{
    NSDictionary *paramsDic=[NSDictionary dictionaryWithObjectsAndKeys:mobileNo,kParamMobile,passwd,kParamPassWord,nil];
    [self commonOpWithUrlPath:kPathUpdatePassword params:paramsDic udidOnly:YES needToken:NO onSucceeded:succeededBlock onError:errorBlock];
}

-(void) cancelOpChangePassword{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathUpdatePassword];
}

#pragma mark -  用户模块

/** 获取用户全部账户信息（用户档案、工程信息服务属性、工程信息订阅属性）
 @return user_info：用户档案对象
 @return user_service：工程信息服务属性对象
 @return user_subscription：工程信息订阅属性对象
 */
-(void) opGetAllInfoOnSucceeded:(ModelBlock) succeededBlock
                        onError:(ErrorBlock) errorBlock{
    [self commonOpWithUrlPath:kPathGetAllInfo onSucceeded:^(NSDictionary *dictionary) {
        ELog(dictionary);
        UserModel *user=[[UserModel alloc] initWithDictionary:dictionary];
        succeededBlock(user);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

-(void) cancelOpGetAllInfo{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathGetAllInfo];
}


-(void) opGetUserInfoOnSucceeded:(ModelBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock{
    [self commonOpWithUrlPath:kPathGetUserInfo onSucceeded:^(NSDictionary *dictionary) {
        UserModel *user=[[UserModel alloc] initWithDictionary:dictionary];
        succeededBlock(user);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

-(void) cancelOpGetUserInfo{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathGetUserInfo];
}

-(void) opGetServiceInfoOnSucceeded:(ModelBlock) succeededBlock
                            onError:(ErrorBlock) errorBlock{
    [self commonOpWithUrlPath:kPathGetServiceInfo onSucceeded:^(NSDictionary *dictionary) {
        ELog(dictionary);
        UserModel *user=[[UserModel alloc] initWithDictionary:dictionary];
        succeededBlock(user);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

-(void) cancelOpGetServiceInfo{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathGetServiceInfo];
}

#pragma mark 标记状态
-(void) markUserLoginOnSucceeded:(DictionaryBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock{
    [self commonOpWithUrlPath:kPathMarkLogin onSucceeded:^(NSDictionary *dictionary) {
        succeededBlock(dictionary);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

-(void) markUserLogoutOnSucceeded:(DictionaryBlock) succeededBlock
                          onError:(ErrorBlock) errorBlock{
    [self commonOpWithUrlPath:kPathMarkLogout onSucceeded:^(NSDictionary *dictionary) {
        succeededBlock(dictionary);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

-(void) markAppLaunchingOnSucceeded:(DictionaryBlock) succeededBlock
                            onError:(ErrorBlock) errorBlock{
    [self commonOpWithUrlPath:kPathMarkAppStart onSucceeded:^(NSDictionary *dictionary) {
        succeededBlock(dictionary);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

-(void) markAppClosureOnSucceeded:(DictionaryBlock) succeededBlock
                          onError:(ErrorBlock) errorBlock{
    [self commonOpWithUrlPath:kPathMarkAppClose onSucceeded:^(NSDictionary *dictionary) {
        succeededBlock(dictionary);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

#pragma mark 更新信息

-(void) commonUpdateOpWithUrlPath:(NSString *)path
                             update:(NSString *)value
                       onSucceeded:(DictionaryBlock) succeededBlock
                           onError:(ErrorBlock) errorBlock{
    NSDictionary *paramsDic=[NSDictionary dictionaryWithObjectsAndKeys:value,kParamValue,nil];
    [self commonOpWithUrlPath:path params:paramsDic onSucceeded:^(NSDictionary *dictionary) {
        succeededBlock(dictionary);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

-(void) opUpdateUsername:(NSString *)name
             onSucceeded:(DictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock{
    [self commonUpdateOpWithUrlPath:kPathUpdateName update:name onSucceeded:succeededBlock onError:errorBlock];
}

-(void) opUpdateUserGender:(NSString *)gender
               onSucceeded:(DictionaryBlock) succeededBlock
                   onError:(ErrorBlock) errorBlock{
    [self commonUpdateOpWithUrlPath:kPathUpdateGender update:gender onSucceeded:succeededBlock onError:errorBlock];
}

-(void) opUpdateUserPost:(NSString *)post
             onSucceeded:(DictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock{
    [self commonUpdateOpWithUrlPath:kPathUpdatePost update:post onSucceeded:succeededBlock onError:errorBlock];
}

-(void) opUpdateUserCompany:(NSString *)company
                onSucceeded:(DictionaryBlock) succeededBlock
                    onError:(ErrorBlock) errorBlock{
    [self commonUpdateOpWithUrlPath:kPathUpdateCompany update:company onSucceeded:succeededBlock onError:errorBlock];
}


-(void) opUpdateUserQQ:(NSString *)qq
           onSucceeded:(DictionaryBlock) succeededBlock
               onError:(ErrorBlock) errorBlock{
    [self commonUpdateOpWithUrlPath:kPathUpdateQQ update:qq onSucceeded:succeededBlock onError:errorBlock];
}


-(void) opUpdateUserAddress:(NSString *)address
                onSucceeded:(DictionaryBlock) succeededBlock
                    onError:(ErrorBlock) errorBlock{
    [self commonUpdateOpWithUrlPath:kPathUpdateAddress update:address onSucceeded:succeededBlock onError:errorBlock];
}


-(void) opUpdateUserFace:(UIImage *)faceImg
             onSucceeded:(DictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock{
    if ([self isExpiresToken]){
        [AppDelegateShare.authEngine refreshTokenOnSucceeded:^{
            [self updateUserFace:faceImg onSucceeded:succeededBlock onError:errorBlock];
        } onError:^(RESTError *engineError) {
            errorBlock(engineError);
        }];
    }else{
        [self updateUserFace:faceImg onSucceeded:succeededBlock onError:errorBlock];
    }
}

-(void) updateUserFace:(UIImage *)faceImg onSucceeded:(DictionaryBlock)succeededBlock onError:(ErrorBlock)errorBlock{
    NSData *faceData=UIImagePNGRepresentation(faceImg);
    NSDictionary *dicWithToken=[NSDictionary dictionaryWithObject:self.accessToken forKey:kParamToken];
    NSMutableURLRequest *request = [self multipartFormRequestWithMethod:@"POST" path:kPathUpdateFace parameters:dicWithToken constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        [formData appendPartWithFileData:faceData name:@"avatar" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
    }];
    [request setAllHTTPHeaderFields:[NSDictionary dictionaryWithObject:self.accessUDID forKey:kParamUDID]];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id result=[self handleResponseData:operation.responseData];
        if ([result isKindOfClass:[RESTError class]]) {
            errorBlock(result);
            return;
        }else if([result isKindOfClass:[NSDictionary class]]){
            succeededBlock(result);
        }else{
            RESTError *customError=[[RESTError alloc] initWithCode:10005 description:nil];
            errorBlock(customError);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        RESTError *myError=[[RESTError alloc] initWithCode:error.code description:error.localizedDescription];
        errorBlock(myError);
    }];
    
    [self enqueueHTTPRequestOperation:operation];
}

-(void) cancelUpdateUserFace{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathUpdateFace];
}

#pragma mark - 项目模块
#pragma mark 订阅信息&搜索

-(void) opGetSubInfoOnSucceeded:(DictionaryBlock) succeededBlock
                        onError:(ErrorBlock) errorBlock{
    [self commonOpWithUrlPath:kPathGetSubInfo onSucceeded:succeededBlock onError:errorBlock];
}

-(void) opCancelGetSubInfo{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathGetSubInfo];
}



-(void) opGetSubProjectListWithPage:(NSString *)page
                              count:(NSString *)count
                        onSucceeded:(ModelArrayAndInfoBlock) succeededBlock
                            onError:(ErrorBlock) errorBlock{
    NSMutableDictionary *params=nil;
    if (page || count) {
        params=[NSMutableDictionary new];
        [params setValue:page forKey:kParamPage];
        [params setValue:count forKey:kParamCount];
    }
    [self commonOpWithUrlPath:kPathGetSubList params:params onSucceeded:^(NSDictionary *dictionary) {
        NSDictionary *infoDic=[NSDictionary dictionaryWithObjectsAndKeys:[dictionary objectForKey:@"next_page"],@"next_page",[dictionary objectForKey:@"update_count"],@"update_count",nil];
        
        NSArray *itemArr=[dictionary objectForKey:@"items"];
        NSMutableArray *projectModelArray=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *itemDic in itemArr) {
            ProjectModel *proObj=[[ProjectModel alloc] initWithDictionary:itemDic];            
            [projectModelArray addObject:proObj];
        }
        
        succeededBlock(projectModelArray,infoDic);
    } onError:errorBlock];
}

-(void) opCancelGetSubProjectList{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathGetSubList];
}



-(void) opSearchProjectWithPage:(NSString *)page
                          count:(NSString *)count
                         region:(NSString *)regionNo
                        keyword:(NSString *)keyword
                           type:(NSString *)type
                    OnSucceeded:(ModelArrayAndInfoBlock) succeededBlock
                        onError:(ErrorBlock) errorBlock{
    if (!regionNo && !type && !keyword) {
        RESTError *error=[[RESTError alloc] initWithCode:10002 description:nil];
        errorBlock(error);
    }else{
        NSMutableDictionary *params=[NSMutableDictionary dictionaryWithCapacity:0];
        [params setValue:page forKey:kParamPage];
        [params setValue:count forKey:kParamCount];
        [params setValue:regionNo forKey:kParamRegion];
        [params setValue:keyword forKey:kParamKeyword];
        [params setValue:type forKey:kParamType];
        
        [self commonOpWithUrlPath:kPathSearchList params:params onSucceeded:^(NSDictionary *dictionary) {
            NSDictionary *infoDic=[NSDictionary dictionaryWithObjectsAndKeys:[dictionary objectForKey:@"next_page"],@"next_page",[dictionary objectForKey:@"record_count"],@"record_count",nil];
            NSArray *itemArr=[dictionary objectForKey:@"items"];
            NSMutableArray *projectModelArray=[NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *itemDic in itemArr) {
                ProjectModel *proObj=[[ProjectModel alloc] initWithDictionary:itemDic];
                [projectModelArray addObject:proObj];
            }
            
            succeededBlock(projectModelArray,infoDic);
        } onError:^(RESTError *engineError) {
            errorBlock(engineError);
        }];
    }
}

-(void) opCancelSearchProject{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathSearchList];
}

#pragma mark 设置
-(void) opSetSubRegion:(NSString *)regionNo
           onSucceeded:(DictionaryBlock) succeededBlock
               onError:(ErrorBlock) errorBlock{
    NSDictionary *paramDic=[NSDictionary dictionaryWithObject:regionNo forKey:kParamRegion];
    [self commonOpWithUrlPath:kPathSetSubRegion params:paramDic onSucceeded:succeededBlock onError:errorBlock];
}

-(void) opCancelSetSubRegion{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathSetSubRegion];
}




-(void) opSetSubType:(NSString *)type
         onSucceeded:(DictionaryBlock) succeededBlock
             onError:(ErrorBlock) errorBlock{
    NSDictionary *paramDic=[NSDictionary dictionaryWithObject:type forKey:kParamType];
    [self commonOpWithUrlPath:kPathSetSubType params:paramDic onSucceeded:succeededBlock onError:errorBlock];
}

-(void) opCancelSetSubType{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathSetSubType];
}



-(void) opSetSubType:(NSString *)type
              region:(NSString *)regionNo
         onSucceeded:(DictionaryBlock) succeededBlock
             onError:(ErrorBlock) errorBlock{
    NSMutableDictionary *paramDic=nil;
    if (type || regionNo) {
        paramDic=[NSMutableDictionary new];
        [paramDic setValue:type forKey:kParamType];
        [paramDic setValue:regionNo forKey:kParamRegion];
    }    
    [self commonOpWithUrlPath:kPathSetSubAll params:paramDic onSucceeded:succeededBlock onError:errorBlock];
}

-(void) opCancelSetSubTypeNregion{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathSetSubAll];
}

#pragma mark 查看
//查看详情
-(void) opQueryProjectDetailWithId:(NSString *)projectId
                       onSucceeded:(ModelBlock) succeededBlock
                           onError:(ErrorBlock) errorBlock{
    NSDictionary *paramDic=[NSDictionary dictionaryWithObjectsAndKeys:projectId,@"projid",nil];
    [self commonOpWithUrlPath:kPathProjectList params:paramDic udidOnly:NO needToken:YES onSucceeded:^(NSDictionary *dictionary) {
        ProjectDetailModel *detail=[[ProjectDetailModel alloc] initWithDictionary:dictionary];
        succeededBlock(detail);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

-(void) opCancelQueryProjectDetail{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathProjectList];
}

//付费 查看详情
-(void) opPayProjectDetailWithId:(NSString *)projectId
                     onSucceeded:(ModelBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock{
    
    NSDictionary *paramDic=[NSDictionary dictionaryWithObjectsAndKeys:projectId,@"projid",nil];
    [self commonOpWithUrlPath:kPathCostForView params:paramDic udidOnly:NO needToken:YES onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"付费查看的详情 :%@ ",dictionary);
        ProjectDetailModel *detail=[[ProjectDetailModel alloc] initWithDictionary:dictionary];
        succeededBlock(detail);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

//标记已看
-(void) opSignViewTimeWithId:(NSString *)projectId
           onSucceeded:(DictionaryBlock) succeededBlock
               onError:(ErrorBlock) errorBlock{
    NSDictionary *paramDic=[NSDictionary dictionaryWithObjectsAndKeys:projectId,@"projid",nil];
    [self commonOpWithUrlPath:kPathUpdateViewTime params:paramDic udidOnly:NO needToken:YES onSucceeded:^(NSDictionary *dictionary) {
        succeededBlock(dictionary);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

//收藏列表
-(void) opGetFavProjListWithPage:(NSString *)page
                           count:(NSString *)count
                     onSucceeded:(ModelArrayAndInfoBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock{
    NSMutableDictionary *params=nil;
    if (page || count) {
        params=[NSMutableDictionary new];
        [params setValue:page forKey:kParamPage];
        [params setValue:count forKey:kParamCount];
    }
    [self commonOpWithUrlPath:kPathFavGetList params:params onSucceeded:^(NSDictionary *dictionary) {
        NSDictionary *infoDic=[NSDictionary dictionaryWithObjectsAndKeys:[dictionary objectForKey:@"next_page"],@"next_page",[dictionary objectForKey:@"update_count"],@"update_count",nil];
        
        NSArray *itemArr=[dictionary objectForKey:@"items"];
        NSMutableArray *projectModelArray=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *itemDic in itemArr) {
            ProjectModel *proObj=[[ProjectModel alloc] initWithDictionary:itemDic];
            [projectModelArray addObject:proObj];
        }
        
        succeededBlock(projectModelArray,infoDic);
    } onError:errorBlock];

}

-(void) opCancelGetFavProjList{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathFavGetList];
}

//已付费的列表
-(void) opGetCostProjListWithPage:(NSString *)page
                            count:(NSString *)count
                      onSucceeded:(ModelArrayAndInfoBlock) succeededBlock
                          onError:(ErrorBlock) errorBlock{
    NSMutableDictionary *params=nil;
    if (page || count) {
        params=[NSMutableDictionary new];
        [params setValue:page forKey:kParamPage];
        [params setValue:count forKey:kParamCount];
    }
    [self commonOpWithUrlPath:kPathGetCostedProjectList params:params onSucceeded:^(NSDictionary *dictionary) {
        NSDictionary *infoDic=[NSDictionary dictionaryWithObjectsAndKeys:[dictionary objectForKey:@"next_page"],@"next_page",[dictionary objectForKey:@"update_count"],@"update_count",nil];
        
        NSArray *itemArr=[dictionary objectForKey:@"items"];
        NSMutableArray *projectModelArray=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *itemDic in itemArr) {
            ProjectModel *proObj=[[ProjectModel alloc] initWithDictionary:itemDic];
            [projectModelArray addObject:proObj];
        }
        
        succeededBlock(projectModelArray,infoDic);
    } onError:errorBlock];
}

-(void) opCancelGetCostProjList{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathGetCostedProjectList];
}


//我的项目
-(void) opGetFavUpdateListWithPage:(NSString *)page
                             count:(NSString *)count
                       onSucceeded:(ModelArrayAndInfoBlock) succeededBlock
                           onError:(ErrorBlock) errorBlock{
    NSMutableDictionary *params=nil;
    if (page || count) {
        params=[NSMutableDictionary new];
        [params setValue:page forKey:kParamPage];
        [params setValue:count forKey:kParamCount];
    }
    [self commonOpWithUrlPath:kPathFavUpdateList params:params onSucceeded:^(NSDictionary *dictionary) {
        NSDictionary *infoDic=[NSDictionary dictionaryWithObjectsAndKeys:[dictionary objectForKey:@"next_page"],@"next_page",[dictionary objectForKey:@"update_count"],@"update_count",nil];
        
        NSArray *itemArr=[dictionary objectForKey:@"items"];
        NSMutableArray *projectModelArray=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *itemDic in itemArr) {
            ProjectModel *proObj=[[ProjectModel alloc] initWithDictionary:itemDic];
            [projectModelArray addObject:proObj];
        }
        
        succeededBlock(projectModelArray,infoDic);
    } onError:errorBlock];
}

-(void) opCancelGetFavUpdateList{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:kPathFavUpdateList];
}


#pragma makr 收藏
-(void) opFavAddWithId:(NSString *)projectId
           onSucceeded:(DictionaryBlock) succeededBlock
               onError:(ErrorBlock) errorBlock{
    NSDictionary *paramDic=[NSDictionary dictionaryWithObjectsAndKeys:projectId,@"projid",nil];
    [self commonOpWithUrlPath:kPathFavAdd params:paramDic udidOnly:NO needToken:YES onSucceeded:^(NSDictionary *dictionary) {
        succeededBlock(dictionary);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

-(void) opFavRemoveWithId:(NSString *)projectId
              onSucceeded:(DictionaryBlock) succeededBlock
                  onError:(ErrorBlock) errorBlock{
    NSDictionary *paramDic=[NSDictionary dictionaryWithObjectsAndKeys:projectId,@"projid",nil];
    [self commonOpWithUrlPath:kPathFavRemove params:paramDic udidOnly:NO needToken:YES onSucceeded:^(NSDictionary *dictionary) {
        succeededBlock(dictionary);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}


#pragma mark - 其他模块
#pragma mark 反馈
-(void) opFeedbackMessage:(NSString *)message
              onSucceeded:(DictionaryBlock) succeededBlock
                  onError:(ErrorBlock) errorBlock{
    NSDictionary *paramDic=[NSDictionary dictionaryWithObjectsAndKeys:message,kParamContent,nil];
    [self commonOpWithUrlPath:kPathFeedback params:paramDic udidOnly:NO needToken:YES onSucceeded:^(NSDictionary *dictionary) {
        succeededBlock(dictionary);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

-(void) opPaymentWithArea:(NSString *)area_no
              onSucceeded:(NSStringBlock) succeededBlock
                  onError:(ErrorBlock) errorBlock{
    NSDictionary *paramDic=[NSDictionary dictionaryWithObjectsAndKeys:area_no,kParamArea,nil];
    [self commonOpWithUrlPath:kPathZhiFuOrder params:paramDic udidOnly:NO needToken:YES onSucceeded:^(NSDictionary *dictionary) {
        succeededBlock((NSString *)dictionary);
    } onError:^(RESTError *engineError) {
        errorBlock(engineError);
    }];
}

#pragma mark - get and set
-(NSString*) accessToken{
    //if(!_accessToken)
        _accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:kParamToken];
    return _accessToken;
}
-(void) setAccessToken:(NSString *) accessToken{   //注意这个不能用于多用户，因为只是创建一个key
//#warning 取token之前判断一下是否过期，加一个static 变量 3600
    _accessToken = accessToken;
    [[NSUserDefaults standardUserDefaults] setObject:_accessToken forKey:kParamToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString*) accessUDID{
    if(!_accessUDID)
        _accessUDID = [[NSUserDefaults standardUserDefaults] stringForKey:kParamUDID];
    return _accessUDID;
}
-(void) setAccessUDID:(NSString *) accessUDID{
    //注意这个不能用于多用户，因为只是创建一个key
    _accessUDID = accessUDID;
    [[NSUserDefaults standardUserDefaults] setObject:_accessUDID forKey:kParamUDID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString*) secret{
    if(!_secret)
        _secret = [[NSUserDefaults standardUserDefaults] stringForKey:kParamSecret];
    return _secret;
}
-(void) setSecret:(NSString *)secret{
    _secret = secret;
    [[NSUserDefaults standardUserDefaults] setObject:_secret forKey:kParamSecret];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString*) refreshToken{
    //if(!_refreshToken)
        _refreshToken = [[NSUserDefaults standardUserDefaults] stringForKey:kParamReToken];
    return _refreshToken;
}
-(void) setRefreshToken:(NSString *)refreshToken{
    _refreshToken = refreshToken;
    [[NSUserDefaults standardUserDefaults] setObject:_refreshToken forKey:kParamReToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSDate *) expiresDate{
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    //if(!_expiresDate)
        _expiresDate = [[NSUserDefaults standardUserDefaults] objectForKey:kParamExpiresIN];
    return _expiresDate;
}
-(void) setExpiresDate:(NSDate *)expiresDate{
    if (expiresDate != _expiresDate) {
        NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _expiresDate = expiresDate;
        [[NSUserDefaults standardUserDefaults] setObject:_expiresDate forKey:kParamExpiresIN];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


@end












