//
//  EENews.h
//  EEAPI
//
//  Created by Sebastian Kießling on 20.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EEAlbum,EEUser, EEPhoto, EEComment;
@interface EENews : NSObject

@property (nonatomic, assign) NSInteger newsId;
@property (nonatomic, copy) NSString *itemType;
@property (nonatomic, copy) NSString *newsType;
@property (nonatomic, strong) EEPhoto *photo;
@property (nonatomic, strong) EEUser *user;
@property (nonatomic, strong) EEAlbum *album;
@property (nonatomic, strong) EEComment *comment;
@property (nonatomic, strong) NSDate *updated;
@property (nonatomic, assign) BOOL seen;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, strong) NSURL *thumbUrl;
@property (nonatomic, strong) NSURL *url;



-(void) setValue:(id)value forParameter:(NSString *)key;

@end
