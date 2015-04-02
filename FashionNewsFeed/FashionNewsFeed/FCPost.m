//
//  FCPost.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "FCPost.h"
#import "PersistencyManager.h"


@implementation FCPost

- (instancetype)initPostWithId:(NSUInteger)postId
                          type:(NSString *)postType
                     urlString:(NSURL *)postUrlString
                         title:(NSString *)postTitle
                 contentString:(NSString *)postContentString
                    dateString:(NSDate *)postDateString
{
    self = [super init];
    if (self) {
        
        self.postId = postId;
        self.postType = postType;
        self.postUrlString = postUrlString;
        self.postTitle = postTitle;
        self.postContentString = postContentString;
        self.postDateString = postDateString;
    }
    return self;
}

#pragma mark - addOtherInPost

- (BOOL)addCategory:(NSString *)category {
    
    PersistencyManager *manager = [[PersistencyManager alloc] init];
    
    if (![[manager categoriesList] containsObject: category]) {
        
        return NO;
    }
    
    [self.postCategories addObject: category];
    
    return YES;
}

- (void)addTag:(NSString *)tag {
    
    [self.postTags addObject: tag];
}

- (void)addAttachment:(id) attachment {
    
    [self.postAttachments addObject: attachment];
}

#pragma mark - getOtherInPost

- (NSArray *)getCurrentPostCategories {
    
    return self.postCategories;
}

- (NSArray *)getCurrentPostTags {
    
    return self.postTags;
}

- (id)getCurrentPostAttachments {
    
    return nil;
}

@end
