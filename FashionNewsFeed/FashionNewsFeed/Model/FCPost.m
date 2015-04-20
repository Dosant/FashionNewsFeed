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
                      andTerms:(FCTerms *)postTerms {
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

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.postId = (NSUInteger) [[attributes valueForKeyPath:@"ID"] integerValue];
        self.postTitle = [attributes valueForKeyPath:@"title"];
        self.postAuthor = [[FCAuthor alloc] initWithAttributes:[attributes valueForKeyPath:@"author"]];;
        self.postContent = [attributes valueForKeyPath:@"content"];
        self.postLink = [attributes valueForKeyPath:@"link"];
        self.postDate = [attributes valueForKeyPath:@"date"];
        self.postDateModified = [attributes valueForKeyPath:@"modified"];
        self.postExcerpt = [attributes valueForKeyPath:@"excerpt"];

        NSMutableDictionary *meta = [[NSMutableDictionary alloc] init];
        for (NSString *i in [attributes valueForKeyPath:@"meta"]) {
            id v = [[attributes valueForKeyPath:@"meta"] objectForKey:i];
            for (NSString *k in v) {
                id value = [v objectForKey:k];
                meta[k] = value;
            }
        }
        self.postMeta = meta;

        self.postFeaturedImage = [[FCFeaturedImage alloc] initWithAttributes:[attributes valueForKeyPath:@"featured_image"]];
        self.postTerms = [[FCTerms alloc] initWithAttributes:[attributes valueForKeyPath:@"terms"]];;
    }
    return self;
}

@end
