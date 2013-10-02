//
//  ContsModel.m
//  BSS
//
//  Created by YANGZQ on 13-9-27.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "ContsModel.h"

@implementation ContsModel

-(id) initWithDictionary:(NSDictionary *)dataDictionary{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dataDictionary];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"type"]) {
        self.typeName=[self typeNameByNo:value];
    }
    else{
        NSLog(@"ContsModel Undefined Key: %@", key);
    }
}

-(NSString *) typeNameByNo:(NSString *)type{
    NSString *typeName=@"";
    switch (type.intValue) {
        case 0:
            typeName=@"甲方";
            break;
        case 1:
            typeName=@"设计师";
            break;
        case 2:
            typeName=@"施工方";
            break;
        default:
            break;
    }
    return typeName;
}




@end
