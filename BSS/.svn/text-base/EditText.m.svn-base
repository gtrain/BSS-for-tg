//
//  UserProfileViewController.h
//  BSS
//
//  Created by liuc on 13-9-23.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "EditText.h"

@interface EditText ()
@property (nonatomic, retain) UILabel *placeholder;
@end

@implementation EditText

@synthesize placeholder = _placeholder;

- (void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
   
   _placeholder = nil;

}

- (void)setup
{
   if ([self placeholder]) {
      [[self placeholder] removeFromSuperview];
      [self setPlaceholder:nil];
   }
   
   CGRect frame = CGRectMake(8, 11, self.bounds.size.width - 16, 0.0);
   UILabel *placeholder = [[UILabel alloc] initWithFrame:frame];
   [placeholder setLineBreakMode:UILineBreakModeWordWrap];
   [placeholder setNumberOfLines:0];
   [placeholder setBackgroundColor:[UIColor clearColor]];
   [placeholder setAlpha:1.0];
   [placeholder setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
   [placeholder setTextColor:[UIColor lightGrayColor]];
   [placeholder setText:@""];
   [self addSubview:placeholder];
   [self sendSubviewToBack:placeholder];
   
   [self setPlaceholder:placeholder];

   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFocus:) name:UITextViewTextDidBeginEditingNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lostFocus:) name:UITextViewTextDidEndEditingNotification object:nil];
}

- (void)awakeFromNib
{
   [super awakeFromNib];
   [self setup];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
   self = [super initWithCoder:aDecoder];
   if (self) {
      [self setup];
   }
   return self;
}

- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self) {
      [self setup];
   }
   return self;
}

- (void)textChanged:(NSNotification *)notification
{
   if ([[_placeholder text] length] == 0) {
      return;
   }
   
   if ([[self text] length] == 0) {
      [_placeholder setAlpha:1.0];
   } else {
      [_placeholder setAlpha:0.0];
   }
}

- (void)getFocus:(NSNotification *)notification
{
    [_placeholder setAlpha:0.0];
}

- (void)lostFocus:(NSNotification *)notification
{
    if ([[self text] length] == 0) {
        [_placeholder setAlpha:1.0];
    } else {
        [_placeholder setAlpha:0.0];
    }
}

- (void)drawRect:(CGRect)rect
{
   [super drawRect:rect];
   if ([[self text] length] == 0 && [[_placeholder text] length] > 0) {
      [_placeholder setAlpha:1.0];
   } else {
      [_placeholder setAlpha:0.0];
   }
}

- (void)setFont:(UIFont *)font
{
   [super setFont:font];
   [_placeholder setFont:font];
}

- (NSString *)placeholderText
{
   return [_placeholder text];
}

- (void)setPlaceholderText:(NSString *)placeholderText
{
   [_placeholder setText:placeholderText];
   
   CGRect frame = _placeholder.frame;
   CGSize constraint = CGSizeMake(frame.size.width, self.bounds.size.height);
   CGSize size = [placeholderText sizeWithFont:[self font] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];      
   
   frame.size.height = size.height;
   [_placeholder setFrame:frame];
}

- (UIColor *)placeholderColor
{
   return [_placeholder textColor];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
   [_placeholder setTextColor:placeholderColor];
}

@end
