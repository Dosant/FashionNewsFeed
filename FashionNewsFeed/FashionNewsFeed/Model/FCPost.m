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

+(id)postWithProperties:(NSDictionary *)properties
{
    return [[self alloc] initWithProperties:properties];
}

-(id)initWithProperties:(NSDictionary *)properties
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:properties];
    }
    return self;
}

//Had to do a custom implementation of this because I didn't want all keys
-(void)setValue:(id)value forKey:(NSString *)key
{
   // if ([key isEqualToString:@"title"]) self.title = value;
   // else if ([key isEqualToString:@"subreddit"]) self.subreddit = value;
   // else if ([key isEqualToString:@"author"]) self.username = value;
   // else if ([key isEqualToString:@"thumbnail"]) self.thumbnail = value;
   // else if ([key isEqualToString:@"url"]) self.url = value;
   // else if ([key isEqualToString:@"ups"]) self.ups = value;
   // else if ([key isEqualToString:@"downs"]) self.downs = value;
   // else if ([key isEqualToString:@"score"]) self.score = value;
}


@end
