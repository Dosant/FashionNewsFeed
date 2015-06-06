//
//  ImageTransformUtility.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 31.05.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "ImageTransformUtility.h"

static CGFloat maxWidth = 400;

@implementation ImageTransformUtility

+(UIImage*)transformImageFromJpgToPng:(UIImage*)image{
    //
    return nil;
    
}

+(UIImage*)resizeImage:(UIImage*)imageToResize{
    maxWidth = [UIScreen mainScreen].bounds.size.width;
    
    
    if(imageToResize.size.width <= maxWidth){
        return imageToResize;
    }
    
    CGFloat aspR = imageToResize.size.width / imageToResize.size.height;
    CGFloat nWidth = maxWidth;
    CGFloat nHeight = maxWidth/aspR;
    CGSize newSize = CGSizeMake(nWidth, nHeight);
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0);
    [imageToResize drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIImage imageWithData:UIImagePNGRepresentation(newImage)];
    
}



@end
