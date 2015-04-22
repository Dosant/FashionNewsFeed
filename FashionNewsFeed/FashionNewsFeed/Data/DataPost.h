//
//  DataPost.h
//  FashionNewsFeed
//
//  Created by Владислав Станишевский on 22.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DataAuthor, DataTerms;

@interface DataPost : NSManagedObject

@property (nonatomic, retain) NSString * postContent;
@property (nonatomic, retain) NSDate * postDate;
@property (nonatomic, retain) NSDate * postDateModified;
@property (nonatomic, retain) NSString * postExcerpt;
@property (nonatomic, retain) NSNumber * postId;
@property (nonatomic, retain) NSString * postLink;
@property (nonatomic, retain) NSString * postTitle;
@property (nonatomic, retain) DataAuthor *author;
@property (nonatomic, retain) DataTerms *term;

@end
