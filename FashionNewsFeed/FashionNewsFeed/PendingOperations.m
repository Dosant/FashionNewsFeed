//
//  PendingOperations.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 17.06.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "PendingOperations.h"

@implementation PendingOperations


- (NSMutableDictionary *)downloadsInProgress {
  if (!_downloadsInProgress) {
    _downloadsInProgress = [[NSMutableDictionary alloc] init];
  }
  return _downloadsInProgress;
}

- (NSOperationQueue *)downloadQueue {
  if (!_downloadQueue) {
    _downloadQueue = [[NSOperationQueue alloc] init];
    _downloadQueue.name = @"Download Queue";
    
  }
  return _downloadQueue;
}


@end
