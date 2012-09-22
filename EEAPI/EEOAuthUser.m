//
//  EEOAuthUser.m
//  EEAPI
//
//  Created by Sebastian Kießling on 19.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEOAuthUser.h"

@implementation EEOAuthUser


-(void) setValue:(id)value forParameter:(NSString *)key
{
    [super setValue:value forParameter:key];
    if ([key isEqualToString: @"email"]) {
        self.email = (NSString*) value;
    } else if ([key isEqualToString: @"emailNotification"])
    {
        self.emailNotifications = (BOOL) value;

    } else if ([key isEqualToString: @"pushNotifications"])
    {
        self.pushNotifications = (BOOL) value;
        
    } else if ([key isEqualToString: @"newsSettings"])
    {
        self.newsSettings = (NSDictionary*) value;
        
    } else if ([key isEqualToString: @"services"])
    {
        self.services = (NSDictionary*) value;
        
    }
}
@end
