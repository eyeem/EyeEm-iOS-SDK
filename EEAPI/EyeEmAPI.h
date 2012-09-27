//
//  EEAPI.h
//  EEAPI
//
//  Created by Sebastian Kießling on 17.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "EERequest.h"
#import "EEPhoto.h"
#import "EEUser.h"
#import "EEAlbum.h"
#import "EEQuery.h"
#import "EEPhotosQuery.h"
#import "EEAlbumsQuery.h"
#import "EENewsQuery.h"
#import "EESearchQuery.h"
#import "EETopicsQuery.h"
#import "EEUsersQuery.h"
#import "EEVenuesQuery.h"

#import "EEComment.h"
#import "EEOAuthUser.h"

@protocol EESessionDelegate;
@class EEAlbum,EEComment,EERequest,EEPhoto,EEUser,EEQuery;
@interface EyeEmAPI : NSObject


@property(nonatomic, strong) NSString* clientId;
@property(nonatomic, strong) NSString* baseURL;
@property(nonatomic, strong) NSString* accessToken;
@property(nonatomic, strong) EERequest* eeRequest;
@property(nonatomic) NSMutableArray* requests;
@property(nonatomic, weak) id<EESessionDelegate> sessionDelegate;


-(id)initWithClientId:(NSString*)clientId;
-(void) authorize;
- (NSString *)combiningParameters: (NSDictionary* ) parameters;
-(NSDictionary*)parseURLParameters:(NSString *)query;
-(BOOL) isOAuthValid;
-(void) requestWithEndpoint:(NSString*) endpoint
                 parameters:(NSDictionary*) parameters
                 httpMethod:(NSString*) method
                 completion:(EERequestCompletionBlock) completionBlock;



-(void) getPopularPhotosWithLimit:(NSInteger) limit
                           offset:(NSInteger) offset
                     otherOptions:(NSDictionary*) parameters
                       completion:(void(^)(NSArray* , NSDictionary*, NSError* ))completionBlock;
- (BOOL) handleOpenURL:  (NSURL*) url;
 

- (void) getRequestWithParameters: (NSDictionary*) parameters
                       completion: (void(^)(NSHTTPURLResponse *httpResponse, NSDictionary*, NSError* ))completionBlock;

- (void) putRequestWithParameters: (NSDictionary*) parameters
                       completion: (void(^)(NSHTTPURLResponse *httpResponse, NSDictionary*, NSError* ))completionBlock;

- (void) postRequestWithParameters: (NSDictionary*) parameters
                        completion: (void(^)(NSHTTPURLResponse *httpResponse, NSDictionary*, NSError* ))completionBlock;
- (NSDictionary* ) sortResponse: (NSMutableDictionary*) response;
- (NSString*) extractString: (NSString *) string;


-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelSize:(CGSize)imageSize;
-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelWidth:(NSInteger)imageWidth;
-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withSquareSize:(NSInteger)imageSize;
-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelHeight:(NSInteger)imageHeight;

@end

@protocol EESessionDelegate <NSObject>
-(void) sessionValid:(BOOL) valid;
@end
