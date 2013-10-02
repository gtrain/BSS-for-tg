//
//  UserProfileViewController.h
//  BSS
//
//  Created by liuc on 13-9-23.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckBox: UIView
{
    BOOL checked;
    BOOL enabled;

    UIImageView *checkBoxImageView;
    UILabel *textLabel;

    SEL stateChangedSelector;
    id<NSObject> delegate;

    void (^stateChangedBlock)(CheckBox *cbv);
}

@property (nonatomic, readonly) BOOL checked;
@property (nonatomic, getter=enabled, setter=setEnabled:) BOOL enabled;
@property (nonatomic, copy) void (^stateChangedBlock)(CheckBox *cbv);

- (id) initWithFrame:(CGRect)frame
             checked:(BOOL)aChecked;

- (void) setText:(NSString *)text;

- (void) setChecked:(BOOL)isChecked;

- (void) setStateChangedTarget:(id<NSObject>)target
                      selector:(SEL)selector;

@end
