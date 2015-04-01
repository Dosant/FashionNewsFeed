//
//  NewsAPI.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 01.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

/*
 Connetction point between all UI and Network-Storage
 
*/

#import <Foundation/Foundation.h>



@interface NewsAPI : NSObject

+(NewsAPI *)sharedInstance;


- (NSArray *)getCategories;


/*
- (void)addNewsItem:(NewsItem *)newsItem;
- (void)saveNews;
 
- (NewsItem *)getNewsItemWithId:(NSUInteger)id;
*/


@end
