//
//  NSString+URLEncoded.m
//  alfred_reflecticle_extension
//
//  Created by ADML on 2012-11-15.
//  Copyright (c) 2012 MH Solutions LLC. All rights reserved.
//

#import "NSString+UrlEncoded.h"

@implementation NSString (URLEncoded)

- (NSString *)urlEncoded {
    NSString *encodedString = CFBridgingRelease(
        CFURLCreateStringByAddingPercentEscapes(
            NULL,
            (__bridge CFStringRef) self,
            NULL,
            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
            kCFStringEncodingUTF8));

    return encodedString;
}

@end
