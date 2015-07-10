//
//  EEAPI.m
//  EEAPI
//
//  Created by Sebastian Kießling on 17.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EyeEmAPI.h"

NSString* const EEAPI_BASE_URL = @"https://www.eyeem.com/api/v2";
NSString* const EEAPI_AUTHORIZATION_BASE_URL = @"http://www.eyeem.com/oauth/authorize?%@";

@interface EyeEmAPI()

@property (nonatomic, readonly) NSString* oauthRedirectURIString;

- (NSString*)combiningParameters:(NSDictionary*)parameters;
- (NSDictionary*)parseURLParameters:(NSString*)query;
- (NSString*)extractString:(NSString*)string;

@end;

@implementation EyeEmAPI {
  NSString* _clientId;
  NSString* _accessToken;
}

#define kURL  @"http://www.eyeem.com/thumb"

#pragma mark - Initialization
- (instancetype)init {
  self = [super init];
  
  if(self != nil) {
    self.requests = [NSMutableArray array];
  }
  
  return self;
}

+ (instancetype)defaultClient {
  static EyeEmAPI* sharedInstance;
  static dispatch_once_t token;
  
  dispatch_once(&token,^{
    sharedInstance = [self new];
  });
  
  return sharedInstance;
}

#pragma mark - Authorization
- (void)authorizeWithClientId:(NSString*)clientId {
  
  NSString* urlString;
  NSDictionary* urlParameters;
  NSURL *url;
  
  self->_clientId = clientId;
  urlParameters = @{ @"client_id" : self->_clientId,
                     @"redirect_uri" : self.oauthRedirectURIString,
                     @"response_type" : @"code"};
  
  urlString = [NSString stringWithFormat:EEAPI_AUTHORIZATION_BASE_URL,
               [self combiningParameters: urlParameters]];
  
  url = [NSURL URLWithString:urlString];
  
  [[UIApplication sharedApplication] openURL:url];
}

- (BOOL)parseAuthorizationURL:(NSURL*)authorizeURL {
  
  BOOL result;
  
  if([[authorizeURL absoluteString] hasPrefix:self.oauthRedirectURIString.lowercaseString] == YES) {
    
    NSString *accessToken =
    [[self parseURLParameters:[authorizeURL query]] valueForKey:@"code"];
    
    if(accessToken == nil) {
      
      if([self.sessionDelegate respondsToSelector:@selector(sessionValid:)] == YES) {
        [self.sessionDelegate sessionValid:NO];
      }
      result = NO;
      
    } else {
      
      self->_accessToken = accessToken;
      if([self.sessionDelegate respondsToSelector:@selector(sessionValid:)] == YES) {
        [self.sessionDelegate sessionValid:YES];
      }
      result = YES;
    }
    
  } else {
    result = NO;
  }
  
  return result;
}

- (NSString*)oauthRedirectURIString {
  
  NSString* redirectURIString;
  NSString* appName;
  
  appName =
  [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
  
  redirectURIString =
  [NSString stringWithFormat:@"%@://eyeem-authentication",appName];
  
  return redirectURIString;
}

#pragma mark -



- (NSDictionary*)parseURLParameters:(NSString *)query {
  NSArray *pairs = [query componentsSeparatedByString:@"&"];
  NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
  for (NSString *pair in pairs) {
    NSArray *seperatedParameters = [pair componentsSeparatedByString:@"="];
    NSString *value = [[seperatedParameters objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [parameters setObject:value forKey:[seperatedParameters objectAtIndex:0]];
  }
  
  return parameters;
}

- (NSString *)combiningParameters: (NSDictionary* ) parameters
{
  NSMutableDictionary *stringParameters = [NSMutableDictionary dictionary];
  for (id parameter in [parameters keyEnumerator]) {
    [stringParameters setValue: [NSString stringWithFormat:@"%@",[parameters objectForKey:parameter] ]   forKey:parameter];
    
  }
  
  
  
  NSMutableArray* combinedParamters = [NSMutableArray array];
  for (NSString *parameter in [stringParameters keyEnumerator]) {
    NSString* value = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                            NULL,
                                                                                            (__bridge CFStringRef)[stringParameters objectForKey:parameter],
                                                                                            NULL,
                                                                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                            kCFStringEncodingUTF8);
    
    [combinedParamters addObject:[NSString stringWithFormat:@"%@=%@",parameter,value ]];
  }
  
  
  return [combinedParamters componentsJoinedByString:@"&"];
}
- (BOOL)authorized
{
  return (self->_accessToken != nil);
}
-(void) requestWithEndpoint:(NSString*) endpoint
                 parameters:(NSDictionary*) parameters
                 httpMethod:(NSString*) method
                 completion:(EERequestCompletionBlock) completionBlock
{
  
  
  NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@?%@", EEAPI_BASE_URL, endpoint, [self combiningParameters:parameters] ];
  if (self.authorized == YES) {
    [url appendFormat:@"&access_token=%@",self->_accessToken];
  } else
  {
    [url appendFormat:@"&client_id=%@",self->_clientId];
    
  }
  
  
  
  EERequest *request = [[EERequest alloc] initWithURLRequest:[NSURL URLWithString:url] httpMethod:method completion:completionBlock];
  [self.requests addObject:request];
  [request start];
}


-(void) getPopularPhotosWithLimit:(NSInteger) limit
                           offset:(NSInteger) offset
                     otherOptions:(NSDictionary*) parameters
                       completion:(void(^)(NSArray*, NSDictionary*, NSError* ))completionBlock
{
  NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
  [newParameters setValue:@"popular" forKey:@"type"];
  if (limit != 0) {
    [newParameters setValue: [NSNumber numberWithInteger:limit ] forKey:@"limit"];
    
  }
  if (offset != 0) {
    [newParameters setValue:[NSNumber numberWithInteger:offset ] forKey:@"offset"];
  }
  
  [self requestWithEndpoint:@"/photos" parameters:newParameters httpMethod:@"GET" completion:^(NSHTTPURLResponse *httpResponse, NSDictionary *response, NSError *error)
   {
     NSMutableArray *photoArray = [NSMutableArray array];
     for (NSDictionary *photoDictionary  in [[response objectForKey:@"photos" ] objectForKey:@"items"]) {
       EEPhoto *photo = [[EEPhoto alloc] init];
       
       for (NSString *key in [photoDictionary keyEnumerator]) {
         
         [photo setValue:[photoDictionary valueForKey:key] forParameter:key ];
       }
       
       
       [photoArray addObject:photo];
     }
     NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:response];
     [dict removeObjectForKey:@"items"];
     completionBlock(photoArray,dict, error);
     
   }];
  
}

- (void) getRequestWithParameters: (NSDictionary*) parameters
                       completion: (void(^)(NSHTTPURLResponse *httpResponse, NSDictionary*, NSError* ))completionBlock
{
  
  NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
  NSString *endpoint = (NSString*)[parameters valueForKey:@"endpoint"];
  [newParameters removeObjectForKey:@"endpoint"];
  [self requestWithEndpoint:endpoint parameters:newParameters httpMethod:@"GET" completion:^(NSHTTPURLResponse *httpResponse, NSDictionary *response, NSError *error)
   {
     
     NSDictionary *newResponse = [self sortResponse:[NSMutableDictionary dictionaryWithDictionary:response]];
     completionBlock(httpResponse,newResponse, error);
   } ];
  
}


- (void) putRequestWithParameters: (NSDictionary*) parameters
                       completion: (void(^)(NSHTTPURLResponse *httpResponse, NSDictionary*, NSError* ))completionBlock
{
  NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
  NSString *endpoint = (NSString*)[parameters valueForKey:@"endpoint"];
  [newParameters removeObjectForKey:@"endpoint"];
  [self requestWithEndpoint:endpoint parameters:newParameters httpMethod:@"PUT" completion:^(NSHTTPURLResponse *httpResponse, NSDictionary *response, NSError *error)
   {
     completionBlock(httpResponse,response, error);
   } ];
  
  
}


- (void) postRequestWithParameters: (NSDictionary*) parameters
                        completion: (void(^)(NSHTTPURLResponse *httpResponse, NSDictionary*, NSError* ))completionBlock
{
  NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
  
  NSString *endpoint = (NSString*)[parameters valueForKey:@"endpoint"];
#ifdef DEBUG
  if ([endpoint hasSuffix:@"/friends"] && [parameters objectForKey:@"friend_id"] == nil) {
    NSAssert(NO, @"The parameter friend_id is required!");
  } else if([endpoint hasSuffix:@"/comments"] && [parameters objectForKey:@"message"] == nil )
  {
    NSAssert(NO, @"The parameter message is required!");
  } else if([endpoint hasSuffix:@"/news"] && [parameters objectForKey:@"markAsRead"] == nil )
  {
    NSAssert(NO, @"The parameter markAsRead is required!");
  }
#endif
  
  [newParameters removeObjectForKey:@"endpoint"];
  [self requestWithEndpoint:endpoint parameters:newParameters httpMethod:@"POST" completion:^(NSHTTPURLResponse *httpResponse, NSDictionary *response, NSError *error)
   {
     completionBlock(httpResponse,response, error);
   } ];
  
  
}
- (NSDictionary* ) sortResponse: (NSMutableDictionary*) response
{
  NSMutableDictionary *dict = (__bridge NSMutableDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFDictionaryRef)response, kCFPropertyListMutableContainers);
  
  for (NSString *key in [response keyEnumerator]) {
    if ([key isEqualToString:@"photos"] || [key isEqualToString:@"friendsPhotos"] || [key isEqualToString:@"likedPhotos"]) {
      
      NSMutableArray *photoArray = [NSMutableArray array];
      for (NSDictionary *photoDictionary  in [[response objectForKey:key ] objectForKey:@"items"]) {
        EEPhoto *photo = [[EEPhoto alloc] init];
        
        for (NSString *innerKey in [photoDictionary keyEnumerator]) {
          
          [photo setValue:[photoDictionary valueForKey:innerKey] forParameter:innerKey];
        }
        
        
        [photoArray addObject:photo];
      }
      [[dict objectForKey:key ] setObject:photoArray forKey:@"items"];
    } else if ([key isEqualToString:@"photo"]) {
      EEPhoto *photo = [[EEPhoto alloc] init];
      
      for (NSString *innerKey in [[response objectForKey:key] keyEnumerator]) {
        
        [photo setValue:[[response objectForKey:key] valueForKey:innerKey] forParameter:innerKey];
      }
      
      
      
      [dict setObject:photo forKey:@"photo"];
      
      
      
      
      
      
      
    } else if ([key isEqualToString:@"users"] || [key isEqualToString:@"likers"] || [key isEqualToString:@"friends"] || [key isEqualToString:@"followers"] || [key isEqualToString:@"contributors"]) {
      NSMutableArray *userArray = [NSMutableArray array];
      for (NSDictionary *userDictionary  in [[response objectForKey:key ] objectForKey:@"items"]) {
        EEUser *user = [[EEUser alloc] init];
        
        for (NSString *innerKey in [userDictionary keyEnumerator]) {
          
          [user setValue:[userDictionary valueForKey:innerKey] forParameter:innerKey];
        }
        
        
        [userArray addObject:user];
      }
      [[dict objectForKey:key ] setObject:userArray forKey:@"items"];
      
    } else if ([key isEqualToString:@"user"]) {
      EEUser *user = nil;
      NSArray *keys = [response allKeys ];
      if ([keys containsObject:@"newsSettings"] || [keys containsObject:@"email"] || [keys containsObject:@"emailNotifications"] || [keys containsObject:@"pushNotifications"] || [keys containsObject:@"services"] )
      {
        user = [[EEOAuthUser alloc] init];
        
      } else {
        user = [[EEUser alloc] init];
        
      }
      
      for (NSString *innerKey in [[response objectForKey:key] keyEnumerator]) {
        
        [user setValue:[[response objectForKey:key] valueForKey:innerKey] forParameter:innerKey];
      }
      
      
      
      [dict setObject:user forKey:@"user"];
      
      
    } else if ([key isEqualToString:@"albums"] || [key isEqualToString:@"feedAlbums"]|| [key isEqualToString:@"likedAlbums"]) {
      NSMutableArray *albumArray = [NSMutableArray array];
      for (NSDictionary *albumDictionary  in [[response objectForKey:key ] objectForKey:@"items"]) {
        EEAlbum *album = [[EEAlbum alloc] init];
        
        for (NSString *innerKey in [albumDictionary keyEnumerator]) {
          
          [album setValue:[albumDictionary valueForKey:innerKey] forParameter:innerKey];
        }
        
        
        [albumArray addObject:album];
      }
      [[dict objectForKey:key ] setObject:albumArray forKey:@"items"];
      
    } else if ([key isEqualToString:@"album"]) {
      EEAlbum *album = [[EEAlbum alloc] init];
      
      for (NSString *innerKey in [[response objectForKey:key] keyEnumerator]) {
        
        [album setValue:[[response objectForKey:key] valueForKey:innerKey] forParameter:innerKey];
      }
      
      
      
      
      [dict setObject:album forKey:@"album"];
      
      
      
    } else if ([key isEqualToString:@"comments"]) {
      NSMutableArray *commentArray = [NSMutableArray array];
      for (NSDictionary *commentDictionary  in [[response objectForKey:key ] objectForKey:@"items"]) {
        EEComment *comment = [[EEComment alloc] init];
        
        for (NSString *innerKey in [commentDictionary keyEnumerator]) {
          
          [comment setValue:[commentDictionary valueForKey:innerKey] forParameter:innerKey];
        }
        
        
        [commentArray addObject:comment];
      }
      [[dict objectForKey:key ] setObject:commentArray forKey:@"items"];
      
    } else if ([key isEqualToString:@"comment"]) {
      
      EEComment *comment = [[EEComment alloc] init];
      
      for (NSString *innerKey in [[response objectForKey:key] keyEnumerator]) {
        
        [comment setValue:[[response objectForKey:key] valueForKey:innerKey] forParameter:innerKey];
      }
      
      
      
      
      [dict setObject:comment forKey:@"comment"];
      
      
    } else if ([key isEqualToString:@"bgImages"]) {
      [dict setObject:[response objectForKey:key ] forKey:key];
      
    } else if ([key isEqualToString:@"topics"]) {
      [dict setObject:[response objectForKey:key ] forKey:key];
      
    } else {
      [dict setObject:[response objectForKey:key ] forKey:key];
      
    }
  }
  return dict;
}

#pragma mark - iamge url resolution helper methods

- (NSString*) extractString: (NSString *) string
{
  
  NSArray *array =  [string componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
  return [array objectAtIndex:([array count]-1) ];
  
}

-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelSize:(CGSize)imageSize
{
  if (urlPath == nil) {
    return nil;
  }
  NSString *newUrl = [self extractString:[urlPath absoluteString]];
  newUrl = [NSString stringWithFormat:@"%@/%li/%li/%@", kURL, (long)roundf(imageSize.width), (long)roundf(imageSize.height), newUrl];
  
  
  return [NSURL URLWithString:newUrl];
}

-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelWidth:(NSInteger)imageWidth
{
  
  if (urlPath == nil) {
    return nil;
  }
  NSString *newUrl = [self extractString: [urlPath absoluteString]];
  newUrl = [NSString stringWithFormat:@"%@/w/%li/%@", kURL, (long)(imageWidth), newUrl];
  
  
  return [NSURL URLWithString:newUrl];
}
-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withSquareSize:(NSInteger)imageSize
{
  if (urlPath == nil) {
    return nil;
  }
  NSString *newUrl = [self extractString:[urlPath absoluteString]];
  newUrl = [NSString stringWithFormat:@"%@/sq/%li/%@", kURL, (long)(imageSize), newUrl];
  
  
  return [NSURL URLWithString:newUrl];
}

-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelHeight:(NSInteger)imageHeight
{
  
  if (urlPath == nil) {
    return nil;
  }
  NSString *newUrl = [self extractString:[urlPath absoluteString]];
  newUrl = [NSString stringWithFormat:@"%@/h/%li/%@", kURL, (long)(imageHeight), newUrl];
  
  
  return [NSURL URLWithString:newUrl];
}



@end
