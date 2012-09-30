//
//  AlfredReflecticleExtension.h
//  alfred_reflecticle_extension
//
//  Created by ADML on 2012-09-27.
//  Copyright (c) 2012 MH Solutions LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AlfredReflecticleExtension : NSObject <CLLocationManagerDelegate>

+ (AlfredReflecticleExtension *)sharedInstance;

- (void)run;

@end
