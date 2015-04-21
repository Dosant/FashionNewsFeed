//
//  FCCategory.m
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>
#import "FCCategory.h"

@implementation FCCategory

- (instancetype)initCategoryWithId:(NSUInteger)categoryId
                           andName:(NSString *)categoryName
                          andCount:(NSUInteger)categoryCount
                           andLink:(NSString *)categoryLink
                           andMeta:(NSMutableDictionary *)categoryMeta {
    self = [super init];
    if (self) {
        self.categoryId = categoryId;
        self.categoryName = categoryName;
        self.categoryCount = categoryCount;
        self.categoryLink = categoryLink;
        self.categoryMeta = categoryMeta;
    }
    return self;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.categoryId = (NSUInteger) [[attributes valueForKeyPath:@"ID"] integerValue];
        self.categoryName = [attributes valueForKeyPath:@"name"];
        self.categoryCount = (NSUInteger) [[attributes valueForKeyPath:@"count"] integerValue];
        self.categoryLink = [attributes valueForKeyPath:@"link"];

        NSMutableDictionary *meta = [[NSMutableDictionary alloc] init];
        for (NSString *category in [attributes valueForKeyPath:@"meta"]) {
            id v = [[attributes valueForKeyPath:@"meta"] objectForKey:category];
            for (NSString *k in v) {
                id value = [v objectForKey:k];
                meta[k] = value;
            }
        }
        self.categoryMeta = meta;
    }
    return self;
}

@end
