//
//  PersistencyManager.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 01.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "PersistencyManager.h"

@implementation PersistencyManager


- (id)init
{
    self = [super init];
    if (self)
    {
        self.categoriesList = @[@"news", @"fashion",@"collections",@"people",@"beaty"];
    }
    return self;
}




@end
