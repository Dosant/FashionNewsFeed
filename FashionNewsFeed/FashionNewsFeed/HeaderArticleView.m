//
//  HeaderArticleView.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.06.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "HeaderArticleView.h"
#import "ImageTransformUtility.h"

@implementation HeaderArticleView

- (instancetype)init
{
  self = [super init];
  if (self) {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"HeaderArticleView" owner:self options:nil];
    id mainView = [subviewArray objectAtIndex:0];
    
    return mainView;
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                 articleTitle:(NSString*)title
                 articleImage:(UIImage*)image
            articleCategories:(NSString*)categories
{
  self = [super initWithFrame:frame];
  if (self) {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"HeaderArticleView" owner:self options:nil];
    HeaderArticleView* mainView = [subviewArray objectAtIndex:0];
    
    mainView.articleTittle.text = title;
    mainView.articleCategories.text = categories;
    
    if(image != nil){
      
      //ImageTransformUtility* it = [[ImageTransformUtility alloc] init];
      //mainView.articleImage.image = [it DarkenImage:image];
      
      mainView.articleImage.image = image;
    } else {
      mainView.articleImage.image = [UIImage imageNamed:@"FCollectionPH"];
    }
    
    mainView.frame = frame;
    return mainView;
  }
  return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews{
  [super layoutSubviews];
  /*
  CAGradientLayer* gl = [CAGradientLayer layer];
  gl.frame = self.articleImage.frame;
  UIColor *colorOne = [UIColor blackColor];
  UIColor *colorTwo = [UIColor clearColor];
  
  
  NSArray *colors =  [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
  
  NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
  NSNumber *stopTwo = [NSNumber numberWithFloat:0.5];
  
  
  NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
  
  gl.colors = colors;
  gl.locations = locations;
  
  [self.articleImage.layer addSublayer:gl];
   */
  
}

@end
