//
//  FCResponseHeaders.m
//  FashionNewsFeed
//

#import "FCResponseHeaders.h"

@implementation FCResponseHeaders

- (instancetype)initWithTotalPosts:(NSUInteger)totalPosts
                     andTotalPages:(NSUInteger *)totalPages {
    self = [super init];
    if (self) {
        self.totalPosts = totalPosts;
        self.totalPages = totalPages;
    }
    return self;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.totalPosts = (NSUInteger) [[attributes valueForKeyPath:@"X-WP-Total"] integerValue];
        self.totalPages = (NSUInteger) [[attributes valueForKeyPath:@"X-WP-TotalPages"] integerValue];
    }
    return self;
}

@end
