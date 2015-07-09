//
//  ImageDownloder.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 17.06.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageRecord.h"



@interface ImageDownloader : NSOperation
@property (nonatomic, strong) ImageRecord *imageRecord;
// 4: Declare a designated initializer.
- (instancetype)initWithImageRecord:(ImageRecord *)record
                            success:(void(^)(NSURLSessionDataTask* task, UIImage* image))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end

