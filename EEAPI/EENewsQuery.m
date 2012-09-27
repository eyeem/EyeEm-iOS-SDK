//
//  EENewsQuery.m
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EENewsQuery.h"

@implementation EENewsQuery
- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}


-(NSDictionary*) createDictionary
{
    self.generalEndpointString = @"/news";

    NSMutableDictionary *dictionary = [NSDictionary dictionaryWithDictionary:[super createDictionary]];
    if (self.aggregatedFlag ) {
        
        [dictionary setValue:[NSNumber numberWithBool:self.aggregated] forKey:@"aggregated"];
    }
    if (self.countUnseenFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.countUnseen] forKey:@"countUnseen"];
    }
    if (self.include_olderFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.include_older] forKey:@"include_older"];
    }
    if (self.markAsRead !=nil) {
        [dictionary setValue:self.markAsRead forKey:@"markAsRead"];
    }
    
    return [NSDictionary dictionaryWithDictionary:dictionary];
}


-(void) setAggregated:(BOOL)aggregated
{
    _aggregated = aggregated;
    self.aggregatedFlag = YES;
}


-(void) setCountUnseen:(BOOL)countUnseen
{
    _countUnseen = countUnseen;
    self.countUnseenFlag = YES;
}


-(void) setInclude_older:(BOOL)include_older
{
    _include_older = include_older;
    self.include_olderFlag = YES;
}
@end
