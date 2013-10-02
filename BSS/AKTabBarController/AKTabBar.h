// AKTabBar.h
//


#import "AKTab.h"

@class AKTabBar;

@protocol AKTabBarDelegate <NSObject>

@required

// Used by the TabBarController to be notified when a tab is pressed
- (void)tabBar:(AKTabBar *)AKTabBarDelegate didSelectTabAtIndex:(NSInteger)index;

@end

@interface AKTabBar : UIView

@property (nonatomic, strong) NSArray *tabs;
@property (nonatomic, strong) AKTab *selectedTab;
@property (nonatomic, assign) id <AKTabBarDelegate> delegate;

// Tab top embos Color
@property (nonatomic, strong) UIColor *edgeColor;

// Tabs selected colors.
@property (nonatomic, strong) NSArray *tabColors;

// Tab background image
@property (nonatomic, strong) NSString *backgroundImageName;

- (void)tabSelected:(AKTab *)sender;

@end
