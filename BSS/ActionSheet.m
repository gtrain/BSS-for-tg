//
//  ActionSheet.m
//  BSS
//
//  Created by zhangbo on 13-9-26.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "ActionSheet.h"

@implementation ActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title
{//height = 84, 134, 184, 234, 284, 334, 384, 434, 484
	self = [super init];
    if (self)
	{
		int theight = height - 40;
		int btnnum = theight/50;
		for(int i=0; i<btnnum; i++)
		{
			[self addButtonWithTitle:@" "];
		}
		_toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
		_toolBar.barStyle = UIBarStyleBlack;
		
		UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithTitle:title style: UIBarButtonItemStylePlain target: nil action: nil];
        
        //		UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style: UIBarButtonItemStyleDone target: self action: @selector(done)];
        //		UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style: UIBarButtonItemStyleBordered target: self action: @selector(docancel)];
		UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
        
        NSArray *array = [[NSArray alloc] initWithObjects: fixedButton,titleButton,fixedButton, nil];
		[_toolBar setItems: array];
		[self addSubview:_toolBar];
		_view = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, height-40)];
		_view.backgroundColor = [[UIColor alloc] initWithRed:185./255. green:185./255. blue:185./255. alpha:1.0];
        UIButton *btnCancel=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnCancel setBackgroundImage:[UIImage imageNamed:@"button_service_cancel_press"] forState:UIControlStateHighlighted];
        btnCancel.frame=CGRectMake(60, 314, 200, 44);
        [btnCancel setTitle:@"取 消" forState:UIControlStateNormal];
        [btnCancel setTitle:@"取 消" forState:UIControlStateHighlighted];
        [btnCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [btnCancel addTarget:self action:@selector(btnPressToCancel:) forControlEvents:UIControlEventTouchUpInside];
        [_view addSubview:btnCancel];
		[self addSubview:_view];
        
        
    }
    return self;
}

-(void)btnPressToCancel:(UIButton *)button
{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

@end
