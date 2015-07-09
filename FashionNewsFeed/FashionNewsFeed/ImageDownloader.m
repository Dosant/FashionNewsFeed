//
//  ImageDownloder.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 17.06.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "ImageDownloader.h"
#import "ImageTransformUtility.h"

@implementation ImageDownloader {
  void(^_success)(NSURLSessionDataTask* task, UIImage* image);
  void (^_failure)(NSURLSessionDataTask *task, NSError *error);
}


- (id)initWithImageRecord:(ImageRecord *)record
                  success:(void(^)(NSURLSessionDataTask* task, UIImage* image))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
 {
  
  if (self = [super init]) {
    // 2: Set the properties.
    
    self.imageRecord = record;
    _success = success;
    _failure = failure;
  }
  return self;
}


#pragma mark -
#pragma mark - Downloading image

// 3: Regularly check for isCancelled, to make sure the operation terminates as soon as possible.
- (void)main {
  
  // 4: Apple recommends using @autoreleasepool block instead of alloc and init NSAutoreleasePool, because blocks are more efficient. You might use NSAuoreleasePool instead and that would be fine.
  @autoreleasepool {
    
    if (self.isCancelled)
      return;
    
  
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.imageRecord.URL];
    
    if (self.isCancelled) {
      imageData = nil;
      return;
    }
    
    if (imageData) {
      UIImage *downloadedImage = [UIImage imageWithData:imageData];
      self.imageRecord.image = downloadedImage;
      NSLog(@"Downloaded Image for url %@",self.imageRecord.URL);
    }
    else {
      NSLog(@"Couldn't download");
      self.imageRecord.failed = YES;
      dispatch_block_t block = ^{
        

        NSError* error = [NSError errorWithDomain:@"io.dosov.fashion" code:305 userInfo:@{@"Error reason": @"Unable to Download"}];
        _failure(nil,error);
        _failure= nil;
      };
      dispatch_sync(dispatch_get_main_queue(), block);
      return;

    }
    
    imageData = nil;
    
    if (self.isCancelled)
      return;
    
    ImageTransformUtility* imageResizer = [[ImageTransformUtility alloc] init];
    UIImage* resizedImage = [imageResizer resizeImage:self.imageRecord.image];
    self.imageRecord.image = resizedImage;
    
    if (self.isCancelled)
      return;
    
    dispatch_block_t block = ^{
      _success(nil,self.imageRecord.image);
      _success = nil;
    };
    
    dispatch_sync(dispatch_get_main_queue(), block);
    
    NSLog(@"exit main");
    
  }
}


@end
