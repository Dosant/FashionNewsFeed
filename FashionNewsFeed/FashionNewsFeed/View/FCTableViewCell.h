//
//  FCTableViewCell.h
//  FashionNewsFeed
//
//  Created by Владислав Станишевский on 10.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCAuthor.h"
#import "FCFeaturedImage.h"
#import "FCTerms.h"


@interface FCTableViewCell : UITableViewCell



- (void) setPostTitle:(NSString *)postTitle
           postAuthor:(FCAuthor *)postAuthor
             postDate:(NSDate *)postDate
     postDateModified:(NSDate *)postDateModified
          postExcerpt:(NSString *)postExcerpt
             postMeta:(NSMutableDictionary *)postMeta
    postFeaturedImage:(FCFeaturedImage *)postFeaturedImage
            postTerms:(FCTerms *)postTerms;

@end
