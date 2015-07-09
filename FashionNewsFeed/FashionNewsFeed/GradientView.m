//
//  gradientView.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.06.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

- (instancetype)initWithFrame:(CGRect)frame
                   percentage:(CGFloat)percentage
{
  self = [super initWithFrame:frame];
  if (self) {
    self.percentage = percentage;
    self.color = [UIColor blackColor];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                   percentage:(CGFloat)percentage
                        color:(UIColor*)color
{
  self = [super initWithFrame:frame];
  if (self) {
    self.percentage = percentage;
    self.color = color;
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    self.percentage = 1.0;
    self.color = [UIColor blackColor];
  }
  return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  
  [super drawRect:rect];
  
  NSLog(@"PAINt!");
  
  
  //// General Declarations
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  //// Color Declarations
  UIColor* gradientColor = [UIColor colorWithWhite:1.0 alpha:1.0];
  UIColor* midColor = [UIColor colorWithWhite:1.0 alpha:0.5];
  UIColor* finalColor = [UIColor colorWithWhite:1.0 alpha:0.0];
  
  //// Gradient Declarations
  CGFloat gradientLocations[] = {0.0,1.0};
  CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)finalColor.CGColor,(id)gradientColor.CGColor], gradientLocations);
  
  //// Rectangle Drawing
  UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rect];
  CGContextSaveGState(context);
  [rectanglePath addClip];
  CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.size.width/2, 0), CGPointMake(rect.size.width/2, rect.size.height), 0);
  
  CGContextRestoreGState(context);
  
  
  //// Cleanup
  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);

  
}


@end
