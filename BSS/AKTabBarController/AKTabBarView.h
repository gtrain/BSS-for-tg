// AKTabBarView.h
//


#import "AKTabBar.h"

@interface AKTabBarView : UIView

@property (nonatomic, strong) AKTabBar *tabBar;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) BOOL isTabBarHidding;
@end
