//
//  FCPostTag.m
//  FashionNewsFeed
//

#import "FCPostTag.h"

@implementation FCPostTag

- (id)initPostTagWithId:(NSUInteger)postTagId
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

@end
