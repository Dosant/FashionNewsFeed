//
//  FCPostTag.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCPostTag : NSObject

@property (assign, nonatomic) NSUInteger postTagId;
@property (strong, nonatomic) NSString *postTagName;
@property (assign, nonatomic) NSUInteger postTagCount;
@property (strong, nonatomic) NSString *postTagLink;
@property (strong, nonatomic) NSMutableDictionary *postTagMeta;

- (id)initPostTagWithId:(NSUInteger)postTagId
                andName:(NSString *)postTagName
               andCount:(NSUInteger)postTagCount
                andLink:(NSString *)postTagLink
                andMeta:(NSDictionary *)postTagMeta;
@end
