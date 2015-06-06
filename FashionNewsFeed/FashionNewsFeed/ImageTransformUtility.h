//
//  ImageTransformUtility.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 31.05.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTransformUtility : NSObject

+(UIImage*)transformImageFromJpgToPng:(UIImage*)image;
+(UIImage*)resizeImage:(UIImage*)imageToResize;

@end
