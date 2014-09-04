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

        self.secondId = -1;
        self.limit = -1;
        self.offset = -1;

    }
    return self;
}

-(NSDictionary*) createDictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableString *endpoint = [NSMutableString string];
    [endpoint appendString:self.generalEndpointString];
    
    if (self.firstId >0 || self.firstStringId != nil) {
        if (self.firstStringId != nil) {
            [endpoint appendFormat:@"/%@",self.firstStringId];

        } else {
            [endpoint appendFormat:@"/%li",(long)self.firstId];

        }
    }
    if (self.specificEndpointString != nil) {
        [endpoint appendString:self.specificEndpointString];
        if (self.secondId >0 || self.secondStringId != nil) {
            if (self.secondStringId != nil) {
                [endpoint appendFormat:@"/%@",self.secondStringId];
                
            } else {
                [endpoint appendFormat:@"/%li",(long)self.secondId];
                
            }
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
    if (self.services !=nil) {
        [dictionary setValue:self.services forKey:@"services"];
    }
    if (self.limit > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.limit ] forKey:@"limit"];
    }
    if (self.offset > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.offset] forKey:@"offset"];
    }
    if (self.onlyIdFlag) {

        [dictionary setValue:[NSNumber numberWithBool:self.onlyId ] forKey:@"onlyId"];
    }
    if (self.detailedFlag) {

        [dictionary setValue:[NSNumber numberWithBool:self.detailed] forKey:@"detailed"];
    }
    if (self.albumsFlag) {

        [dictionary setValue:[NSNumber numberWithBool:self.albums] forKey:@"includeAlbums"];
    }
    
    
    




   
    if (self.message !=nil) {
        [dictionary setValue:self.message forKey:@"message"];
    }
    if (self.name !=nil) {
        [dictionary setValue:self.name forKey:@"name"];
    }


    return dictionary;
}



-(void) setDetailed:(BOOL)detailed
{
    _detailed = detailed;
    self.detailedFlag =YES;
    
}
-(void) setAlbums:(BOOL)albums
{
    _albums = albums;
    self.albumsFlag =YES;
    
}


@end