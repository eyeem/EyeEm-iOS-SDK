//
//  EERequest.h
//  EEAPI
//
//  Created by Sebastian Kießling on 17.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^EERequestCompletionBlock)(NSHTTPURLResponse *httpResponse, NSDictionary *response, NSError *error);

@interface EERequest : NSObject
@property(nonatomic, strong) NSURL* url;
@property(nonatomic, strong) NSString* httpMethod;
@property(nonatomic, strong) NSURLConnection *connection;
@property(nonatomic, strong) EERequestCompletionBlock completionBlock;
@property(nonatomic, strong) NSMutableData *data;
@property(nonatomic, strong) NSHTTPURLResponse *httpResponse;



-(id)initWithURLRequest:(NSURL *)url
             httpMethod:(NSString *) httpMethod
             completion:(EERequestCompletionBlock)completion;
-(void) start;
@end
