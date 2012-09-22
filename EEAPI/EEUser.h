//
//  EEUser.h
//  EEAPI
//
//  Created by Sebastian Kießling on 18.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEUser : NSObject

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *fullname;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, strong) NSURL *thumbUrl;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, strong) NSURL *photoUrl;
@property (nonatomic, assign) NSInteger totalPhotos;
@property (nonatomic, assign) NSInteger totalFollowers;
@property (nonatomic, assign) NSInteger totalFriends;
@property (nonatomic, assign) NSInteger totalLikedAlbums;

-(void) setValue:(id)value forParameter:(NSString *)key;

@end
