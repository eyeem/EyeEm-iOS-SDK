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

@protocol EESessionDelegate<NSObject>

-(void)sessionValid:(BOOL)valid;

@end

@interface EyeEmAPI : NSObject

@property(nonatomic) EERequest* eeRequest;
@property(nonatomic) NSMutableArray* requests;

/*
 * Initialization
 *
 * Creating new object of the EyeEmAPI class can be done by invoking 
 * the -init method or by using the +defaultClient static method 
 * which is responsible for creating shared instance of EyeEmAPI class.
 */
- (instancetype)init; //Creates a new EyeEmAPI object.
+ (instancetype)defaultClient; //Convenient way to work with shared instance of EyeEmAPI class.

/*
 * Authorization
 *
 * Invoking -authorizeWithClientId: begins the process of authorization 
 * that is ended when AppDelegate recieves message 
 * -application:openURL:sourceApplication:sourceApplication:annotation:.
 * In context of this method must be send the -parseAuthorizationURL: message 
 * to the EyeEmAPI object.
 *
 * Checking if the session has been established can be done by reading 
 * the value of the authorized property from the EyeEmAPI object
 *
 * In case when particular object wants to be notified about 
 * result of authorization process it must implement the EESessionDelegate protocol
 * and must be assigned as a sessionDeelgate for the EyeEmAPI object.
 */
- (void)authorizeWithClientId:(NSString*)clientId; //Begins the process of authorization with specified cliendId.
- (BOOL)parseAuthorizationURL:(NSURL*)authorizeURL; //Parses the URL received in response to a request for authorization.

@property(nonatomic, weak) id<EESessionDelegate>sessionDelegate; //Weak reference to an object that wants to be notified about result of a authorization process.
@property (nonatomic, readonly, getter=isAuthorized) BOOL authorized; //Returns YES if the session has been established or NO otherwise.

//Requests
- (void)requestWithEndpoint:(NSString*)endpoint
                 parameters:(NSDictionary*)parameters
                 httpMethod:(NSString*)method
                 completion:(EERequestCompletionBlock)completionBlock;

-(void)getPopularPhotosWithLimit:(NSInteger) limit
                           offset:(NSInteger) offset
                     otherOptions:(NSDictionary*) parameters
                       completion:(void(^)(NSArray* , NSDictionary*, NSError* ))completionBlock;


- (void)getRequestWithParameters:(NSDictionary*)parameters
                       completion:(void(^)(NSHTTPURLResponse *httpResponse, NSDictionary*, NSError* ))completionBlock;

- (void)putRequestWithParameters:(NSDictionary*) parameters
                       completion:(void(^)(NSHTTPURLResponse *httpResponse, NSDictionary*, NSError* ))completionBlock;

- (void)postRequestWithParameters:(NSDictionary*) parameters
                        completion:(void(^)(NSHTTPURLResponse *httpResponse, NSDictionary*, NSError* ))completionBlock;
- (NSDictionary*)sortResponse:(NSMutableDictionary*) response;

-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelSize:(CGSize)imageSize;
-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelWidth:(NSInteger)imageWidth;
-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withSquareSize:(NSInteger)imageSize;
-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelHeight:(NSInteger)imageHeight;

@end


