// AKTab.h
//


#import <QuartzCore/QuartzCore.h>

@interface AKTab : UIButton

// Image used to draw the icon.
@property (nonatomic, strong) NSString *tabImageWithName;

// Tab background image
@property (nonatomic, strong) NSString *backgroundImageName;

// Tab selected background image
@property (nonatomic, strong) NSString *selectedBackgroundImageName;

// Tab text color
@property (nonatomic, strong) UIColor *textColor;

// Tab selected text color
@property (nonatomic, strong) UIColor *selectedTextColor;

// Tabs title.
@property (nonatomic, strong) NSString *tabTitle;

// Tabs icon colors.
@property (nonatomic, strong) NSArray *tabIconColors;

// Tabs selected icon colors.
@property (nonatomic, strong) NSArray *tabIconColorsSelected;

// Tabs selected colors.
@property (nonatomic, strong) NSArray *tabSelectedColors;

// Tabs icon glossy show / hide
@property (nonatomic, assign) BOOL glossyIsHidden;

// Tab stroke Color
@property (nonatomic, strong) UIColor *strokeColor;

// Tab top embos Color
@property (nonatomic, strong) UIColor *edgeColor;

// Height of the tab bar.
@property (nonatomic, assign) CGFloat tabBarHeight;

// Minimum height that permits the display of the tab's title.
@property (nonatomic, assign) CGFloat minimumHeightToDisplayTitle;

// Used to show / hide title.
@property (nonatomic, assign) BOOL titleIsHidden;

@end
