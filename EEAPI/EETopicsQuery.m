//
//  EETopicsQuery.m
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EETopicsQuery.h"

@implementation EETopicsQuery
- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}


-(NSDictionary*) createDictionary
{
    self.generalEndpointString = @"/topics";
#ifdef DEBUG 
    if (self.autoComplete == nil) {
        NSAssert(NO, @"The parameter autoComplete is required!");

    }
#endif

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[super createDictionary]];
    
    if (self.autoComplete !=nil) {
        [dictionary setValue:self.autoComplete forKey:@"autoComplete"];
    }
    
    
    return [NSDictionary dictionaryWithDictionary:dictionary];
}
@end
