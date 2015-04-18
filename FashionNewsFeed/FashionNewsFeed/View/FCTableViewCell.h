//
//  FCTableViewCell.h
//  FashionNewsFeed
//
//  Created by Владислав Станишевский on 10.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCFeaturedImage.h"
#import "FCCategory.h"
#import "FCPost.h"



@interface FCTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *FCCellTitle;

@property (weak, nonatomic) IBOutlet UILabel *FCCellCategoryAndDate;

@property (weak, nonatomic) IBOutlet UIImageView *FCCellFeaturedImage;

@property(strong,nonatomic) FCPost* post;

- (void) setPostTitle:(NSString *)postTitle
             postDate:(NSDate *)postDate
    postFeaturedImage:(FCFeaturedImage *)postFeaturedImage
         postCategory:(FCCategory*)postCategory;

@end
