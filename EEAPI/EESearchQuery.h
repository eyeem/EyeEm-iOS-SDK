//
//  EESearchQuery.h
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEQuery.h"

@interface EESearchQuery : EEQuery

@property (nonatomic, assign) BOOL users;


@property (nonatomic, assign) BOOL usersFlag;
-(NSDictionary*) createDictionary;
@end
