//
//  Location.h
//  alfred_reflecticle_extension
//
//  Created by Tomer Elmalem on 7/18/12.
//  Copyright (c) 2012 MH Solutions LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Cocoa/Cocoa.h>
#import "Reflecticle.h"

@interface Location : NSObject <NSApplicationDelegate, CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *latestLocation;
}

-(void)start;
-(CLLocation *)getLocation;
@end
