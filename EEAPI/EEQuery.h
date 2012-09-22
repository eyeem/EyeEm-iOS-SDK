//
//  EEQuery.h
//  EEAPI
//
//  Created by Sebastian Kießling on 20.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

enum {
    gUsers,
    gPhotos,
    gAlbums,
    gNews,
    gTopics,
    gSearch,
    gVenues
};
typedef NSInteger EEGeneralEndpoint;

enum {

    sPhotos,
    sLikedPhotos,
    sFriendsPhotos,
    sLikedAlbums,
    sFeed,
    sDiscover,
    sFriends,
    sFollowers,
    sTopics,
    sSocialMedia,
    sNewsSettings,
    sShare,
    sHide,
    sLikers,
    sComments,
    sAlbums,
    sFlags,
    sBgImages,
    sRecommended,
    sContributors,
    sView,
    sFoursqareToken,
    sNothing
    
};
typedef NSInteger EESpecificEndpoint;

@interface EEQuery : NSObject


@property (nonatomic, assign) EEGeneralEndpoint generalEndpoint;
@property (nonatomic, assign) NSInteger firstId;
@property (nonatomic, assign) EESpecificEndpoint specificEndpoint; // e.g. likers, comments, albums...
@property (nonatomic, assign) NSInteger secondId;

@property (nonatomic, strong) NSString *firstStringId;
@property (nonatomic, strong) NSString *secondStringId;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *ids;
@property (nonatomic, strong) NSString *q;

@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) BOOL onlyId;
@property (nonatomic, assign) BOOL detailed;
@property (nonatomic, assign) BOOL albums;


#pragma mark Albums
@property (nonatomic, assign) BOOL trending;
@property (nonatomic, strong) NSString *geoSearch;
@property (nonatomic, strong) NSString *foursquareId;
@property (nonatomic, assign) NSInteger minPhotos;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

@property (nonatomic, assign) BOOL photos;
@property (nonatomic, assign) NSInteger photoNumber;


@property (nonatomic, assign) BOOL photoDetails;
@property (nonatomic, assign) BOOL contributors;


#pragma mark Photos
@property (nonatomic, assign) BOOL comments;
@property (nonatomic, assign) BOOL likers;

@property (nonatomic, assign) NSInteger commentNumber;
@property (nonatomic, assign) NSInteger likerNumber;

#pragma mark Users

@property (nonatomic, assign) BOOL suggested;
@property (nonatomic, strong) NSString *closestVenueFsIds;
@property (nonatomic, strong) NSString *cityName;


#pragma mark News
@property (nonatomic, assign) BOOL aggregated;
@property (nonatomic, assign) BOOL countUnseen;

#pragma mark Search

@property (nonatomic, assign) BOOL users;


#pragma mark Topics

@property (nonatomic, assign) NSString *autoComplete;


-(NSDictionary*) createDictionary;
@end
