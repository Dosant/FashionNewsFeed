//
//  FCPostTag.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCPostTag : NSObject

@property(assign, nonatomic) NSUInteger postTagId;
@property(strong, nonatomic) NSString *postTagName;
@property(assign, nonatomic) NSUInteger postTagCount;
@property(strong, nonatomic) NSURL *postTagLink;
@property(strong, nonatomic) NSMutableDictionary *postTagMeta;

- (instancetype)initPostTagWithId:(NSUInteger)postTagId
                          andName:(NSString *)postTagName
                         andCount:(NSUInteger)postTagCount
                          andLink:(NSURL *)postTagLink
                          andMeta:(NSDictionary *)postTagMeta;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
