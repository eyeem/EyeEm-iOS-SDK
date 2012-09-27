//
//  EESearchQuery.m
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EESearchQuery.h"

@implementation EESearchQuery
- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}


-(NSDictionary*) createDictionary
{
    self.generalEndpointString = @"/search";
#ifdef DEBUG
    if (self.q == nil)
    {
        NSAssert(NO, @"The parameter q is required!");
    }
#endif
    NSMutableDictionary *dictionary = [NSDictionary dictionaryWithDictionary:[super createDictionary]];
    if (self.usersFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.users] forKey:@"users"];
    }
    
    
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

-(void) setUsers:(BOOL)users
{
    _users = users;
    self.usersFlag = YES;
}
@end
