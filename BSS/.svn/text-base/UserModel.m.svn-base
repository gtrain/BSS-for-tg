//
//  UserModel.m
//  BSS
//
//  Created by YANGZQ on 13-9-18.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(id) initWithDictionary:(NSDictionary *)dataDictionary{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dataDictionary];
        [self setValuesForKeysWithDictionary:[dataDictionary objectForKey:@"user_info"]];
        [self setValuesForKeysWithDictionary:[dataDictionary objectForKey:@"user_service"]];
        
        NSDictionary *rssDic=[dataDictionary objectForKey:@"user_subscription"];
        if (rssDic) {
            self.rssRegion = [rssDic objectForKey:@"region"];
            self.rssType = [rssDic objectForKey:@"type"];
        }

//        self.name = [dataDictionary objectForKey:@"name"];
//        self.post = [dataDictionary objectForKey:@"post"];
//        self.qq = [dataDictionary objectForKey:@"qq"];
//        self.mobile = [dataDictionary objectForKey:@"mobile"];
//        self.icon_path = [dataDictionary objectForKey:@"icon_path"];
//        self.gender = [dataDictionary objectForKey:@"gender"];
//        self.email = [dataDictionary objectForKey:@"email"];
//        self.company = [dataDictionary objectForKey:@"company"];
//        self.business_address = [dataDictionary objectForKey:@"business_address"];
//        self.permission = [dataDictionary objectForKey:@"permission"];
//        self.region = [dataDictionary objectForKey:@"region"];
//        self.time_left = [dataDictionary objectForKey:@"time_left"];
//        self.unlock_count_left = [dataDictionary objectForKey:@"unlock_count_left"];
//        self.unlock_designerdetail_count_left = [dataDictionary objectForKey:@"unlock_designerdetail_count_left"];
    }
    return self;
}



//===========================================================
//  Keyed Archiving
//
//===========================================================
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:self.errorTitle forKey:@"error"];
//    [encoder encodeObject:self.errorCode forKey:@"error_code"];
//    [encoder encodeObject:self.errorDescription forKey:@"error_description"];
//    [encoder encodeObject:self.errorUri forKey:@"error_uri"];
//}
//
//- (id)initWithCoder:(NSCoder *)decoder
//{
//    if ((self = [super init])) {
//        self.errorTitle = [decoder decodeObjectForKey:@"error"];
//        self.errorCode = [decoder decodeObjectForKey:@"error_code"];
//        self.errorDescription = [decoder decodeObjectForKey:@"error_description"];
//        self.errorUri = [decoder decodeObjectForKey:@"error_uri"];
//    }
//    return self;
//}
//
//- (id)copyWithZone:(NSZone *)zone
//{
//    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
//	[theCopy setErrorCode:self.errorCode];
//    [theCopy setErrorTitle:[self.errorTitle copy]];
//    [theCopy setErrorDescription:[self.errorDescription copy]];
//    [theCopy setErrorUri:self.errorUri];
//	
//    return theCopy;
//}

@end
