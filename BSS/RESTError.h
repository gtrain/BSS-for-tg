//
//  RESTError.h
//  iHotelApp
//
//  Created by Mugunth Kumar on 1-Jan-11.
//  Copyright 2010 Steinlogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kRequestErrorDomain @"HTTP_ERROR"
#define kBusinessErrorDomain @"BIZ_ERROR" // rename this appropriately

@interface RESTError : NSError{
    NSDictionary *_userErrorDic;
}

@property (nonatomic, strong) NSString *errorTitle;
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *errorDescription;
@property (nonatomic, strong) NSString *errorUri;
@property (nonatomic, strong, readonly) NSDictionary *userErrorDic; //数据层的error字典，根据errorCode查询对应的错误

- (NSString*) localizedOption;
-(id) initWithDictionary:(NSDictionary*) jsonObject;
-(id) initWithCode:(NSInteger)code description:(NSString*)description;

@end



//    从plist初始化dic  [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ErrorsList" ofType:@"plist"]];

//{
//    error = "invalid_client";
//    "error_code" = 301;
//    "error_description" = "\U7f3a\U5c11\U5ba2\U6237\U7aef\U8bc1\U4e66";
//    "error_uri" = "";
//}
