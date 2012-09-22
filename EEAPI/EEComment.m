//
//  EEComment.m
//  EEAPI
//
//  Created by Sebastian Kießling on 19.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEComment.h"
#import "EEUser.h"

@implementation EEComment



-(void) setValue:(id)value forParameter:(NSString *)key
{
    
    if ([key isEqualToString: @"id"]) {
        self.commentId = (NSInteger) value;
    } else if([key isEqualToString: @"photoId"]){
        self.photoId = (NSInteger) value;
    }else if ([key isEqualToString: @"updated"])
    {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-DDTHH:mm:ss Z"];
        self.updated = [dateFormatter dateFromString:(NSString*) value];
        
        
        
    } else if([key isEqualToString: @"message"]){
        self.message = (NSString*) value;
    } else if ([key isEqualToString: @"extendedMessage"]){
        self.extendedMessage = (NSString*) value;
        
        
        
        
    } else if([key isEqualToString: @"user" ]){
        EEUser *user = [[EEUser alloc]init];
        NSDictionary *userDictionary = (NSDictionary*)value;
        for (NSString *key  in [userDictionary keyEnumerator]) {
            [user setValue:[userDictionary valueForKey:key] forParameter:key];
            
        }
        self.user = user;
        
    } else if([key isEqualToString: @"metionedUsers"]){
        NSMutableArray *mentionedArray = [NSMutableArray array];
        for (NSDictionary *mentionedDictionary  in [(NSDictionary*)value objectForKey:@"items"]) {
            EEUser *metionedUser = [[EEUser alloc] init];
            for (NSString *key in [mentionedDictionary keyEnumerator]) {
                [metionedUser setValue:[mentionedDictionary valueForKey:key] forParameter:key];
            }
            [mentionedArray addObject:metionedUser];
        }
        self.mentionedUsers = mentionedArray;
    } 
}


@end
