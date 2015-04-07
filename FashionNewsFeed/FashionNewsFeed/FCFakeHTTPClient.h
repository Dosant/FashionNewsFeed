//
//  FCFakeHTTPClient.h
//  FashionNewsFeed
//
//  Created by anch on 4/7/15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCCategory.h"
#import "FCPost.h"
#import "FCAuthor.h"
#import "FCFeaturedImage.h"
#import "FCAttachmentMeta.h"
#import "FCTerms.h"
#import "FCPostTag.h"

@interface FCFakeHTTPClient : NSObject

+ (FCFakeHTTPClient *)sharedInstance;

- (NSMutableArray *)getPosts;
- (NSMutableArray *)getCategories;

@end