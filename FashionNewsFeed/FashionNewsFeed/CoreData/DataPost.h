//
//  DataPost.h
//  FashionNewsFeed
//
//  Created by Владислав Станишевский on 5/23/15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DataAuthor, DataFeaturedImage, DataTerms;

@interface DataPost : NSManagedObject

@property (nonatomic, retain) NSDate * postDate;
@property (nonatomic, retain) NSDate * postDateModified;
@property (nonatomic, retain) NSString * postExcerpt;
@property (nonatomic, retain) NSNumber * postId;
@property (nonatomic, retain) NSString * postLink;
@property (nonatomic, retain) NSString * postTitle;
@property (nonatomic, retain) NSString * postContent;
@property (nonatomic, retain) DataAuthor *author;
@property (nonatomic, retain) DataTerms *term;
@property (nonatomic, retain) DataFeaturedImage *featuredImage;

@end
