//
//  NSDictionary+QueryString.m
//  alfred_reflecticle_extension
//
//  Created by ADML on 2012-09-27.
//  Copyright (c) 2012 MH Solutions LLC. All rights reserved.
//

#import "NSDictionary+QueryString.h"

@implementation NSDictionary (QueryString)

- (NSString *)queryString {
    NSMutableArray *parts = [NSMutableArray arrayWithCapacity:self.count];
    for (NSString *key in self) {
        id value = [self objectForKey:key];
        
        NSString *stringValue;
        if ([value respondsToSelector:@selector(stringValue)]) {
            stringValue = [value stringValue];
        } else {
            stringValue = value;
        }
        
        [parts addObject:[NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [stringValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    
    return [parts componentsJoinedByString:@"&"];
}

@end
