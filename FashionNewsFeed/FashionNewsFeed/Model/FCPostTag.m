//
//  FCPostTag.m
//  FashionNewsFeed
//

#import "FCPostTag.h"

@implementation FCPostTag

- (instancetype)initPostTagWithId:(NSUInteger)postTagId
                          andName:(NSString *)postTagName
                         andCount:(NSUInteger)postTagCount
                          andLink:(NSString *)postTagLink
                          andMeta:(NSMutableDictionary *)postTagMeta
{
    self = [super init];
    if (self) {
        self.postTagId = postTagId;
        self.postTagName = postTagName;
        self.postTagCount = postTagCount;
        self.postTagLink = postTagLink;
        self.postTagMeta = postTagMeta;
    }
    
    return self;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.postTagId = (NSUInteger)[[attributes valueForKeyPath:@"id"] integerValue];
        self.postTagName = [attributes valueForKeyPath:@"text"];
        self.postTagCount = (NSUInteger)[[attributes valueForKeyPath:@"id"] integerValue];
        self.postTagLink = [attributes valueForKeyPath:@"text"];
        self.postTagMeta = [attributes valueForKeyPath:@"text"];
    }
    return self;
}

@end
