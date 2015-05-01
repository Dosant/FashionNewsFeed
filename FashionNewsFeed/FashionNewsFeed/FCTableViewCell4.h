//
//  FCTableViewCell4.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 30.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCFeaturedImage.h"
#import "FCCategory.h"
#import "FCPost.h"
#import "newsFeaturedImageView.h"

@interface FCTableViewCell4 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *FCCellTitle;


@property (weak, nonatomic) IBOutlet UIImageView *FCCellFeaturedImage;
@property (weak, nonatomic) IBOutlet UILabel *FCCellCategory;
@property (weak, nonatomic) IBOutlet UILabel *FCCellDate;




@property(strong,nonatomic) FCPost* post;

- (void) setPostTitle:(NSString *)postTitle
             postDate:(NSDate *)postDate
    postFeaturedImage:(FCFeaturedImage *)postFeaturedImage
         postCategory:(FCCategory*)postCategory;


@end