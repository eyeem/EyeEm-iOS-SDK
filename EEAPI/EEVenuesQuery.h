//
//  EEVenuesQuery.h
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEQuery.h"
enum {
    EEspecificVenuesEndpointFoursqareToken,
    EEspecificVenuesEndpointNothing
    
    
    
};
typedef NSInteger EESpecificVenuesEndpoint;

@interface EEVenuesQuery : EEQuery
@property (nonatomic, assign) EESpecificVenuesEndpoint specificEndpoint;
@property (nonatomic, strong) NSString *service;
@property (nonatomic, assign) NSInteger venueId;
@property (nonatomic, strong) NSArray *location;

-(NSDictionary*) createDictionary;
@end
