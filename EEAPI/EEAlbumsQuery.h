//
//  EEAlbumsQuery.h
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEQuery.h"
typedef NS_ENUM(NSUInteger, EESpecificAlbumsEndpoint) {
    EEspecificAlbumsEndpointPhotos,

    EEspecificAlbumsEndpointShare,
    EEspecificAlbumsEndpointHide,
    EEspecificAlbumsEndpointLikers,

    EEspecificAlbumsEndpointRecommended,
    EEspecificAlbumsEndpointContributors,
    EEspecificAlbumsEndpointView,

    EEspecificAlbumsEndpointNothing
};

@interface EEAlbumsQuery : EEQuery

@property (nonatomic, assign) EESpecificAlbumsEndpoint specificEndpoint;

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



@property (nonatomic, assign) BOOL trendingFlag;
@property (nonatomic, assign) BOOL photosFlag;
@property (nonatomic, assign) BOOL photoDetailsFlag;
@property (nonatomic, assign) BOOL contributorsFlag;
-(NSDictionary*) createDictionary;
@end
