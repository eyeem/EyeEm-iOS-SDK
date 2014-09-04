//
//  EEUsersQuery.h
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEQuery.h"
typedef NS_ENUM(NSUInteger, EESpecificUsersEndpoint) {
    EEspecificUsersEndpointPhotos,
    EEspecificUsersEndpointLikedPhotos,
    EEspecificUsersEndpointFriendsPhotos,
    EEspecificUsersEndpointLikedAlbums,
    EEspecificUsersEndpointFeed,
    EEspecificUsersEndpointDiscover,
    EEspecificUsersEndpointFriends,
    EEspecificUsersEndpointFollowers,
    EEspecificUsersEndpointTopics,
    EEspecificUsersEndpointSocialMedia,
    EEspecificUsersEndpointNewsSettings,
    EEspecificUsersEndpointShare,
    EEspecificUsersEndpointHide,
    EEspecificUsersEndpointNothing
};

@interface EEUsersQuery : EEQuery
@property (nonatomic, assign) EESpecificUsersEndpoint specificEndpoint;
@property (nonatomic, assign) BOOL suggested;
@property (nonatomic, strong) NSString *closestVenueFsIds;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, assign) BOOL upload;
@property (nonatomic, assign) BOOL photoLike;
@property (nonatomic, assign) BOOL photoComment;
@property (nonatomic, assign) BOOL albumLike;
@property (nonatomic, assign) BOOL userFollow;
@property (nonatomic, assign) BOOL timelinePopup;
@property (nonatomic, strong) NSString *fullname;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) BOOL emailNotification;
@property (nonatomic, assign) BOOL pushNotification;
@property (nonatomic, assign) BOOL facebookTimeline;
@property (nonatomic, strong) NSString *friend_id;
@property (nonatomic, assign) BOOL keys;
@property (nonatomic, strong) NSString *oauth_token;
@property (nonatomic, strong) NSString *oauth_token_secret;
@property (nonatomic, assign) NSInteger service_user_id;
@property (nonatomic, strong) NSString *service_screen_name;
@property (nonatomic, assign) BOOL follow;
@property (nonatomic, assign) BOOL callback;
@property (nonatomic, assign) BOOL connect;


@property (nonatomic, assign) BOOL suggestedFlag;
@property (nonatomic, assign) BOOL uploadFlag;
@property (nonatomic, assign) BOOL photoLikeFlag;
@property (nonatomic, assign) BOOL photoCommentFlag;
@property (nonatomic, assign) BOOL albumLikeFlag;
@property (nonatomic, assign) BOOL userFollowFlag;
@property (nonatomic, assign) BOOL timelinePopupFlag;
@property (nonatomic, assign) BOOL emailNotificationFlag;
@property (nonatomic, assign) BOOL pushNotificationFlag;
@property (nonatomic, assign) BOOL facebookTimelineFlag;
@property (nonatomic, assign) BOOL keysFlag;
@property (nonatomic, assign) BOOL followFlag;
@property (nonatomic, assign) BOOL callbackFlag;
@property (nonatomic, assign) BOOL connectFlag;
-(NSDictionary*) createDictionary;
@end
