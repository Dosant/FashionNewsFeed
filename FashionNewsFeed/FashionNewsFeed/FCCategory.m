//
//  FCCategory.m
//  FashionNewsFeed
//
//  Created by Anton Chugunov on 27.03.15.
//  Copyright (c) 2015 Anton Chugunov. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "FCCategory.h"



@implementation FCCategory

- (id)initWithName:(NSString *)categoryName andCategoryId:(NSUInteger)categoryId
{
    self = [super init];
    if (self) {
        self.categoryName = categoryName;
        self.categoryId = categoryId;
    }
    return self;
}


@end
