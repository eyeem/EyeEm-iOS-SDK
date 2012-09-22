//
//  EELocation.h
//  EEAPI
//
//  Created by Sebastian Kießling on 19.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class EEAlbum;
@interface EELocation : NSObject

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) EEAlbum *cityAlbum;
@property (nonatomic, strong) EEAlbum *countryAlbum;
@property (nonatomic, strong) NSDictionary *venueService;

-(void) setValue:(id)value forParameter:(NSString *)key;

@end
