//
//  FCAuthor.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCAuthor : NSObject

@property(assign, nonatomic) NSUInteger authorId;
@property(strong, nonatomic) NSString *authorUserName;
@property(strong, nonatomic) NSString *authorFirstName;
@property(strong, nonatomic) NSString *authorLastName;
@property(strong, nonatomic) NSString *authorNickName;
@property(strong, nonatomic) NSString *authorAvatar;
@property(strong, nonatomic) NSDate *authorRegistered;
@property(strong, nonatomic) NSMutableDictionary *authorMeta;

- (instancetype)initAuthorWithId:(NSUInteger)authorId
                     andUserName:(NSString *)authorUserName
                    andFirstName:(NSString *)authorFirstName
                     andLastName:(NSString *)authorLastName
                     andNickName:(NSString *)authorNickName
                       andAvatar:(NSString *)authorAvatar
                   andRegistered:(NSDate *)authorRegistered
                         andMeta:(NSMutableDictionary *)authorMeta;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
