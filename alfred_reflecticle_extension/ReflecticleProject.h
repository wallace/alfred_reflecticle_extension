//
//  ReflecticleProject.h
//  alfred_reflecticle_extension
//
//  Created by ADML on 2012-09-27.
//  Copyright (c) 2012 MH Solutions LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReflecticleProject : NSObject

- (id)initWithAttributes:(NSDictionary *)attributes;

@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *name;

@end
