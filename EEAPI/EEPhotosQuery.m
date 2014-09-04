//
//  EEPhotosQuery.m
//  EEAPI
//
//  Created by Sebastian Kießling on 25.09.12.
//  Copyright (c) 2012 EyeEm. All rights reserved.
//

#import "EEPhotosQuery.h"

@implementation EEPhotosQuery
- (id)init
{
    self = [super init];
    if (self) {

        self.commentNumber = -1;
        self.likerNumber = -1;
        self.specificEndpoint = EEspecificPhotosEndpointNothing;

    }
    return self;
}

-(NSDictionary*) createDictionary
{
    self.generalEndpointString = @"/photos";
    if (self.specificEndpoint != EEspecificPhotosEndpointNothing) {
        switch (self.specificEndpoint) {

            case EEspecificPhotosEndpointDiscover:
                self.specificEndpointString = @"/discover";
                break;

            case EEspecificPhotosEndpointTopics:
                self.specificEndpointString = @"/topics";
                if (self.name == nil)
                {
                    NSAssert(NO, @"The parameter name is required!");
                }
                break;

            case EEspecificPhotosEndpointShare:
                self.specificEndpointString = @"/share";
                if (self.services == nil)
                {
                    NSAssert(NO, @"The parameter services is required!");
                }
                break;
            case EEspecificPhotosEndpointHide:
                self.specificEndpointString = @"/hide";
                break;
            case EEspecificPhotosEndpointLikers:
                self.specificEndpointString = @"/likers";
                break;
            case EEspecificPhotosEndpointComments:
                self.specificEndpointString = @"/comments";

                break;
            case EEspecificPhotosEndpointAlbums:
                self.specificEndpointString = @"/albums";
                break;
            case EEspecificPhotosEndpointFlags:
                if (self.offense == nil)
                {
                    NSAssert(NO, @"The parameter offense is required!");
                }
                self.specificEndpointString = @"/flags";
                break;
            case EEspecificPhotosEndpointBgImages:
                self.specificEndpointString = @"/bgImages";
                break;


            default:
                break;
        }
    }
#ifdef DEBUG 
    else if (self.firstId <= 0 && self.type == nil && self.ids == nil)
    {
        NSAssert(NO, @"One of the following parameters is required:type, ids!");
    }
#endif
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[super createDictionary]];
    
    
    if (self.commentsFlag) {
        [dictionary setValue:[NSNumber numberWithBool:self.comments] forKey:@"includeComments"];
    }
    
    if (self.likersFlag) {
        
        
        [dictionary setValue:[NSNumber numberWithBool:self.likers] forKey:@"includeLikers"];
    }
    
    if (self.commentNumber > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.commentNumber] forKey:@"numComments"];
    }
    if (self.likerNumber > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.likerNumber] forKey:@"numLikers"];
    }
    if (self.albumId > 0) {
        [dictionary setValue:[NSNumber numberWithInteger:self.albumId] forKey:@"albumId"];
    }

    if (self.hideFlag ) {
        
        [dictionary setValue:[NSNumber numberWithBool:self.hide] forKey:@"hide"];
    }
    if (self.offense !=nil) {
        [dictionary setValue:self.offense forKey:@"offense"];
    }
    if (self.caption !=nil) {
        [dictionary setValue:self.caption forKey:@"caption"];
    }
    if (self.title !=nil) {
        [dictionary setValue:self.title forKey:@"title"];
    }
    
    
    
    
    return [NSDictionary dictionaryWithDictionary:dictionary];
}
-(void) setComments:(BOOL)comments
{
    _comments = comments;
    self.commentsFlag =YES;
    
}
-(void) setLikers:(BOOL)likers
{
    _likers = likers;
    self.likersFlag =YES;
    
}
-(void) setHide:(BOOL)hide
{
    _hide = hide;
    self.hideFlag =YES;
    
}
@end
