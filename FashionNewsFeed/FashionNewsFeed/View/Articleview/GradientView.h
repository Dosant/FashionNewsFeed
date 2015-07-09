//
//  gradientView.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.06.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientView : UIView

@property (assign,nonatomic) CGFloat percentage;
@property (strong,nonatomic) UIColor* color;

- (instancetype)initWithFrame:(CGRect)frame
                   percentage:(CGFloat)percentage;

- (instancetype)initWithFrame:(CGRect)frame
                   percentage:(CGFloat)percentage
                        color:(UIColor*)color;



@end
