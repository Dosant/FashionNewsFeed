//
//  PendingOperations.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 17.06.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PendingOperations : NSObject

@property (nonatomic, strong) NSMutableDictionary *downloadsInProgress;
@property (nonatomic, strong) NSOperationQueue *downloadQueue;

@end
