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

// Имхо лучше здесь у всех пропертис в начале в название "post". чтобы сразу автокомплитом видеть все поля, а не бегать по ним и искать.. тут их реально много.
// У некоторых дописанно String -- так лучше, потому что в итоге url будет NSURL, а date -- NSDate. чтобы не запутаться
// Ну и инит тут будет понятно всеми полями. Или лучше инитить передавать Dictionary, который получиться при парсе json

@interface FCPost : NSObject

@property(nonatomic) NSUInteger postId;
@property(strong, nonatomic) NSString* postType;
@property(strong, nonatomic) NSString* postUrlString;
@property(strong, nonatomic) NSString* postTitle;
@property(strong, nonatomic) NSString* postContentString;
@property(strong, nonatomic) NSString* postDateString;

@property(strong, nonatomic) NSArray* postCategories;
@property(strong, nonatomic) NSArray* postTags;
@property(strong, nonatomic) NSArray* postAttachments;

- (id)initWithContentAndId:(NSString*)content postId:(NSUInteger)postId;

@end
