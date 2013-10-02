// UINavigationController+AKTabBarController.m
//


#import "UINavigationController+AKTabBarController.h"

@implementation UINavigationController (AKTabBarController)

- (NSString *)tabImageName
{
	return [[self.viewControllers objectAtIndex:0] tabImageName];
}

- (NSString *)tabTitle
{
	return [[self.viewControllers objectAtIndex:0] tabTitle];
}

@end
