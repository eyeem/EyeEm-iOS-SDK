//
//  EEQuery.m
//  EEAPI
//
//  Created by Sebastian Kießling on 20.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEQuery.h"

@implementation EEQuery

- (id)init
{
    self = [super init];
    if (self) {
        self.firstId = -1;
        self.specificEndpoint = sNothing;
        self.longitude = 500.0f;
        self.latitude = 500.0f;
        self.coordinate = kCLLocationCoordinate2DInvalid;
        self.secondId = -1;
        self.limit = -1;
        self.offset = -1;
        self.minPhotos = -1;
        self.photoNumber = -1;
        self.commentNumber = -1;
        self.likerNumber = -1;
    }
    return self;
}

-(NSDictionary*) createDictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableString *endpoint = [NSMutableString string];
    switch (self.generalEndpoint) {
        case gUsers:
            [endpoint appendString:@"/users"];
            break;
        case gPhotos:
            [endpoint appendString:@"/photos"];
            break;
        case gAlbums:
            [endpoint appendString:@"/albums"];
            break;
        case gNews:
            [endpoint appendString:@"/news"];
            break;
        case gTopics:
            [endpoint appendString:@"/topics"];
            break;
        case gSearch:
            [endpoint appendString:@"/search"];
            break;
        case gVenues:
            [endpoint appendString:@"/venues"];
            break;
        default:
            break;
    }
    if (self.firstId >0 || self.firstStringId != nil) {
        if (self.firstStringId != nil) {
            [endpoint appendFormat:@"/%@",self.firstStringId];

        } else {
            [endpoint appendFormat:@"/%i",self.firstId];

        }
    }
    if (self.specificEndpoint != sNothing) {
        switch (self.specificEndpoint) {
            case sPhotos:
                [endpoint appendString:@"/photos"];
                break;
            case sLikedPhotos:
                [endpoint appendString:@"/likedPhotos"];
                break;
            case sFriendsPhotos:
                [endpoint appendString:@"/friendsPhotos"];
                break;
            case sLikedAlbums:
                [endpoint appendString:@"/likedAlbums"];
                break;
            case sFeed:
                [endpoint appendString:@"/feed"];
                break;
            case sDiscover:
                [endpoint appendString:@"/discover"];
                break;
            case sFriends:
                [endpoint appendString:@"/friends"];
                break;
            case sFollowers:
                [endpoint appendString:@"/followers"];
                break;
            case sTopics:
                [endpoint appendString:@"/topics"];
                break;
            case sSocialMedia:
                [endpoint appendString:@"/socialMedia"];
                break;
            case sNewsSettings:
                [endpoint appendString:@"/newsSettings"];
                break;
            case sShare:
                [endpoint appendString:@"/share"];
                break;
            case sHide:
                [endpoint appendString:@"/hide"];
                break;
            case sLikers:
                [endpoint appendString:@"/likers"];
                break;
            case sComments:
                [endpoint appendString:@"/comments"];
                break;
            case sAlbums:
                [endpoint appendString:@"/albums"];
                break;
            case sFlags:
                [endpoint appendString:@"/flags"];
                break;
            case sBgImages:
                [endpoint appendString:@"/bgImages"];
                break;
            case sRecommended:
                [endpoint appendString:@"/recommended"];
                break;
            case sContributors:
                [endpoint appendString:@"/contributors"];
                break;
            case sView:
                [endpoint appendString:@"/view"];
                break;
            case sFoursqareToken:
                [endpoint appendString:@"/foursquareToken"];
                break;
            default:
                break;
        }
    }
    if (self.secondId >0 || self.secondStringId != nil) {
        if (self.secondStringId != nil) {
            [endpoint appendFormat:@"/%@",self.secondStringId];
            
        } else {
            [endpoint appendFormat:@"/%i",self.secondId];
            
        }
    }
    [dictionary setValue:endpoint forKey:@"endpoint"];
    if (self.type !=nil) {
        [dictionary setValue:self.type forKey:@"type"];
    }
    if (self.ids !=nil) {
        [dictionary setValue:self.ids forKey:@"ids"];
    }
    if (self.q !=nil) {
        [dictionary setValue:self.q forKey:@"q"];
    }
    if (self.limit > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.limit ] forKey:@"limit"];
    }
    if (self.offset > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.offset] forKey:@"offset"];
    }
        [dictionary setValue:[NSNumber numberWithBool:self.onlyId ] forKey:@"onlyId"];
    
        [dictionary setValue:[NSNumber numberWithBool:self.detailed] forKey:@"detailed"];
    
        [dictionary setValue:[NSNumber numberWithBool:self.albums] forKey:@"includeAlbums"];
    
        [dictionary setValue:[NSNumber numberWithBool:self.trending] forKey:@"trending"];
    
    if (self.geoSearch !=nil) {
        [dictionary setValue:self.geoSearch forKey:@"geoSearch"];
    }
    if (self.foursquareId !=nil) {
        [dictionary setValue:self.foursquareId forKey:@"foursquareId"];
    }
    if (self.minPhotos > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.minPhotos] forKey:@"minPhotos"];
    }
    if (CLLocationCoordinate2DIsValid(self.coordinate))
    {

        [dictionary setValue:[NSNumber numberWithDouble:self.coordinate.latitude] forKey:@"latitude"];
        [dictionary setValue:[NSNumber numberWithDouble:self.coordinate.longitude] forKey:@"longitude"];

    }else if (self.latitude >= -90.0f && self.latitude <= 90.0f && self.longitude >= -180.0f && self.longitude <= 180.0f)
    {

        [dictionary setValue:[NSNumber numberWithDouble:self.longitude] forKey:@"lat"];
        [dictionary setValue:[NSNumber numberWithDouble:self.latitude] forKey:@"lng"];

    }
        [dictionary setValue:[NSNumber numberWithBool:self.photos] forKey:@"photos"];
    
    if (self.photoNumber > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.photoNumber] forKey:@"numPhotos"];
    }
        [dictionary setValue:[NSNumber numberWithBool:self.photoDetails] forKey:@"photoDetails"];

        [dictionary setValue:[NSNumber numberWithBool:self.contributors] forKey:@"includeContributors"];
    
        [dictionary setValue:[NSNumber numberWithBool:self.comments] forKey:@"includeComments"];
    
        [dictionary setValue:[NSNumber numberWithBool:self.likers] forKey:@"includeLikers"];
    
    if (self.commentNumber > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.commentNumber] forKey:@"numComments"];
    }
    if (self.likerNumber > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.likerNumber] forKey:@"numLikers"];
    }
        [dictionary setValue:[NSNumber numberWithBool:self.suggested] forKey:@"suggested"];
    

    if (self.closestVenueFsIds !=nil) {
        [dictionary setValue:self.closestVenueFsIds forKey:@"X-GEO-closestVenueFsIds"];
    }
    if (self.cityName !=nil) {
        [dictionary setValue:self.cityName forKey:@"X-GEO-cityName"];
    }
        [dictionary setValue:[NSNumber numberWithBool:self.aggregated] forKey:@"aggregated"];
    
        [dictionary setValue:[NSNumber numberWithBool:self.countUnseen] forKey:@"countUnseen"];
    
        [dictionary setValue:[NSNumber numberWithBool:self.users] forKey:@"users"];
    
    if (self.autoComplete !=nil) {
        [dictionary setValue:self.autoComplete forKey:@"autoComplete"];
    }
    return dictionary;
}
@end
