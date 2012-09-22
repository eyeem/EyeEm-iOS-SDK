//
//  EERequest.m
//  EEAPI
//
//  Created by Sebastian Kießling on 17.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EERequest.h"
static NSString* kUserAgent = @"iOSsdk";
static const NSTimeInterval kTimeoutInterval = 60.0;

@implementation EERequest


-(id)initWithURLRequest:(NSURL *)url
             httpMethod:(NSString *) httpMethod
             completion:(EERequestCompletionBlock)completion
{
    self = [super init];
    if (self != nil)
    {
        self.url = url;
        self.httpMethod = httpMethod;
        self.completionBlock = [completion copy];
    }
    
    return self;
}
- (void) start
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:self.url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:kTimeoutInterval];
    [request setValue:kUserAgent forHTTPHeaderField:@"User-Agent"];
    self.data = [NSMutableData data];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];

    
}





#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.httpResponse = (NSHTTPURLResponse *) response;
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    [self.data appendData:data];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *jsonError = nil;
    if (self.data != nil) {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:self.data options:kNilOptions error:&jsonError];
        self.completionBlock(self.httpResponse,response,nil);

    } else {
        self.completionBlock(self.httpResponse,nil,nil);

    }
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    self.data = nil;
    self.connection = nil;
    self.completionBlock(nil,nil,error);
    
}


@end

