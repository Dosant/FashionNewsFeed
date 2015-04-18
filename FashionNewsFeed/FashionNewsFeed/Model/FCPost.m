//
//  FCPost.m
//  FashionNewsFeed
//

#import "FCPost.h"

@implementation FCPost

- (instancetype)initPostWithId:(NSUInteger)postId
                      andTitle:(NSString *)postTitle
                     andAuthor:(FCAuthor *)postAuthor
                    andContent:(NSString *)postContent
                       andLink:(NSString *)postLink
                       andDate:(NSDate *)postDate
               andDateModified:(NSDate *)postDateModified
                    andExcerpt:(NSString *)postExcerpt
                       andMeta:(NSMutableDictionary *)postMeta
              andFeaturedImage:(FCFeaturedImage *)postFeaturedImage
                      andTerms:(FCTerms *)postTerms
{
    self = [super init];
    if (self) {
        self.postId = postId;
        self.postTitle = postTitle;
        self.postAuthor = postAuthor;
        self.postContent = postContent;
        self.postLink = postLink;
        self.postDate = postDate;
        self.postDateModified = postDateModified;
        self.postExcerpt = postExcerpt;
        self.postMeta = postMeta;
        self.postFeaturedImage = postFeaturedImage;
        self.postTerms = postTerms;
    }
    return self;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.postId = (NSUInteger)[[attributes valueForKeyPath:@"id"] integerValue]; self.postTitle = [attributes valueForKeyPath:@"text"];
        self.postAuthor = [[FCAuthor alloc] initWithAttributes:[attributes valueForKeyPath:@"user"]];;
        self.postContent = [attributes valueForKeyPath:@"text"];
        self.postLink = [attributes valueForKeyPath:@"text"];
        self.postDate = [attributes valueForKeyPath:@"text"];
        self.postDateModified = [attributes valueForKeyPath:@"text"];
        self.postExcerpt = [attributes valueForKeyPath:@"text"];
        self.postMeta = [attributes valueForKeyPath:@"text"];
        self.postFeaturedImage = [[FCFeaturedImage alloc] initWithAttributes:[attributes valueForKeyPath:@"user"]];;
        self.postTerms = [[FCTerms alloc] initWithAttributes:[attributes valueForKeyPath:@"user"]];;
    }
    return self;
}

@end
