//
//  EEUser.m
//  EEAPI
//
//  Created by Sebastian Kießling on 18.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEUser.h"

@implementation EEUser


-(void) setValue:(id)value forParameter:(NSString *)key
{
    
    if ([key isEqualToString: @"id"]) {
        self.userId = (NSInteger) value;
    } else if ([key isEqualToString: @"thumbUrl" ]|| [key isEqualToString: @"photoUrl"])
    {
        NSURL *url = [NSURL URLWithString:(NSString*) value];
        if([key isEqualToString: @"thumbUrl"]){
            self.thumbUrl = url;
        } else {
            self.photoUrl = url;
        } 
    } else if([key isEqualToString: @"description"]){
        self.description = (NSString*) value;
    } else if ([key isEqualToString: @"totalPhotos"]){
        self.totalPhotos = (NSInteger) value;
    } else if ([key isEqualToString: @"totalFollowers"]){
        self.totalFollowers = (NSInteger) value;
    }else if ([key isEqualToString: @"totalFriends"]){
        self.totalFriends = (NSInteger) value;
    }else if ([key isEqualToString: @"totalLikedAlbums"]){
        self.totalLikedAlbums = (NSInteger) value;
    }else if ([key isEqualToString: @"totalPhotos"]){
        self.totalPhotos = (NSInteger) value;
    }
}

@end
