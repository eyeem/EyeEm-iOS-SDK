//
//  EEOAuthUser.h
//  EEAPI
//
//  Created by Sebastian Kießling on 19.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEUser.h"

@interface EEOAuthUser : EEUser

@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) BOOL emailNotifications;
@property (nonatomic, assign) BOOL pushNotifications;
@property (nonatomic, strong) NSDictionary *newsSettings;
@property (nonatomic, strong) NSDictionary *services;

-(void) setValue:(id)value forParameter:(NSString *)key;

@end
