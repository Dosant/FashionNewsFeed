//
//  FCPost.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "FCPost.h"

@implementation FCPost



-(id)initWithContentAndId:(NSString *)content postId:(NSUInteger)postId
{
    self = [super init];
    if (self) {
        self.postContentString = content;
        self.postId = postId;
    }
    return self;
}

@end
