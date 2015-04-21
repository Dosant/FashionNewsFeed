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
                          andMeta:(NSMutableDictionary *)postTagMeta {
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

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.postTagId = (NSUInteger) [[attributes valueForKeyPath:@"ID"] integerValue];
        self.postTagName = [attributes valueForKeyPath:@"name"];
        self.postTagCount = (NSUInteger) [[attributes valueForKeyPath:@"count"] integerValue];
        self.postTagLink = [attributes valueForKeyPath:@"link"];

        NSMutableDictionary *meta = [[NSMutableDictionary alloc] init];
        for (NSString *attachment in [attributes valueForKeyPath:@"meta"]) {
            id v = [[attributes valueForKeyPath:@"meta"] objectForKey:attachment];
            for (NSString *k in v) {
                id value = [v objectForKey:k];
                meta[k] = value;
            }
        }
        self.postTagMeta = meta;
    }
    return self;
}

@end
