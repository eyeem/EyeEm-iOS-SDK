//
//  EEAlbum.m
//  EEAPI
//
//  Created by Sebastian Kießling on 18.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEAlbum.h"
#import "EELocation.h"
#import "EEPhoto.h"
#import "EEUser.h"

@implementation EEAlbum


-(void) setValue:(id)value forParameter:(NSString *)key
{
    
    if ([key isEqualToString: @"id"]) {
        self.albumId = (NSInteger) value;
    } else if ([key isEqualToString: @"thumbUrl"] || [key isEqualToString: @"webUrl" ])
    {
        NSURL *url = [NSURL URLWithString:(NSString*) value];
        if([key isEqualToString: @"thumbUrl"]){
            self.thumbUrl = url;
        } else {
            self.webUrl = url;
        }
    }else if ([key isEqualToString: @"updated"])
    {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-DDTHH:mm:ss Z"];
        self.updated = [dateFormatter dateFromString:(NSString*) value];
        
    } else if([key isEqualToString: @"name"]){
        self.name = (NSString*) value;
    } else if([key isEqualToString: @"type"]){
        self.type = (NSString*) value;
    } else if ([key isEqualToString: @"totalPhotos"]){
        self.totalPhotos = (NSInteger) value;
    } else if([key isEqualToString: @"totalLikers"]){
        self.totalLikers = (NSInteger) value;
    } else if ([key isEqualToString: @"totalContributors"]){
        self.totalContributors = (NSInteger) value;
    } else if ([key isEqualToString: @"hidden"]){
        self.hidden = (BOOL) value;
        
        
        
        
    } else if([key isEqualToString: @"location"] ){
        EELocation *location = [[EELocation alloc]init];
        NSDictionary *locationDictionary = (NSDictionary*)value;
        for (NSString *key  in [locationDictionary keyEnumerator]) {
            [location setValue:[locationDictionary valueForKey:key] forParameter:key];

        }
        self.location = location;
        
    } else if([key isEqualToString: @"photos"]){
        NSMutableArray *photoArray = [NSMutableArray array];
        for (NSDictionary *photoDictionary  in [(NSDictionary*)value objectForKey:@"items"]) {
            EEPhoto *photo = [[EEPhoto alloc] init];
            for (NSString *key in [photoDictionary keyEnumerator]) {
                [photo setValue:[photoDictionary valueForKey:key] forParameter:key];
            }
            [photoArray addObject:photo];
        }
        self.photos = photoArray;
        
        
    } else if([key isEqualToString: @"contributors"]){
        NSDictionary *contributors = (NSDictionary*)value;
        NSArray *keys = [NSArray arrayWithObjects:@"offset",@"limit",@"total", nil ];
        self.contributorsInfo = [NSDictionary dictionaryWithObjects:[contributors objectsForKeys:keys notFoundMarker:nil] forKeys:keys];
        
        
        NSMutableArray *contributorsArray = [NSMutableArray array];
        for (NSDictionary *contributorsDictionary  in [(NSDictionary*)value objectForKey:@"items"]) {
            EEUser *user = [[EEUser alloc] init];
            for (NSString *key in [contributorsDictionary keyEnumerator]) {
                [user setValue:[contributorsDictionary valueForKey:key] forParameter:key];
            }
            [contributorsArray addObject:user];
        }
        self.contributors = contributorsArray;

        
    } else if([key isEqualToString: @"likers"]){
        NSDictionary *contributors = (NSDictionary*)value;
        NSArray *keys = [NSArray arrayWithObjects:@"offset",@"limit",@"total", nil ];
        self.contributorsInfo = [NSDictionary dictionaryWithObjects:[contributors objectsForKeys:keys notFoundMarker:nil] forKeys:keys];
        
        
        NSMutableArray *likersArray = [NSMutableArray array];
        for (NSDictionary *likersDictionary  in [(NSDictionary*)value objectForKey:@"items"]) {
            EEUser *user = [[EEUser alloc] init];
            for (NSString *key in [likersDictionary keyEnumerator]) {
                [user setValue:[likersDictionary valueForKey:key] forParameter:key];
            }
            [likersArray addObject:user];
        }
        self.likers = likersArray;
    }
}
@end
