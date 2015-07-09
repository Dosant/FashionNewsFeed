//
//  ImageRecord.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 17.06.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ImageRecord : NSObject


@property (nonatomic, strong) UIImage *image; // To store the actual image
@property (nonatomic, strong) NSURL *URL; // To store the URL of the image
@property (nonatomic, readonly) BOOL hasImage; // Return YES if image is downloaded.
@property (nonatomic, getter = isResized) BOOL resized; // Return YES if image is sepia-filtered
@property (nonatomic, getter = isFailed) BOOL failed; // Return Yes if image failed to be downloaded

- (instancetype)initWithURL:(NSURL*)url;



@end
