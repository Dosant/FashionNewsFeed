//
//  FCCategory.h
//  FashionNewsFeed
//
//  Created by Anton Chugunov on 27.03.15.
//  Copyright (c) 2015 Anton Chugunov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCCategory : NSObject {
    NSUInteger categoryId;
    NSString* categoryName;
}

@property (nonatomic) NSUInteger categoryId;
@property (strong, nonatomic) NSString* categoryName;

- (id)initWithNameAndId:(NSString*)categoryName categoryId:(NSUInteger)categoryId;

@end