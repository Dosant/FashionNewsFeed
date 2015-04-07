//
//  NavigationBarWithBottomStroke.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 03.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "NavigationBarWithBottomStroke.h"

@implementation NavigationBarWithBottomStroke

-(void) layoutSubviews{
    [super layoutSubviews];
    
    CGRect navFrame = self.frame;
    CGRect newFrame = CGRectMake(navFrame.origin.x, navFrame.origin.y, navFrame.size.width, 38.0);
    self.frame = newFrame;
    
    UIView* bottomStroke = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.frame.size.height - 2, self.frame.size.width, 2.0)];
    bottomStroke.backgroundColor = [UIColor blackColor];
    [self addSubview:bottomStroke];
    
    
}

@end
