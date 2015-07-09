//
//  ImageTransformUtility.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 31.05.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "ImageTransformUtility.h"
#import <UIKit/UIKit.h>
static CGFloat maxWidth = 400;

@implementation ImageTransformUtility

-(UIImage*)transformImageFromJpgToPng:(UIImage*)image{
    //
    return nil;
    
}

-(UIImage*)resizeImage:(UIImage*)imageToResize{
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

-(UIImage*)DarkenImage:(UIImage*)imageToDarken{
  UIGraphicsBeginImageContextWithOptions(imageToDarken.size, false, 1.0);
  [imageToDarken drawInRect:CGRectMake(0,0,imageToDarken.size.width,imageToDarken.size.height)];
  
  //// General Declarations
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  //// Color Declarations
  UIColor* gradientColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.673];
  
  //// Gradient Declarations
  CGFloat gradientLocations[] = {0.49, 0.8, 1};
  CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)UIColor.clearColor.CGColor, (id)UIColor.clearColor.CGColor, (id)gradientColor.CGColor], gradientLocations);
  
  //// Rectangle Drawing
  UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0,0, imageToDarken.size.width, imageToDarken.size.height)];
  CGContextSaveGState(context);
  [rectanglePath addClip];
  CGContextDrawLinearGradient(context, gradient, CGPointMake(imageToDarken.size.width/2, imageToDarken.size.height/2), CGPointMake(imageToDarken.size.width/2, imageToDarken.size.height), 0);
  
  CGContextRestoreGState(context);
  
  
  //// Cleanup
  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
  UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return [UIImage imageWithData:UIImagePNGRepresentation(newImage)];
  
  
}



@end
