//
//  newsFeaturedImageView.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 20.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "newsFeaturedImageView.h"

@implementation newsFeaturedImageView{
    
    CAShapeLayer* littleTriangle;
    
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    
    
    if (!littleTriangle){
        CGRect triFrame = CGRectMake(40, self.frame.size.height - 20, 20, 20);
        
        //// Polygon Drawing
        UIBezierPath* polygonPath = UIBezierPath.bezierPath;
        [polygonPath moveToPoint: CGPointMake(20, 20)];
        [polygonPath addLineToPoint: CGPointMake(0, 20)];
        [polygonPath addLineToPoint: CGPointMake(10, 8)];
        [polygonPath closePath];
        
        littleTriangle = [[CAShapeLayer alloc] init];
        littleTriangle.frame = triFrame;
        littleTriangle.path = [polygonPath CGPath];
        littleTriangle.fillColor = [[UIColor whiteColor] CGColor];
        
        [[self layer] addSublayer:littleTriangle];
        

        
        
    }
}

@end
