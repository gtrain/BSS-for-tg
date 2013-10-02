//
//  UserProfileViewController.h
//  BSS
//
//  Created by liuc on 13-9-23.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditText : UITextView 
{
   UILabel *_placeholder;
}

@property (nonatomic, copy) NSString *placeholderText;
@property (nonatomic, retain) UIColor *placeholderColor;

@end
