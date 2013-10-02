//
//  PageControl.m
//  BSS
//
//  Created by liuc on 13-9-28.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "PageControl.h"

@interface PageControl()

@property (nonatomic, strong) NSMutableArray *pointsArrangment;

@end

@implementation PageControl

-(void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    //refresh
    
}



-(void)drawPoint:(CGPoint)position{
    
}

@end

@interface PagePointFactor : NSObject

@end
