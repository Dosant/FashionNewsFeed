//
//  FCCategory.h
//  FashionNewsFeed
//
//  Created by Anton Chugunov on 27.03.15.
//  Copyright (c) 2015 Anton Chugunov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCCategory : NSObject

@property (assign, nonatomic) NSUInteger categoryId;
@property (strong, nonatomic) NSString* categoryName;

- (id)initWithName:(NSString *)categoryName andCategoryId:(NSUInteger)categoryId;

@end