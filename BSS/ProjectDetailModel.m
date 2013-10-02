//
//  ProjectDetailModel.m
//  BSS
//
//  Created by YANGZQ on 13-9-26.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "ProjectDetailModel.h"
#import "ContsModel.h"

@implementation ProjectDetailModel
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
    }
    else if([key isEqualToString:@"conts"]){
        if ([value isKindOfClass:[NSArray class]] && [(NSArray *)value count]!=0 ) {
            NSArray *contsArr=(NSArray *)value;
            NSMutableArray *tmpArray=[NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *cont in contsArr) {
                ContsModel *proObj=[[ContsModel alloc] initWithDictionary:cont];
                [tmpArray addObject:proObj];
            }
            self.contsModelArray=tmpArray;
        }
    }
    else{
        NSLog(@"ProjectDetailModel Undefined Key: %@", key);
    }
}

@end

