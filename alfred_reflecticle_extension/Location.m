//
//  Location.m
//  alfred_reflecticle_extension
//
//  Created by Tomer Elmalem on 7/18/12.
//  Copyright (c) 2012 MH Solutions LLC. All rights reserved.
//

#import "Location.h"

@implementation Location
- (void)start
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if (newLocation.coordinate.latitude != oldLocation.coordinate.latitude ||
        newLocation.coordinate.latitude != oldLocation.coordinate.longitude) {
        NSString *api_key = [Reflecticle api_key];
        Reflecticle *reflecticle = [[Reflecticle alloc] init];
        reflecticle._api_key = api_key;
        [reflecticle log:newLocation];
    }
    latestLocation = newLocation;
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    printf ( "ERROR: %s\n", [[error localizedDescription] UTF8String]);
    exit(1);
}

@end
