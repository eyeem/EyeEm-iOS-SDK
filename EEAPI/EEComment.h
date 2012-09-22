//
//  EEComment.h
//  EEAPI
//
//  Created by Sebastian Kießling on 19.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EEUser;

@interface EEComment : NSObject


@property (nonatomic, assign) NSInteger commentId;
@property (nonatomic, assign) NSInteger photoId;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *extendedMessage;
@property (nonatomic, strong) EEUser *user;
@property (nonatomic, strong) NSArray *mentionedUsers;
@property (nonatomic, strong) NSDate *updated;

-(void) setValue:(id)value forParameter:(NSString *)key;
@end
