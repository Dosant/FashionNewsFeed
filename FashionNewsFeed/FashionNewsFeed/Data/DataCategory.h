//
//  DataCategory.h
//  FashionNewsFeed
//
//  Created by Владислав Станишевский on 22.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DataTerms;

@interface DataCategory : NSManagedObject

@property (nonatomic, retain) NSNumber * categoryCount;
@property (nonatomic, retain) NSNumber * categoryId;
@property (nonatomic, retain) NSString * categoryLink;
@property (nonatomic, retain) NSString * categoryName;
@property (nonatomic, retain) NSString * categoryTitle;
@property (nonatomic, retain) NSSet *term;
@end

@interface DataCategory (CoreDataGeneratedAccessors)

- (void)addTermObject:(DataTerms *)value;
- (void)removeTermObject:(DataTerms *)value;
- (void)addTerm:(NSSet *)values;
- (void)removeTerm:(NSSet *)values;

@end
