//
//  FCPost.m
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>
#import "FCAuthor.h"
#import "FCFeaturedImage.h"
#import "FCTerms.h"

@interface FCPost : NSObject

@property (assign, nonatomic) NSUInteger postId;
@property (strong, nonatomic) NSString *postTitle;
@property (strong, nonatomic) FCAuthor *postAuthor;
@property (strong, nonatomic) NSString *postContent;
@property (strong, nonatomic) NSString *postLink;
@property (strong, nonatomic) NSDate *postDate;
@property (strong, nonatomic) NSDate *postDateModified;
@property (strong, nonatomic) NSString *postExcerpt;
@property (strong, nonatomic) NSMutableDictionary *postMeta;
@property (strong, nonatomic) FCFeaturedImage *postFeaturedImage;
@property (strong, nonatomic) FCTerms *postTerms;

- (id)initPostWithId:(NSUInteger)postId
            andTitle:(NSString *)postTitle
           andAuthor:(FCAuthor *)postAuthor
          andContent:(NSString *)postContent
             andLink:(NSString *)postLink
             andDate:(NSDate *)postDate
     andDateModified:(NSDate *)postDateModified
          andExcerpt:(NSString *)postExcerpt
             andMeta:(NSMutableDictionary *)postMeta
    andFeaturedImage:(FCFeaturedImage *)postFeaturedImage
            andTerms:(FCTerms *)postTerms;

@end