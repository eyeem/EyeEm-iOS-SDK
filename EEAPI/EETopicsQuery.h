//
//  EETopicsQuery.h
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEQuery.h"

@interface EETopicsQuery : EEQuery

@property (nonatomic, assign) NSString *autoComplete;

-(NSDictionary*) createDictionary;
@end
