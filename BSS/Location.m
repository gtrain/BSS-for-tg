//
//  Location.m
//  BSS
//
//  Created by zhangbo on 13-9-23.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "Location.h"
#import "AppDelegate.h"
#import "Alert.h"

@implementation Location

-(id)init
{
    self=[super init];
    if(self)
    {
        _locationManager=[[CLLocationManager alloc] init];
        
    }
    return self;
}

-(void)start
{
    if(_locationManager)
    {
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyThreeKilometers;
        _locationManager.distanceFilter=1000.0f;
        [_locationManager startUpdatingLocation];
        
        
    }
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    CLGeocoder *geocoder=[[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if(placemarks.count>0)
        {
            CLPlacemark *placemark=[placemarks objectAtIndex:0];
            AppDelegateShare.strCity=placemark.locality;
        }
        [_locationManager stopUpdatingLocation];
    }];
}





@end
