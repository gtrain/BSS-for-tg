//
//  Location.h
//  BSS
//
//  Created by zhangbo on 13-9-23.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}

-(void)start;

@end
