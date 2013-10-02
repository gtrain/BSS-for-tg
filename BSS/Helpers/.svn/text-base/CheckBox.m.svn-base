//
//  UserProfileViewController.h
//  BSS
//
//  Created by liuc on 13-9-23.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "CheckBox.h"

static const CGFloat kHeight = 36.0f;

@interface CheckBox(Private)

- (UIImage *) checkBoxImageChecked:(BOOL)isChecked;
- (CGRect) imageViewFrameForCheckBoxImage:(UIImage *)img;
- (void) updateCheckBoxImage;

@end

@implementation CheckBox

@synthesize checked, enabled;
@synthesize stateChangedBlock;

- (id) initWithFrame:(CGRect)frame 
             checked:(BOOL)aChecked
{
    frame.size.height = kHeight;
    if (!(self = [super initWithFrame:frame])) {
        return self;
    }

    stateChangedSelector = nil;
    self.stateChangedBlock = nil;
    delegate = nil;
    checked = aChecked;
    self.enabled = YES;

    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];

    CGRect labelFrame = CGRectMake(32.0f, 7.0f, self.frame.size.width - 32, 20.0f);
    UILabel *l = [[UILabel alloc] initWithFrame:labelFrame];
    l.textAlignment = UITextAlignmentLeft;
    l.backgroundColor = [UIColor clearColor];
    l.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    l.textColor = [UIColor blackColor];
    l.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    l.shadowColor = [UIColor whiteColor];
    l.shadowOffset = CGSizeMake(0, 1);
    [self addSubview:l];
    textLabel = l;

    UIImage *img = [self checkBoxImageChecked:checked];
    CGRect imageViewFrame = [self imageViewFrameForCheckBoxImage:img];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:imageViewFrame];
    iv.image = img;
    [self addSubview:iv];
    checkBoxImageView = iv;

    return self;
}


- (void) setEnabled:(BOOL)isEnabled
{
    textLabel.enabled = isEnabled;
    enabled = isEnabled;
    checkBoxImageView.alpha = isEnabled ? 1.0f: 0.6f;
}

- (BOOL) enabled
{
    return enabled;
}

- (void) setText:(NSString *)text
{
    [textLabel setText:text];
}

- (void) setChecked:(BOOL)isChecked
{
    checked = isChecked;
    [self updateCheckBoxImage];
}

- (void) setStateChangedTarget:(id<NSObject>)target
                      selector:(SEL)selector
{
    delegate = target;
    stateChangedSelector = selector;
}

#pragma mark -
#pragma mark Private Methods

- (UIImage *) checkBoxImageChecked:(BOOL)isChecked
{
    NSString *suffix = isChecked ? @"on" : @"off";
    NSString *imageName = @"";
    imageName = @"checkbox_";
    imageName = [NSString stringWithFormat:@"%@%@", imageName, suffix];
    return [UIImage imageNamed:imageName];
}

- (CGRect) imageViewFrameForCheckBoxImage:(UIImage *)img
{
    CGFloat y = floorf((kHeight - img.size.height) / 2.0f);
    return CGRectMake(5.0f, y, img.size.width, img.size.height);
}

- (void) updateCheckBoxImage
{
    checkBoxImageView.image = [self checkBoxImageChecked:checked];
}

@end
