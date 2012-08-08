//
//  main.m
//  alfred_reflecticle_extension
//
//  Created by Jonathan Wallace on 7/7/12.
//  Copyright (c) 2012 MH Solutions LLC. All rights reserved.
//

#import "AlfredReflecticleExtension.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        [[AlfredReflecticleExtension sharedInstance] run];
    }
    
    return 0;
}