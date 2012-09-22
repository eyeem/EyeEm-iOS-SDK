//
//  EEPhoto.h
//  EEAPI
//
//  Created by Sebastian Kießling on 18.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class EEUser;
@interface EEPhoto : NSObject


@property (nonatomic, assign) NSInteger photoId;
@property (nonatomic, strong) NSURL *thumbUrl;
@property (nonatomic, strong) NSURL *photoUrl;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, strong) NSDate *updated;
@property (nonatomic, strong) NSURL *webUrl;
@property (nonatomic, strong) EEUser *user;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *caption;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) NSInteger totalLikes;
@property (nonatomic, assign) NSInteger totalComments;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSArray *likers;
@property (nonatomic, strong) NSArray *albums;
-(void) setValue:(id)value forParameter:(NSString *)key;

@end
