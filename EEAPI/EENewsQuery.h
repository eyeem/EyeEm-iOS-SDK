//
//  EENewsQuery.h
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEQuery.h"

@interface EENewsQuery : EEQuery

@property (nonatomic, assign) BOOL aggregated;
@property (nonatomic, assign) BOOL countUnseen;
@property (nonatomic, assign) BOOL include_older;
@property (nonatomic, assign) NSString *markAsRead;




@property (nonatomic, assign) BOOL aggregatedFlag;
@property (nonatomic, assign) BOOL countUnseenFlag;
@property (nonatomic, assign) BOOL include_olderFlag;
-(NSDictionary*) createDictionary;
@end
