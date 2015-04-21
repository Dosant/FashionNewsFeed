//
//  FCCategory.m
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>
#import "FCCategory.h"

@implementation FCCategory

- (instancetype)initCategoryWithId:(NSUInteger)categoryId
                           andName:(NSString *)categoryName
                          andTitle:(NSString *)categoryTitle
                          andCount:(NSUInteger)categoryCount
                           andLink:(NSURL *)categoryLink
                           andMeta:(NSMutableDictionary *)categoryMeta {
    self = [super init];
    if (self) {
        self.categoryId = categoryId;
        self.categoryName = categoryName;
        self.categoryTitle = categoryTitle;
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
        self.categoryName = [attributes valueForKeyPath:@"slug"];
        self.categoryTitle = [attributes valueForKeyPath:@"name"];
        self.categoryCount = (NSUInteger) [[attributes valueForKeyPath:@"count"] integerValue];

        NSURL *url = [NSURL URLWithString:[attributes valueForKeyPath:@"link"]];
        self.categoryLink = url;

        NSMutableDictionary *meta = [[NSMutableDictionary alloc] init];
        for (NSString *category in [attributes valueForKeyPath:@"meta"]) {
            id v = [[attributes valueForKeyPath:@"meta"] objectForKey:category];
            for (NSString *k in v) {
                id value = [v objectForKey:k];
                NSURL *url = [NSURL URLWithString:value];
                meta[k] = url;
            }
        }
        self.categoryMeta = meta;
    }
    return self;
}

@end
