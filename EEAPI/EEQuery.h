//
//  EEQuery.h
//  EEAPI
//
//  Created by Sebastian Kießling on 20.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>




@interface EEQuery : NSObject


@property (nonatomic, assign) NSInteger firstId;
@property (nonatomic, assign) NSString *generalEndpointString;
@property (nonatomic, assign) NSInteger secondId;
@property (nonatomic, assign) NSString *specificEndpointString;
@property (nonatomic, strong) NSString *firstStringId;
@property (nonatomic, strong) NSString *secondStringId;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *ids;
@property (nonatomic, strong) NSString *q;

@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) BOOL onlyId;
@property (nonatomic, assign) BOOL detailed;
@property (nonatomic, assign) BOOL albums;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *services;

@property (nonatomic, strong) NSString *name;



#pragma mark Flags

@property (nonatomic, assign) BOOL onlyIdFlag;
@property (nonatomic, assign) BOOL detailedFlag;
@property (nonatomic, assign) BOOL albumsFlag;





-(NSDictionary*) createDictionary;
@end
