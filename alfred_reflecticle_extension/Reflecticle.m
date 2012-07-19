//
//  ReflecticleResponse.m
//  alfred_reflecticle_extension
//
//  Created by Jonathan Wallace on 6/27/12.
//  Copyright (c) 2012 MH Solutions LLC. All rights reserved.
//

#import "Reflecticle.h"
#import "Location.h"

@implementation Reflecticle

@synthesize _api_key;
@synthesize _projects;

// Reads the reflecticle api_key from ~/.reflecticle file.
+ (NSString *)api_key {
    NSString *api_path = [NSHomeDirectory() stringByAppendingPathComponent:@".reflecticle"];
    NSError *error;
    NSString *contents = [NSString stringWithContentsOfFile:api_path encoding:NSUTF8StringEncoding error:&error];
    
    if (nil == contents)
        NSLog(@"Error reading file at %@\n%@", api_path, [error localizedFailureReason]);
    
    NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    NSString *api_key = [lines objectAtIndex:0];
    
    return api_key;
}


// Returns the executed string without the program name
// E.g.
// "/Users/.../alfred_reflecticle_extension Highgroove what an update"
// becomes
// "Highgroove what an update"
+ (NSString *)parse_command_line {
    // Remove executable from command line arguments
    NSArray *command_line_arguments = [[NSProcessInfo processInfo] arguments];
    NSMutableArray *arguments = [NSMutableArray arrayWithArray:command_line_arguments];
    [arguments removeObjectAtIndex:0];

    NSString *result = [[arguments valueForKey:@"description"] componentsJoinedByString:@" "];
    return result;
}

// Makes JSON resquest for projects of the current api_key and stores them in the _projects property.
- (void)projects {
    NSError *error = nil;
    NSString *projects_uri = [NSString stringWithFormat:@"https://www.reflecticle.com/api/projects.json?api_key=%@", _api_key];
    
    NSData* data      = [NSData dataWithContentsOfURL: [NSURL URLWithString: projects_uri]];
    _projects = [NSJSONSerialization JSONObjectWithData:data
                                               options:NSJSONReadingMutableLeaves
                                                 error:&error];
}

- (void)log:(CLLocation *)location {
    NSString *update_message = [Reflecticle parse_command_line];
        
    // Get project names via JSON query
    [self projects];
    
    for (id project in _projects) {
        NSString *project_name = [project objectForKey:@"name"];
        
        // Loop through regexes of project name
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:project_name options:NSRegularExpressionCaseInsensitive error:NULL];
        
        NSTextCheckingResult *match = [regex firstMatchInString:update_message
                                          options:NSRegularExpressionCaseInsensitive
                                            range:NSMakeRange(0, [update_message length])];
        
        if (match.range.length != 0) {
            // remove regex from string to get the message
            NSString *modifiedString = [regex stringByReplacingMatchesInString:update_message
                                                                       options:NSRegularExpressionCaseInsensitive 
                                                                         range:NSMakeRange(0, match.range.length) withTemplate:@""];
            
            // remove leading and trailing spaces
            NSString *message = [modifiedString stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            id project_id = [project objectForKey:@"id"];
            
            // send JSON post
            // NSLog(@"project name: %@\n", project_name);
            // NSLog(@"project id: %@\n", project_id);
            // NSLog(@"message: '%@'\n", message);
            
            // URL encode message
            NSString *escapedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                   (__bridge CFStringRef)message, NULL,
                                                                                                   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                   kCFStringEncodingUTF8);
            
            // Build the GET request URI
            NSString *message_uri = [NSString stringWithFormat:@"https://www.reflecticle.com/api/activities/create.json?api_key=%@&project_id=%@&description=%@&latitude=%f&longitude=%f&location_accuracy=%f", _api_key, project_id, escapedString, location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy];
            
            NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:message_uri]
                                                      cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                  timeoutInterval:60.0];
            NSURLResponse* response = nil;
            [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:nil];
        }
    }
    
    // Needed unless you want to DoS Reflecticle
    exit(0);
}

@end
