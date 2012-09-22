//
//  EELocation.m
//  EEAPI
//
//  Created by Sebastian Kießling on 19.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EELocation.h"
#import "EEAlbum.h"

@implementation EELocation



-(void) setValue:(id)value forParameter:(NSString *)key
{
    
    if([key isEqualToString: @"latitude"] || [key isEqualToString: @"longitude"]){
        CLLocationDegrees degree = [ value doubleValue];
        if ([key isEqualToString: @"latitude"]) {
            self.coordinate = CLLocationCoordinate2DMake(degree,self.coordinate.longitude);
        }else{
            self.coordinate = CLLocationCoordinate2DMake(self.coordinate.latitude,degree);
        }
    } else if([key isEqualToString: @"cityAlbum"] || [key isEqualToString: @"countryAlbum"] ){
        EEAlbum *album = [[EEAlbum alloc]init];
        NSDictionary *albumDictionary = (NSDictionary*)value;
        for (NSString *key  in [albumDictionary keyEnumerator]) {
            [album setValue:[albumDictionary valueForKey:key] forParameter:key];
            
        }
        if ([key isEqualToString: @"cityAlbum"]) {
            self.cityAlbum = album;
        } else {
            self.countryAlbum = album;

        }

        
    } else if([key isEqualToString: @"venueService"] ){
        self.venueService = (NSDictionary*)value;

        

        
    }
}
@end
