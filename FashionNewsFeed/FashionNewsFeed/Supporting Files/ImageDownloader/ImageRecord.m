//
//  ImageRecord.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 17.06.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "ImageRecord.h"

@implementation ImageRecord


- (instancetype)initWithURL:(NSURL*)url
{
    self = [super init];
    if (self) {
      self.URL = url;
      
      // Ask CoreData if there an image with this URL.
      
    }
    return self;
}

- (BOOL)hasImage {
  return _image != nil;
}


- (BOOL)isFailed {
  return _failed;
}


- (BOOL)isResized {
  return _resized;
}

@end
