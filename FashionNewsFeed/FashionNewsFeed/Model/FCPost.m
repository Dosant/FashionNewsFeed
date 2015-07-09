//
//  FCPost.m
//  FashionNewsFeed
//

#import "FCPost.h"
#import "FCCategory.h"
#import "NSStringHTML.h"

@implementation FCPost

- (instancetype)initPostWithId:(NSUInteger)postId
                      andTitle:(NSString *)postTitle
                     andAuthor:(FCAuthor *)postAuthor
                    andContent:(NSString *)postContent
                       andLink:(NSURL *)postLink
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
        self.postTitle = [[attributes valueForKeyPath:@"title"] stringByConvertingHTMLToPlainText];
        self.postAuthor = [[FCAuthor alloc] initWithAttributes:[attributes valueForKeyPath:@"author"]];
        self.postContent = [[attributes valueForKeyPath:@"content"] stringByDecodingHTMLEntities];

        NSURL *url = [NSURL URLWithString:[attributes valueForKeyPath:@"link"]];
        self.postLink = url;

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *postDateFromString = [dateFormatter dateFromString:[attributes valueForKeyPath:@"date"]];
        self.postDate = postDateFromString;
        NSDate *postDateModifiedFromString = [dateFormatter dateFromString:[attributes valueForKeyPath:@"modified"]];
        self.postDateModified = postDateModifiedFromString;

        self.postExcerpt = [[attributes valueForKeyPath:@"excerpt"] stringByConvertingHTMLToPlainText];

        NSMutableDictionary *meta = [[NSMutableDictionary alloc] init];
        for (NSString *i in [attributes valueForKeyPath:@"meta"]) {
            id v = [[attributes valueForKeyPath:@"meta"] objectForKey:i];
            for (NSString *k in v) {
                id value = [v objectForKey:k];
                NSURL *url = [NSURL URLWithString:value];
                meta[k] = url;
            }
        }
        self.postMeta = meta;

        self.postFeaturedImage = [[FCFeaturedImage alloc] initWithAttributes:[attributes valueForKeyPath:@"featured_image"]];
        self.postTerms = [[FCTerms alloc] initWithAttributes:[attributes valueForKeyPath:@"terms"]];
    }
    return self;
}

- (NSString *)getCategoriesString {
  
  if(self.postTerms == nil){
    return @"";
  }
  
    NSMutableString *out = [NSMutableString stringWithString:@""];
    NSArray *categories = self.postTerms.termsCategory;
    NSUInteger limit = 0;

    for (FCCategory *category in categories) {
        if (limit == 3) {
            break;
        }
        limit++;
        [out appendString:[NSString stringWithFormat:@"%@ | ", category.categoryTitle]];
    }
    return [out stringByReplacingCharactersInRange:NSMakeRange([out length] - 2, 2) withString:@""];
}

@end
