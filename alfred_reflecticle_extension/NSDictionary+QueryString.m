//
//  NSDictionary+QueryString.m
//  alfred_reflecticle_extension
//
//  Created by ADML on 2012-09-27.
//

#import "NSDictionary+QueryString.h"
#import "NSString+UrlEncoded.h"

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
        
        [parts addObject:[NSString stringWithFormat:@"%@=%@",
                          [key urlEncoded],
                          [stringValue urlEncoded]]];
    }
    
    return [parts componentsJoinedByString:@"&"];
}

@end