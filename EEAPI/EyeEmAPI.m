//
//  EEAPI.m
//  EEAPI
//
//  Created by Sebastian Kießling on 17.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EyeEmAPI.h"


@implementation EyeEmAPI

#define kURL  @"http://www.eyeem.com/thumb"

-(id)initWithClientId:(NSString*)clientId
{
    self = [super init];
    if (self) {

        self.clientId = clientId;
        self.baseURL = @"https://www.eyeem.com/api/v2";
        self.requests = [NSMutableArray array];
    }
    return self;
}

-(void) authorize
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   self.clientId, @"client_id",
                                   [NSString stringWithFormat:@"ee%@://authorize",self.clientId ], @"redirect_uri",
                                    @"code", @"response_type",
                                   nil];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.eyeem.com/oauth/authorize?%@",[self combiningParameters: parameters]]];
    [[UIApplication sharedApplication] openURL:url];
    
}

- (BOOL) handleOpenURL:  (NSURL*) url
{

    if ([[url absoluteString] hasPrefix:[NSString stringWithFormat:@"ee%@://authorize",[self.clientId lowercaseString]]] || [[url absoluteString] hasPrefix:[NSString stringWithFormat:@"ee%@://authorize",self.clientId ]]) {
        

        
        

        NSString *accessToken = [[self parseURLParameters:[url query]] valueForKey:@"code"];

        if (!accessToken) {
            if ([self.sessionDelegate respondsToSelector:@selector(sessionValid:)]) {
                [self.sessionDelegate sessionValid:NO];
                
            }
            return true;
        }
        self.accessToken = accessToken;
        if ([self.sessionDelegate respondsToSelector:@selector(sessionValid:)]) {
            [self.sessionDelegate sessionValid:YES];
            
        }
        return true;
        
    } else
    {
        return false;
    }
    
}
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
- (BOOL)isOAuthValid
{
    return (self.accessToken != nil);
}
-(void) requestWithEndpoint:(NSString*) endpoint
                 parameters:(NSDictionary*) parameters
                 httpMethod:(NSString*) method
                 completion:(EERequestCompletionBlock) completionBlock
{
    
    
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@?%@", self.baseURL, endpoint, [self combiningParameters:parameters] ];
    if ([self isOAuthValid]) {
        [url appendFormat:@"&access_token=%@",self.accessToken];
    } else
    {
        [url appendFormat:@"&client_id=%@",self.clientId];

    }
    
    

    EERequest *request = [[EERequest alloc] initWithURLRequest:[NSURL URLWithString:url] httpMethod:method completion:completionBlock];
    [self.requests addObject:request];
    [request start];
}


-(void) getPopularPhotosWithLimit:(NSInteger) limit
                           offset:(NSInteger) offset
                     otherOptions:(NSDictionary*) parameters
                       completion:(void(^)(NSArray* , NSDictionary*, NSError* ))completionBlock
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
            EEUser *user = [[EEUser alloc] init];
            
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
            
        } else if ([key isEqualToString:@"comment"]) {
                        
        } else if ([key isEqualToString:@"bgImages"]) {
            
        } else if ([key isEqualToString:@"topics"]) {
                        
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
    newUrl = [NSString stringWithFormat:@"%@/%i/%i/%@", kURL, (int)(imageSize.width), (int)(imageSize.height), newUrl];
    
    
    return [NSURL URLWithString:newUrl];
}

-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelWidth:(NSInteger)imageWidth
{

    if (urlPath == nil) {
        return nil;
    }
    NSString *newUrl = [self extractString: [urlPath absoluteString]];
    newUrl = [NSString stringWithFormat:@"%@/w/%i/%@", kURL, (int)(imageWidth), newUrl];
    
    
    return [NSURL URLWithString:newUrl];
}
-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withSquareSize:(NSInteger)imageSize
{
    if (urlPath == nil) {
        return nil;
    }
    NSString *newUrl = [self extractString:[urlPath absoluteString]];
    newUrl = [NSString stringWithFormat:@"%@/sq/%i/%@", kURL, (int)(imageSize), newUrl];
    
    
    return [NSURL URLWithString:newUrl];
}

-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelHeight:(NSInteger)imageHeight
{
    
    if (urlPath == nil) {
        return nil;
    }
    NSString *newUrl = [self extractString:[urlPath absoluteString]];
    newUrl = [NSString stringWithFormat:@"%@/h/%i/%@", kURL, (int)(imageHeight), newUrl];
    
    
    return [NSURL URLWithString:newUrl];
}



@end
