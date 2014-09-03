//
//  EEVenuesQuery.m
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEVenuesQuery.h"

@implementation EEVenuesQuery
- (id)init
{
    self = [super init];
    if (self) {
        self.specificEndpoint = EEspecificVenuesEndpointNothing;


        self.venueId = -1;
    }
    return self;
}


-(NSDictionary*) createDictionary
{
    self.generalEndpointString = @"/venues";
    if (self.specificEndpoint != EEspecificVenuesEndpointNothing) {
        switch (self.specificEndpoint) {
            
            case EEspecificVenuesEndpointFoursqareToken:
                self.specificEndpointString = @"/foursquareToken";
                break;
            default:
                break;
        }
    }
#ifdef DEBUG     
    else if(self.service == nil || self.venueId <= 0 || self.location == nil || self.name == nil)
    {

        NSAssert(NO, @"The parameters service, venueId, name and location are required!");
#endif
    }
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[super createDictionary]];
    
    if (self.service !=nil) {
        [dictionary setValue:self.service forKey:@"service"];
    }
    if (self.venueId > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.venueId] forKey:@"venueId"];
    }
    if (self.location !=nil) {
        [dictionary setValue:self.location forKey:@"location"];
    }
    
    return [NSDictionary dictionaryWithDictionary:dictionary];
}
@end
