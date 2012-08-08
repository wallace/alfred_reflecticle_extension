//
//  ReflecticleClient.m
//  alfred_reflecticle_extension
//
//  Created by ADML on 2012-09-27.
//  Copyright (c) 2012 MH Solutions LLC. All rights reserved.
//

#import "ReflecticleClient.h"
#import "NSDictionary+QueryString.h"

@interface ReflecticleClient () {
    NSString *_apiKey;
}
@end

@implementation ReflecticleClient

+ (ReflecticleClient *)sharedClient {
    static ReflecticleClient *__sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedClient = [[ReflecticleClient alloc] init];
    });
    
    return __sharedClient;
}

- (id)init {
    self = [super init];
    if (self) {
        _apiKey = [self apiKeyFromDotFile];
    }
    
    return self;
}

- (NSString *)apiKeyFromDotFile {
    NSString *api_path = [NSHomeDirectory() stringByAppendingPathComponent:@".reflecticle"];
    
    NSError *error;
    NSString *contents = [NSString stringWithContentsOfFile:api_path encoding:NSUTF8StringEncoding error:&error];
    if (nil == contents) {
        NSLog(@"Error reading file at %@\n%@", api_path, [error localizedFailureReason]);
    }
    
    NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    return [lines objectAtIndex:0];
}

- (NSArray *)projects:(NSError **)error {
    NSMutableArray *projects = nil;
    
    NSData *data = [NSData dataWithContentsOfURL:[self reflecticleUrl:@"/api/projects.json" parameters:@{ }] options:0 error:error];
    if (data) {
        NSArray *projectArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
        if (projectArray) {
            projects = [NSMutableArray arrayWithCapacity:projectArray.count];
            for (NSDictionary *projectAttributes in projectArray) {
                [projects addObject:[[ReflecticleProject alloc] initWithAttributes:projectAttributes]];
            }
        }
    }
    
    return projects;
}

- (BOOL)log:(ReflecticleActivity *)activity error:(NSError **)error {
    NSDictionary *params = @{
        @"project_id" : activity.projectId,
        @"description" : activity.description,
        @"latitude" : activity.latitude,
        @"longitude" : activity.longitude
    };
    
    NSData *data = [NSData dataWithContentsOfURL:[self reflecticleUrl:@"/api/activities/create.json" parameters:params] options:0 error:error];
    if (data) {
        return YES;
    } else {
        return NO;
    }
}

- (NSURL *)reflecticleUrl:(NSString *)path parameters:(NSDictionary *)parameters {
    NSMutableDictionary *parametersWithApiKey = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parametersWithApiKey setObject:_apiKey forKey:@"api_key"];
        
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://www.reflecticle.com%@?%@", path, [parametersWithApiKey queryString]]];
}

@end
