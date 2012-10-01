//
//  ReflecticleProject.m
//  alfred_reflecticle_extension
//
//  Created by ADML on 2012-09-27.
//

#import "ReflecticleProject.h"

@implementation ReflecticleProject

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        _identifier = [attributes objectForKey:@"id"];
        _name = [attributes objectForKey:@"name"];
    }
    
    return self;
}

@end
