//
//  FCAuthor.m
//  FashionNewsFeed
//

#import "FCAuthor.h"

@implementation FCAuthor

- (instancetype)initAuthorWithId:(NSUInteger)authorId
                     andUsername:(NSString *)authorUsername
                    andFirstName:(NSString *)authorFirstName
                     andLastName:(NSString *)authorLastName
                     andNickname:(NSString *)authorNickname
                       andAvatar:(NSString *)authorAvatar
                   andRegistered:(NSDate *)authorRegistered
                         andMeta:(NSMutableDictionary *)authorMeta
{
    self = [super init];
    if (self) {
        self.authorId = authorId;
        self.authorUsername = authorUsername;
        self.authorFirstName = authorFirstName;
        self.authorLastName = authorLastName;
        self.authorNickname = authorNickname;
        self.authorAvatar = authorAvatar;
        self.authorRegistered = authorRegistered;
        self.authorMeta = authorMeta;
    }
    return self;
}

@end
