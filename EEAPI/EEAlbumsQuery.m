//
//  EEAlbumsQuery.m
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEAlbumsQuery.h"

@implementation EEAlbumsQuery
- (id)init
{
    self = [super init];
    if (self) {
        
        self.longitude = 500.0f;
        self.latitude = 500.0f;
        self.coordinate = kCLLocationCoordinate2DInvalid;
        self.specificEndpoint = EEspecificAlbumsEndpointNothing;

        self.minPhotos = -1;
        self.photoNumber = -1;
    }
    return self;
}


-(NSDictionary*) createDictionary
{
    self.generalEndpointString = @"/albums";
    if (self.specificEndpoint != EEspecificAlbumsEndpointNothing) {
        switch (self.specificEndpoint) {
            case EEspecificAlbumsEndpointPhotos:
                self.specificEndpointString = @"/photos";
                break;


            case EEspecificAlbumsEndpointShare:
                self.specificEndpointString = @"/share";
            #ifdef DEBUG 
                if (self.services == nil)
                {
                    NSAssert(NO, @"The parameter services is required!");

                }
            #endif
                break;
            case EEspecificAlbumsEndpointHide:
                self.specificEndpointString = @"/hide";
                break;
            case EEspecificAlbumsEndpointLikers:
                self.specificEndpointString = @"/likers";
                break;
            case EEspecificAlbumsEndpointRecommended:
                self.specificEndpointString = @"/recommended";
                break;
            case EEspecificAlbumsEndpointContributors:
                self.specificEndpointString = @"/contributors";
                break;
            case EEspecificAlbumsEndpointView:
                self.specificEndpointString = @"/view";
                break;

            default:
                break;
        }
    }
#ifdef DEBUG 
    else if (self.ids == nil && self.q == nil && self.trending == NO && self.geoSearch == nil && self.firstId < 0)
    {
        NSAssert(NO, @"One of the following parameters is required: ids, q,  trending, geoSearch!");
    }
#endif
    NSMutableDictionary *dictionary = [NSDictionary dictionaryWithDictionary:[super createDictionary]];
    
    if (self.trendingFlag) {
        
        [dictionary setValue:[NSNumber numberWithBool:self.trending] forKey:@"trending"];
    }
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
    if (self.photosFlag) {
        
        [dictionary setValue:[NSNumber numberWithBool:self.photos] forKey:@"photos"];
    }
    if (self.photoNumber > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.photoNumber] forKey:@"numPhotos"];
    }
    if (self.photoDetailsFlag ) {
        
        [dictionary setValue:[NSNumber numberWithBool:self.photoDetails] forKey:@"photoDetails"];
    }
    if (self.contributorsFlag ) {
        
        [dictionary setValue:[NSNumber numberWithBool:self.contributors] forKey:@"includeContributors"];
    }
    
    
    return [NSDictionary dictionaryWithDictionary:dictionary];
}
-(void) setTrending:(BOOL)trending
{
    _trending = trending;
    self.trendingFlag =YES;
    
}

-(void) setPhotos:(BOOL)photos
{
    _photos = photos;
    self.photosFlag =YES;
    
}
-(void) setPhotoDetails:(BOOL)photoDetails
{
    _photoDetails = photoDetails;
    self.photoDetailsFlag =YES;
    
}
-(void) setContributors:(BOOL)contributors
{
    _contributors = contributors;
    self.contributorsFlag =YES;
    
}
@end
