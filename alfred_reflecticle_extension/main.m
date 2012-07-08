//
//  main.m
//  alfred_reflecticle_extension
//
//  Created by Jonathan Wallace on 7/7/12.
//  Copyright (c) 2012 MH Solutions LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reflecticle.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *api_key = [Reflecticle api_key];
        Reflecticle *reflecticle = [[Reflecticle alloc] init];
        reflecticle._api_key = api_key;
        [reflecticle log];
    }
    return 0;
}

