//
//  FCPost.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//


/*
 "id": 1,
 "type": "post",
 "slug": "hello-world",
 "url": "http:\/\/localhost\/wordpress\/?p=1",
 "title": "Hello world!",
 "title_plain": "Hello world!",
 "content": "<p>Welcome to WordPress. This is your first post. Edit or delete it, then start blogging!<\/p>\n",
 "excerpt": "Welcome to WordPress. This is your first post. Edit or delete it, then start blogging!\n",
 "date": "2009-11-11 12:50:19",
 "modified": "2009-11-11 12:50:19",
 "categories": [],
 "tags": [],
 "attachments" : []
 */

#import <Foundation/Foundation.h>

@interface FCPost : NSObject

@property (assign, nonatomic) NSUInteger postId;
@property (strong, nonatomic) NSString  *postType;
@property (strong, nonatomic) NSURL     *postUrlString;
@property (strong, nonatomic) NSString  *postTitle;
@property (strong, nonatomic) NSString  *postContentString;
@property (strong, nonatomic) NSDate    *postDateString;

@property (strong, nonatomic) NSMutableArray *postCategories;
@property (strong, nonatomic) NSMutableArray *postTags;
@property (strong, nonatomic) NSMutableArray *postAttachments;

- (id)initPostWithId:(NSUInteger)postId
                          type:(NSString *)postType
                     urlString:(NSURL *)postUrlString
                         title:(NSString *)postTitle
                 contentString:(NSString *)postContentString
                    dateString:(NSDate *)postDateString;

//This methods added to MutableArray inf in current post

- (BOOL)addCategory:(NSString *)category;
- (void)addTag:(NSString *)tag;
- (void)addAttachment:(id) attachment;

//This methods get inf from current post

- (NSArray *)getCurrentPostCategories;
- (NSArray *)getCurrentPostTags;
- (id)getCurrentPostAttachments;

@end
