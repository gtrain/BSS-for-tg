//
//  ActionSheet.h
//  BSS
//
//  Created by zhangbo on 13-9-26.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionSheet : UIActionSheet


@property(nonatomic,retain)UIView *view;
@property(nonatomic,retain)UIToolbar *toolBar;

-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title;
/*因为是通过给ActionSheet 加 Button来改变ActionSheet, 所以大小要与actionsheet的button数有关
 height = 84, 134, 184, 234, 284, 334, 384, 434, 484
 如果要用self.view = anotherview.  那么another的大小也必须与view的大小一样
 */

@end
