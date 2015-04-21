//
//  FCAuthor.m
//  FashionNewsFeed
//

#import "FCAuthor.h"

@implementation FCAuthor

- (instancetype)initAuthorWithId:(NSUInteger)authorId
                     andUsername:(NSString *)authorUserName
                    andFirstName:(NSString *)authorFirstName
                     andLastName:(NSString *)authorLastName
                     andNickname:(NSString *)authorNickName
                       andAvatar:(NSString *)authorAvatar
                   andRegistered:(NSDate *)authorRegistered
                         andMeta:(NSMutableDictionary *)authorMeta {
    self = [super init];
    if (self) {
        self.authorId = authorId;
        self.authorUserName = authorUserName;
        self.authorFirstName = authorFirstName;
        self.authorLastName = authorLastName;
        self.authorNickName = authorNickName;
        self.authorAvatar = authorAvatar;
        self.authorRegistered = authorRegistered;
        self.authorMeta = authorMeta;
    }
    return self;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.authorId = (NSUInteger) [[attributes valueForKeyPath:@"ID"] integerValue];
        self.authorUserName = [attributes valueForKeyPath:@"username"];
        self.authorFirstName = [attributes valueForKeyPath:@"first_name"];
        self.authorLastName = [attributes valueForKeyPath:@"last_name"];
        self.authorNickName = [attributes valueForKeyPath:@"nickname"];
        self.authorAvatar = [attributes valueForKeyPath:@"avatar"];
        self.authorRegistered = [attributes valueForKeyPath:@"registered"];

        NSMutableDictionary *meta = [[NSMutableDictionary alloc] init];
        for (NSString *i in [attributes valueForKeyPath:@"meta"]) {
            id v = [[attributes valueForKeyPath:@"meta"] objectForKey:i];
            for (NSString *k in v) {
                id value = [v objectForKey:k];
                meta[k] = value;
            }
        }
        self.authorMeta = meta;
    }
    return self;
}

@end
