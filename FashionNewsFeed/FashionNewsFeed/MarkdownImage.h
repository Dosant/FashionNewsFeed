//
//  MarkdownImage.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 12.05.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarkdownImage : NSObject

@property (nonatomic,copy) NSURL* url;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) NSUInteger index;

- (instancetype)initWithImageUrl:(NSURL*)url
                 placeholderSize:(CGSize)size
                           index:(NSUInteger)index;


@end
