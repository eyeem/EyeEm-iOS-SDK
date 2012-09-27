//
//  EEUsersQuery.m
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEUsersQuery.h"

@implementation EEUsersQuery
- (id)init
{
    self = [super init];
    if (self) {
        
        self.specificEndpoint = EEspecificUsersEndpointNothing;

        self.service_user_id = -1;

    }
    return self;
}
-(NSDictionary*) createDictionary
{
    self.generalEndpointString = @"/users";

    if (self.specificEndpoint != EEspecificUsersEndpointNothing) {
        switch (self.specificEndpoint) {
            case EEspecificUsersEndpointPhotos:
                self.specificEndpointString = @"/photos";
                break;
            case EEspecificUsersEndpointLikedPhotos:
                self.specificEndpointString = @"/likedPhotos";
                break;
            case EEspecificUsersEndpointFriendsPhotos:
                self.specificEndpointString = @"/friendsPhotos";
                break;
            case EEspecificUsersEndpointLikedAlbums:
                self.specificEndpointString = @"/likedAlbums";
                break;
            case EEspecificUsersEndpointFeed:
                self.specificEndpointString = @"/feed";
                break;
            case EEspecificUsersEndpointDiscover:
                self.specificEndpointString = @"/discover";
                break;
            case EEspecificUsersEndpointFriends:
                self.specificEndpointString = @"/friends";
                break;
            case EEspecificUsersEndpointFollowers:
                self.specificEndpointString = @"/followers";
                break;
            case EEspecificUsersEndpointTopics:
                self.specificEndpointString = @"/topics";
                break;
            case EEspecificUsersEndpointSocialMedia:
                self.specificEndpointString = @"/socialMedia";
                break;
            case EEspecificUsersEndpointNewsSettings:
                self.specificEndpointString = @"/newsSettings";
                break;
            case EEspecificUsersEndpointShare:
                self.specificEndpointString = @"/share";
                break;
            case EEspecificUsersEndpointHide:
                self.specificEndpointString = @"/hide";
                break;
        
            default:
                break;
        }
    }
#ifdef DEBUG
    else if (self.firstId <= 0 && self.firstStringId == nil && self.q == nil && self.ids == nil && self.suggested == NO)
    {
        NSAssert(NO, @"One of the following parameters is required: ids, q, suggested!");
    }
#endif
    NSMutableDictionary *dictionary = [NSDictionary dictionaryWithDictionary:[super createDictionary]];
    
    
    if (self.suggestedFlag ) {
        
        [dictionary setValue:[NSNumber numberWithBool:self.suggested] forKey:@"suggested"];
    }
    if (self.closestVenueFsIds !=nil) {
        [dictionary setValue:self.closestVenueFsIds forKey:@"X-GEO-closestVenueFsIds"];
    }
    if (self.cityName !=nil) {
        [dictionary setValue:self.cityName forKey:@"X-GEO-cityName"];
    }
    if (self.uploadFlag ) {
        [dictionary setValue:[NSNumber numberWithBool:self.upload] forKey:@"upload"];
        
    }
    if (self.photoLikeFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.photoLike] forKey:@"photolike"];
    }
    if (self.photoCommentFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.photoComment] forKey:@"photocomment"];
    }
    if (self.albumLikeFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.albumLike] forKey:@"albumlike"];
        
    }
    if (self.userFollowFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.userFollow] forKey:@"userfollow"];
        
    }
    if (self.timelinePopupFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.timelinePopup] forKey:@"timlinepopup"];
        
    }
    if (self.fullname !=nil) {
        [dictionary setValue:self.fullname forKey:@"fullname"];
    }
    if (self.nickname !=nil) {
        [dictionary setValue:self.nickname forKey:@"nickname"];
    }
    if (self.username !=nil) {
        [dictionary setValue:self.username forKey:@"username"];
    }
    if (self.password !=nil) {
        [dictionary setValue:self.password forKey:@"password"];
    }
    if (self.description !=nil) {
        [dictionary setValue:self.description forKey:@"description"];
    }
    if (self.emailNotificationFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.emailNotification] forKey:@"emailNotification"];
    }
    if (self.pushNotificationFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.pushNotification] forKey:@"pushNotification"];
    }
    if (self.facebookTimelineFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.facebookTimeline] forKey:@"facebookTimeline"];
    }
    if (self.friend_id !=nil) {
        [dictionary setValue:self.friend_id forKey:@"friend_id"];
    }
    if (self.keysFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.keys] forKey:@"keys"];
    }
    if (self.oauth_token != nil) {
        [dictionary setValue:self.oauth_token forKey:@"oauth_token"];
    }
    if (self.oauth_token_secret != nil) {
        [dictionary setValue:self.oauth_token_secret forKey:@"oauth_token_secret"];
    }
    if (self.service_user_id > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.service_user_id] forKey:@"service_user_id"];
    }
    if (self.service_screen_name != nil) {
        [dictionary setValue:self.service_screen_name forKey:@"service_screen_name"];
    }
    if (self.followFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.follow] forKey:@"follow"];
    }
    if (self.callbackFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.callback] forKey:@"callback"];
    }
    if (self.connectFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.connect] forKey:@"connect"];
    }

    return [NSDictionary dictionaryWithDictionary:dictionary];
}
-(void) setSuggested:(BOOL)suggested
{
    _suggested = suggested;
    self.suggestedFlag =YES;
    
}
-(void) setUpload:(BOOL)upload
{
    _upload = upload;
    self.uploadFlag = YES;
}
-(void) setPhotoLike:(BOOL)photoLike
{
    _photoLike = photoLike;
    self.photoLikeFlag = YES;
}
-(void) setPhotoComment:(BOOL)photoComment
{
    _photoComment = photoComment;
    self.photoCommentFlag = YES;
}

-(void) setAlbumLike:(BOOL)albumLike
{
    _albumLike = albumLike;
    self.albumLikeFlag = YES;
}

-(void) setUserFollow:(BOOL)userFollow
{
    _userFollow = userFollow;
    self.userFollowFlag = YES;
}


-(void) setTimelinePopup:(BOOL)timelinePopup
{
    _timelinePopup = timelinePopup;
    self.timelinePopupFlag = YES;
}
-(void) setEmailNotification:(BOOL)emailNotification
{
    
    _emailNotification = emailNotification;
    self.emailNotificationFlag = YES;
}
-(void) setPushNotification:(BOOL)pushNotification
{
    
    _pushNotification = pushNotification;
    self.pushNotificationFlag = YES;
}
-(void) setFacebookTimeline:(BOOL)facebookTimeline
{
    
    _facebookTimeline = facebookTimeline;
    self.facebookTimelineFlag = YES;
}
-(void) setKeys:(BOOL)keys
{
    
    _keys = keys;
    self.keysFlag = YES;
}
-(void) setFollow:(BOOL)follow
{
    
    _follow = follow;
    self.followFlag = YES;
}
-(void) setCallback:(BOOL)callback
{
    
    _callback = callback;
    self.callbackFlag = YES;
}
-(void) setConnect:(BOOL)connect
{
    
    _connect = connect;
    self.connectFlag = YES;
}
@end
