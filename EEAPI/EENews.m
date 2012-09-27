//
//  EENews.m
//  EEAPI
//
//  Created by Sebastian Kießling on 20.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EENews.h"
#import "EEPhoto.h"
#import "EEUser.h"
#import "EEComment.h"
#import "EEAlbum.h"

@implementation EENews

-(void) setValue:(id)value forParameter:(NSString *)key
{

    if ([key isEqualToString: @"id"]) {
        self.newsId = [value integerValue];
    } else if ([key isEqualToString: @"thumbUrl"] ||  [key isEqualToString: @"url"] )
    {
        NSURL *url = [NSURL URLWithString:(NSString*) value];
        if([key isEqualToString: @"thumbUrl"]){
            self.thumbUrl = url;
        } else if ( [key isEqualToString: @"url"]) {
            self.url = url;
        } 
    }else if ([key isEqualToString: @"updated"])
    {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-DDTHH:mm:ss Z"];
        self.updated = [dateFormatter dateFromString:(NSString*) value];
        
    } else if([key isEqualToString: @"itemType"]){
        self.itemType = (NSString*) value;
    } else if([key isEqualToString: @"newsType"]){
        self.newsType = (NSString*) value;
    } else if([key isEqualToString: @"seen"]){
        self.seen =  [value boolValue];
    } else if([key isEqualToString: @"title"]){
        self.title = (NSString*) value;
    } else if([key isEqualToString: @"body"]){
        self.body = (NSString*) value;
    } else if([key isEqualToString: @"user" ]){
        EEUser *user = [[EEUser alloc]init];
        NSDictionary *userDictionary = (NSDictionary*)value;
        for (NSString *key  in [userDictionary keyEnumerator]) {
            [user setValue:[userDictionary valueForKey:key] forParameter:key];
            
        }
        self.user = user;
        
    } else if([key isEqualToString: @"album" ]){
        EEAlbum *album = [[EEAlbum alloc]init];
        NSDictionary *albumDictionary = (NSDictionary*)value;
        for (NSString *key  in [albumDictionary keyEnumerator]) {
            [album setValue:[albumDictionary valueForKey:key] forParameter:key];
            
        }
        self.album = album;
        
    } else if([key isEqualToString: @"photo" ]){
        EEPhoto *photo = [[EEPhoto alloc]init];
        NSDictionary *photoDictionary = (NSDictionary*)value;
        for (NSString *key  in [photoDictionary keyEnumerator]) {
            [photo setValue:[photoDictionary valueForKey:key] forParameter:key];
            
        }
        self.photo = photo;
        
    } else if([key isEqualToString: @"comment" ]){
        EEComment *comment = [[EEComment alloc]init];
        NSDictionary *commentDictionary = (NSDictionary*)value;
        for (NSString *key  in [commentDictionary keyEnumerator]) {
            [comment setValue:[commentDictionary valueForKey:key] forParameter:key];
            
        }
        self.comment = comment;
        
    }
    
}

@end
