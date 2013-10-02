//
//  ProjectModel.m
//  BSS
//
//  Created by YANGZQ on 13-9-26.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "ProjectModel.h"

@implementation ProjectModel

-(id) initWithDictionary:(NSDictionary *)dataDictionary{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dataDictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.projid=value;
    }else{
        NSLog(@"ProjectModel Undefined Key: %@", key);
    }
}

@end
