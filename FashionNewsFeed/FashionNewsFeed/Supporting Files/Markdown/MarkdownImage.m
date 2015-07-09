//
//  MarkdownImage.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 12.05.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "MarkdownImage.h"

@implementation MarkdownImage

- (instancetype)initWithImageUrl:(NSURL*)url
                 placeholderSize:(CGSize)size
                           index:(NSUInteger)index
{
    self = [super init];
    if (self) {
        
        self.url = url;
        self.size = size;
        self.index = index;
        
    }
    return self;
}

@end
