//
//  DataPostTag.h
//  FashionNewsFeed
//
//  Created by Владислав Станишевский on 5/23/15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DataTerms;

@interface DataPostTag : NSManagedObject

@property (nonatomic, retain) NSNumber * postTagCount;
@property (nonatomic, retain) NSNumber * postTagId;
@property (nonatomic, retain) NSString * postTagLink;
@property (nonatomic, retain) NSString * postTagName;
@property (nonatomic, retain) NSSet *term;
@end

@interface DataPostTag (CoreDataGeneratedAccessors)

- (void)addTermObject:(DataTerms *)value;
- (void)removeTermObject:(DataTerms *)value;
- (void)addTerm:(NSSet *)values;
- (void)removeTerm:(NSSet *)values;

@end
