//
//  FCTableViewCell.m
//  FashionNewsFeed
//
//  Created by Владислав Станишевский on 10.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "FCTableViewCell.h"


@interface FCTableViewCell ()

/*@property (strong, nonatomic) NSString *postTitle;
@property (strong, nonatomic) FCAuthor *postAuthor;
@property (strong, nonatomic) NSDate   *postDate;
@property (strong, nonatomic) NSDate   *postDateModified;
@property (strong, nonatomic) NSString *postExcerpt;
@property (strong, nonatomic) NSMutableDictionary *postMeta;
@property (strong, nonatomic) FCFeaturedImage     *postFeaturedImage;
@property (strong, nonatomic) FCTerms             *postTerms;*/

@end

@implementation FCTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        self.textLabel.textColor = [UIColor whiteColor];
    } else {
        self.textLabel.textColor = [UIColor blackColor];
    }
}

- (void) setPostTitle:(NSString *)postTitle
           postAuthor:(FCAuthor *)postAuthor
             postDate:(NSDate *)postDate
     postDateModified:(NSDate *)postDateModified
          postExcerpt:(NSString *)postExcerpt
             postMeta:(NSMutableDictionary *)postMeta
    postFeaturedImage:(FCFeaturedImage *)postFeaturedImage
            postTerms:(FCTerms *)postTerms {
    
    /*self.postTitle = postTitle;
    self.postAuthor = postAuthor;
    self.postDate = postDate;
    self.postDateModified = postDateModified;
    self.postExcerpt = postExcerpt;
    self.postMeta = postMeta;
    self.postFeaturedImage = postFeaturedImage;
    self.postTerms = postTerms;*/
    
    UILabel *category = [[UILabel alloc] initWithFrame: CGRectMake(10, 10, self.frame.size.width - 10, 10)];
    category.textAlignment = NSTextAlignmentLeft;
    category.font = [UIFont fontWithName: @"GillSans-LightItalic" size: 13.0];
    category.text = @"Новости";
    category.textColor = [UIColor grayColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame: CGRectMake(0, 35, self.frame.size.width, 25)];
    title.lineBreakMode = NSLineBreakByWordWrapping;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName: @"IowanOldStyle-Italic" size: 18.0];
    title.text = postTitle;

    UILabel *author = [[UILabel alloc] initWithFrame: CGRectMake(10, 75, self.frame.size.width, 25)];
    author.textAlignment = NSTextAlignmentLeft;
    author.font = [UIFont fontWithName: @"HelveticaNeue-Medium" size: 13.0];
    author.textColor = [UIColor grayColor];
    author.text = @"FCollection - 10 часов назад";

    [self.contentView addSubview: title];
    [self.contentView addSubview: category];
    [self.contentView addSubview: author];
    
}



@end
