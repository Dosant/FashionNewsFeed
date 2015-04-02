//
//  FashionCollectionAPI.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 01.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

// Connetction point between all UI and Network-Storage


#import <Foundation/Foundation.h>
#import "FCPost.h"

@interface FashionCollectionAPI : NSObject

+ (FashionCollectionAPI *)sharedInstance;

- (NSArray *)getCategories;
- (void)addNewsItem:(FCPost *)newsItem;
- (FCPost *)getNewsItemWithId:(NSUInteger)id;

//- (void)saveNews;

@end
