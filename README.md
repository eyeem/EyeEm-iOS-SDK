# EyeEm iOS SDK
***

This is the first interation of our iOS wrapper. It uses ARC, so the development target is 5.0.
Please read first our main [API documentation](https://github.com/eyeem/Public-API#eyeem-api).

It's inpsired by the [Facebook iOS SDK](https://github.com/facebook/facebook-ios-sdk),[500px iOS SDK](https://github.com/500px/500px-iOS-api) and [crino](https://github.com/crino).
## Getting Started
***

1. Register your app at [EyeEm](http://www.eyeem.com/developers)
2. put `#import "EyeEmAPI.h"`in your .h
3. To initialize the API use `[[EyeEmAPI alloc] initWithClientId:client_id]`
4. Link your project with CoreLocation.framework, if you havn't already.

###with OAuth 

If you want to use OAuth authentication you have to implement the API (step 2 and 3) in your AppDelegate. 

1. You need to add this to your info.plist file. ee`client_id`://
2. Add this to your AppDelegate.m file
	
``` objective-c
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [---your EyeEmAPI object--- handleOpenURL:url]; 
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [---your EyeEmAPI object---  handleOpenURL:url];    
}
```
Now you are ready to go.

##How to use it
***
###Queries

You create a EEQuery object and then set the properties the way you want to have a query. If you have an access token, it will be automatically used, otherwise your client id  will be used.

`https://www.eyeem.com/api/v2/users/me/friends/1013`

``` objective-c
EEQuery *query = [[EEQuery alloc] init];
query.generalEndpoint = gUsers;
query.firstStringId =@"me";
query.specificEndpoint = sFriends;
query.secondId = 1013;
```
`https://www.eyeem.com/api/v2/albums/17?detailed=1&includePhotos=1&numPhotos=2&photoDetails=1&includeContributors=1&includeLikers=1`

``` objective-c

EEQuery *query = [[EEQuery alloc] init];
query.generalEndpoint = gAlbums;
query.firstId = 17;
query.detailed = YES;
query.photos = YES;
query.photoNumber = 2;
query.photoDetails = YES;
query.contributors = YES;
query.likers = YES;
        
``` 

###Request

Now are only GET requests supported.
To get the query object into a dictionary use the `- (NSDictionary*) createDictionary;` 

```objective-c
- (void) getRequestWithParameters: (NSDictionary*) parameters
                       completion: (void(^)(NSHTTPURLResponse *httpResponse, NSDictionary*, NSError* ))completionBlock;
                       
```

###Response

The response is basically the same as in the API documentation descriped, only that a photo dictionary is a EEPhoto object and an arry of photos an array of EEphoto objects is. The same applies to albums and users. 
[`https://www.eyeem.com/api/v2/photos?type=popular&limit=5`](https://github.com/eyeem/Public-API/blob/master/endpoints/photos/GET_photo.md#files)
```
{
    photos =     {
        items =         (
            "<EEPhoto: 0x68c10c0>",
            "<EEPhoto: 0x68c11e0>",
            "<EEPhoto: 0x68c4520>",
            "<EEPhoto: 0x68c1d70>",
            "<EEPhoto: 0x68c3cc0>"
        );
        limit = 5;
        offset = 0;
        total = 681;
    };
}
```
```
{
  "photos": {
    "offset": 0,
    "limit": 5,
    "total": 681,
    "items": [
      {
        "id": 984670,
        "thumbUrl": "http://www.eyeem.com/thumb/h/100/373da7354530c72410d2425afdc4e6c1101e82f9-1348242890",
        "photoUrl": "http://www.eyeem.com/thumb/640/480/373da7354530c72410d2425afdc4e6c1101e82f9-1348242890",
        "width": 1296,
        "height": 1296,
        "updated": "2012-09-21T17:54:52+0200"
      },
      {
        "id": 984662,
        "thumbUrl": "http://www.eyeem.com/thumb/h/100/c661451b3435be2d73daa897ee5a62a1096bab80-1348242734",
        "photoUrl": "http://www.eyeem.com/thumb/640/480/c661451b3435be2d73daa897ee5a62a1096bab80-1348242734",
        "width": 1296,
        "height": 1296,
        "updated": "2012-09-21T17:52:17+0200"
      },
      {
        "id": 984486,
        "thumbUrl": "http://www.eyeem.com/thumb/h/100/b97436b3302873952e06ee6c1c2274bec33f3c01-1348240283",
        "photoUrl": "http://www.eyeem.com/thumb/640/480/b97436b3302873952e06ee6c1c2274bec33f3c01-1348240283",
        "width": 1109,
        "height": 1296,
        "updated": "2012-09-21T17:11:40+0200"
      },
      {
        "id": 984604,
        "thumbUrl": "http://www.eyeem.com/thumb/h/100/7f8bf5ee3207ff60f6ff203fd45cad93d8acb5dd-1348241773",
        "photoUrl": "http://www.eyeem.com/thumb/640/480/7f8bf5ee3207ff60f6ff203fd45cad93d8acb5dd-1348241773",
        "width": 1296,
        "height": 1296,
        "updated": "2012-09-21T17:36:29+0200"
      },
      {
        "id": 984625,
        "thumbUrl": "http://www.eyeem.com/thumb/h/100/5e9173b4827bb4dfc139cb7f2b91ed722cb473c7-1348242086",
        "photoUrl": "http://www.eyeem.com/thumb/640/480/5e9173b4827bb4dfc139cb7f2b91ed722cb473c7-1348242086",
        "width": 909,
        "height": 866,
        "updated": "2012-09-21T17:41:43+0200"
      }
    ]
  }
}
```
###Authorize

To authorize a user call `[---your EyeEmAPI object--- authorize]`. You can implement EESessionDelegate to get notified, wheter the user accepted the authorization or not.
## Image Resolution
***

If you want get an other photo than the standard 640*480 pixel from the photoUrl, use these methods: 

``` objective-c
-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelSize:(CGSize)imageSize;
-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelWidth:(NSInteger)imageWidth;
-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withSquareSize:(NSInteger)imageSize;
-(NSURL*) urlFromPathForPhoto:(NSURL*)urlPath withPixelHeight:(NSInteger)imageHeight;
```

  
##Contact
***

For feedback, questions, complaints and props, you can get in touch with us at [api@eyeem.com](mailto:api@eyeem.com) or [@eyeemapi](http://twitter.com/eyeemapi) on Twitter.


##License
***
EyeEm iOS SDK is licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).


