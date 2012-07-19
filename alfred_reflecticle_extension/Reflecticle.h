//
//  ReflecticleResponse.h
//  alfred_reflecticle_extension
//
//  Created by Jonathan Wallace on 6/27/12.
//  Copyright (c) 2012 MH Solutions LLC. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface Reflecticle : NSObject

@property NSString *_api_key;
@property NSArray *_projects;

- (void)log:(CLLocation *)location;
- (void)projects;
+ (NSString *)parse_command_line;
+ (NSString *)api_key;

@end
