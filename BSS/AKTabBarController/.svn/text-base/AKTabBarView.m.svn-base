// AKTabBarView.m
//


#import "AKTabBarView.h"

@implementation AKTabBarView

#pragma mark - Setters

- (void)setTabBar:(AKTabBar *)tabBar
{
    if (_tabBar != tabBar)
    {
        [_tabBar removeFromSuperview];
        _tabBar = tabBar;
        [self addSubview:tabBar];
    }
}


- (void)setContentView:(UIView *)contentView
{
    if (_contentView != contentView)
    {
        [_contentView removeFromSuperview];
        _contentView = contentView;
        _contentView.frame = CGRectZero;
        [self addSubview:_contentView];
        [self sendSubviewToBack:_contentView];
    }
}

#pragma mark - Layout & Drawing

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect tabBarRect = _tabBar.frame;
    tabBarRect.origin.y = CGRectGetHeight(self.bounds) - CGRectGetHeight(_tabBar.bounds);
    [_tabBar setFrame:tabBarRect];
    
    CGRect contentViewRect = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - ((!_isTabBarHidding) ? CGRectGetHeight(_tabBar.bounds) : 0));
    _contentView.frame = contentViewRect;
    [_contentView setNeedsLayout];
}




@end
