//
//  HeaderArticleView.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.06.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderArticleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *articleTittle;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *articleCategories;


- (instancetype)initWithFrame:(CGRect)frame
                 articleTitle:(NSString*)title
                 articleImage:(UIImage*)image
                 articleCategories:(NSString*)categories;
@end
