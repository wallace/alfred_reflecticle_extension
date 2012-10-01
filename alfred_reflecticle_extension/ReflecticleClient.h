//
//  ReflecticleClient.h
//  alfred_reflecticle_extension
//
//  Created by ADML on 2012-09-27.
//

#import <Foundation/Foundation.h>
#import "ReflecticleActivity.h"
#import "ReflecticleProject.h"

@interface ReflecticleClient : NSObject

+ (ReflecticleClient *)sharedClient;

- (NSArray *)projects:(NSError **)error;
- (BOOL)log:(ReflecticleActivity *)activity error:(NSError **)error;

@end
