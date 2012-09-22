//
//  EEAlbum.h
//  EEAPI
//
//  Created by Sebastian Kießling on 18.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EELocation;

@interface EEAlbum : NSObject

@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSURL *thumbUrl;
@property (nonatomic, strong) NSDate *updated;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) EELocation *location;
@property (nonatomic, strong) NSURL *webUrl;
@property (nonatomic, assign) NSInteger totalPhotos;
@property (nonatomic, assign) NSInteger totalLikers;
@property (nonatomic, assign) NSInteger totalContributors;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSArray *contributors;
@property (nonatomic, strong) NSDictionary *contributorsInfo;
@property (nonatomic, strong) NSArray *likers;
@property (nonatomic, strong) NSDictionary *likersInfo;

-(void) setValue:(id)value forParameter:(NSString *)key;



@end
