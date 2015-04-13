//
//  DataTerms.h
//  FashionNewsFeed
//
//  Created by Владислав Станишевский on 13.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DataCategory, DataPost, DataPostTag;

@interface DataTerms : NSManagedObject

@property (nonatomic, retain) NSString * termsCategory;
@property (nonatomic, retain) NSNumber * termsId;
@property (nonatomic, retain) NSString * termsPostTag;
@property (nonatomic, retain) NSSet *categories;
@property (nonatomic, retain) DataPost *post;
@property (nonatomic, retain) NSSet *postTags;
@end

@interface DataTerms (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(DataCategory *)value;
- (void)removeCategoriesObject:(DataCategory *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

- (void)addPostTagsObject:(DataPostTag *)value;
- (void)removePostTagsObject:(DataPostTag *)value;
- (void)addPostTags:(NSSet *)values;
- (void)removePostTags:(NSSet *)values;

@end
