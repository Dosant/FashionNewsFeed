//
//  PersistencyManager.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 01.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

/*
 Caсhe logic
 CoreData
*/



#import <Foundation/Foundation.h>

@interface PersistencyManager : NSObject

@property (strong, nonatomic) NSArray * categoriesList;
@property (strong, nonatomic) NSMutableArray *arrayOfPost;

//This methods added to MutableArray inf in current post

- (BOOL)addCategory:(NSString *)category;
- (void)addTag:(NSString *)tag;
- (void)addAttachment:(id) attachment;

//This methods get inf from current post

- (NSArray *)getCurrentPostCategories;
- (NSArray *)getCurrentPostTags;
- (id)getCurrentPostAttachments;

@end
