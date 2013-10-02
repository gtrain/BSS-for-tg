//
//  UserInfoUnit.h
//  BSS
//
//  Created by liuc on 13-9-23.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoUnit : NSObject

-(id)initWithSign:(NSString *)sign content:(NSString *)content andEditable:(BOOL)yn;

@property NSString *sign;
@property NSString *signContent;
@property BOOL isEditTable;

@end
