//
//  EEPhotosQuery.h
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEQuery.h"
typedef NS_ENUM(NSUInteger, EESpecificPhotosEndpoint) {
    EEspecificPhotosEndpointDiscover,
    EEspecificPhotosEndpointTopics,
    EEspecificPhotosEndpointShare,
    EEspecificPhotosEndpointHide,
    EEspecificPhotosEndpointLikers,
    EEspecificPhotosEndpointComments,
    EEspecificPhotosEndpointAlbums,
    EEspecificPhotosEndpointFlags,
    EEspecificPhotosEndpointBgImages,
    EEspecificPhotosEndpointNothing
};

@interface EEPhotosQuery : EEQuery
@property (nonatomic, assign) EESpecificPhotosEndpoint specificEndpoint;
@property (nonatomic, assign) BOOL comments;
@property (nonatomic, assign) BOOL likers;

@property (nonatomic, assign) NSInteger commentNumber;
@property (nonatomic, assign) NSInteger likerNumber;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *offense;

@property (nonatomic, assign) BOOL hide;



@property (nonatomic, assign) BOOL commentsFlag;
@property (nonatomic, assign) BOOL likersFlag;
@property (nonatomic, assign) BOOL hideFlag;
-(NSDictionary*) createDictionary;
@end
