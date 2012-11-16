//
//  AlfredReflecticleExtension.m
//  alfred_reflecticle_extension
//
//  Created by ADML on 2012-09-27.
//

#import "AlfredReflecticleExtension.h"
#import "ReflecticleClient.h"
#import "ReflecticleProject.h"
#import "ReflecticleActivity.h"

@interface AlfredReflecticleExtension() {
    ReflecticleActivity *_activity;
    CLLocationManager *_locationManager;
}
@end

@implementation AlfredReflecticleExtension

+ (AlfredReflecticleExtension *)sharedInstance {
    static AlfredReflecticleExtension *__sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[AlfredReflecticleExtension alloc] init];
    });
    
    return __sharedInstance;
}

- (void)run {
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    
    NSError *error = nil;
    NSArray *projects = [[ReflecticleClient sharedClient] projects:&error];
    if (projects) {
        _activity = [[ReflecticleActivity alloc] init];
        
        ReflecticleProject *project = [self findProjectByName:projects];
        _activity.projectId = [project identifier];
        _activity.description = [self descriptionFromCommandLine:project];
        
        // Attempt to grab the user's location
        if ([CLLocationManager locationServicesEnabled]) {
            [_locationManager stopUpdatingLocation];
            
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.distanceFilter = 5;
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
            [_locationManager startUpdatingLocation];
            [runLoop run];
        } else {
            NSLog(@"Logging activity without location: %@", _activity.description);
            [self logActivity];
        }
    } else {
        NSLog(@"Unable to retrieve list of projects: %@", error.description);
        exit(1);
    }
}

- (NSString *)descriptionFromCommandLine:(ReflecticleProject *)project {
    return [[self alfredQueryFromCommandLine] substringFromIndex:project.name.length + 1];
}

- (NSString *)alfredQueryFromCommandLine {
    return [[[NSProcessInfo processInfo] arguments] objectAtIndex:1];
}

- (ReflecticleProject *)findProjectByName:(NSArray *)projects {
    NSString *query = [self alfredQueryFromCommandLine];
    
    for (ReflecticleProject *project in projects) {
        if ([project.name caseInsensitiveCompare:[query substringToIndex:project.name.length]] == NSOrderedSame) {
            return project;
        }
    }
    
    return nil;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if (newLocation.coordinate.latitude  != oldLocation.coordinate.latitude &&
        newLocation.coordinate.longitude != oldLocation.coordinate.longitude) {
        NSLog(@"Found location as (%f, %f)", newLocation.coordinate.latitude, newLocation.coordinate.longitude);

        _activity.latitude = @(newLocation.coordinate.latitude);
        _activity.longitude = @(newLocation.coordinate.longitude);
        
        NSLog(@"Logging activity with location: %@", _activity.description);
        [self logActivity];
    } else {
        NSLog(@"Found location but was not new");
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error finding location: %@", error.description);
    
    [self logActivity];
}

- (void)logActivity {
    // Just log without location
    NSError *error = nil;
    if ([[ReflecticleClient sharedClient] log:_activity error:&error]) {
        NSLog(@"Activity logged successfully");
        exit(0);
    } else {
        NSLog(@"Error logging update: %@", error.description);
        exit(1);
    }
}

@end
