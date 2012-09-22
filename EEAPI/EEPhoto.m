//
//  EEPhoto.m
//  EEAPI
//
//  Created by Sebastian Kießling on 18.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEPhoto.h"
#import "EEUser.h"
#import "EEComment.h"
#import "EEAlbum.h"
@implementation EEPhoto


-(void) setValue:(id)value forParameter:(NSString *)key
{

    if ([key isEqualToString: @"id"]) {
        self.photoId = (NSInteger) value;
    } else if ([key isEqualToString: @"thumbUrl"] || [key isEqualToString: @"photoUrl"] || [key isEqualToString: @"webUrl"] )
    {
        NSURL *url = [NSURL URLWithString:(NSString*) value];
        if([key isEqualToString: @"thumbUrl"]){
            self.thumbUrl = url;
        } else if ( [key isEqualToString: @"photoUrl"]) {
            self.photoUrl = url;
        } else {
            self.webUrl = url;
        }
    }else if ([key isEqualToString: @"updated"])
    {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-DDTHH:mm:ss Z"];
        self.updated = [dateFormatter dateFromString:(NSString*) value];
        
    } else if([key isEqualToString: @"width"]){
        self.width = (NSInteger) value;
    } else if ([key isEqualToString: @"height"]){
        self.height = (NSInteger) value;
    } else if([key isEqualToString: @"title"]){
        self.title = (NSString*) value;
    } else if ([key isEqualToString: @"caption"]){
        self.caption = (NSString*) value;
    } else if([key isEqualToString: @"latitude"] || [key isEqualToString: @"longitude"]){
         CLLocationDegrees degree = [ value doubleValue];
        if ([key isEqualToString: @"latitude"]) {
            self.coordinate = CLLocationCoordinate2DMake(degree,self.coordinate.longitude);
        }else{
            self.coordinate = CLLocationCoordinate2DMake(self.coordinate.latitude,degree);
        }
    } else if([key isEqualToString: @"totalLikes"]){
        self.totalLikes = (NSInteger) value;
    } else if ([key isEqualToString: @"totalComments"]){
        self.totalComments = (NSInteger) value;
    } else if([key isEqualToString: @"comments"]){
        NSMutableArray *commentArray = [NSMutableArray array];
        for (NSDictionary *commentDictionary  in [(NSDictionary*)value objectForKey:@"items"]) {
            EEComment *comment = [[EEComment alloc] init];
            for (NSString *key in [commentDictionary keyEnumerator]) {
                [comment setValue:[commentDictionary valueForKey:key] forParameter:key];
            }
            [commentArray addObject:comment];
        }
        self.comments = commentArray;
    } else if([key isEqualToString: @"likers"]){
        NSMutableArray *likerArray = [NSMutableArray array];
        for (NSDictionary *likerDictionary  in [(NSDictionary*)value objectForKey:@"items"]) {
            EEUser *liker = [[EEUser alloc] init];
            for (NSString *key in [likerDictionary keyEnumerator]) {
                [liker setValue:[likerDictionary valueForKey:key] forParameter:key];
            }
            [likerArray addObject:liker];
        }
        self.comments = likerArray;
    } else if([key isEqualToString: @"albums"]){
        NSMutableArray *albumArray = [NSMutableArray array];
        for (NSDictionary *albumDictionary  in [(NSDictionary*)value objectForKey:@"items"]) {
            EEAlbum *album = [[EEAlbum alloc] init];
            for (NSString *key in [albumDictionary keyEnumerator]) {
                [album setValue:[albumDictionary valueForKey:key] forParameter:key];
            }
            [albumArray addObject:album];
        }
        self.comments = albumArray;
    }
}


@end
