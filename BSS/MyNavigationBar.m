//
//  MyNavigationBar.m
//  BSS
//
//  Created by YANGZQ on 13-9-17.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "MyNavigationBar.h"

@implementation MyNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"resource.bundle/navbarBg"] drawInRect:rect];
}


@end
