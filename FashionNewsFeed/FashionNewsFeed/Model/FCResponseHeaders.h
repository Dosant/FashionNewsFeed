//
//  FCResponseHeaders.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCResponseHeaders : NSObject

@property(assign, nonatomic) NSUInteger totalPosts;
@property(assign, nonatomic) NSUInteger totalPages;

- (instancetype)initWithTotalPosts:(NSUInteger)totalPosts
                     andTotalPages:(NSUInteger)totalPages;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
