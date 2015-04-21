//
//  FCTerms.m
//  FashionNewsFeed
//

#import "FCTerms.h"
#import "FCPostTag.h"
#import "FCCategory.h"

@implementation FCTerms

- (instancetype)initTermsWithPostTag:(NSMutableArray *)termsPostTag  // FCPostTag
                         andCategory:(NSMutableArray *)termsCategory // FCCategory
{
    self = [super init];
    if (self) {
        self.termsPostTag = termsPostTag;
        self.termsCategory = termsCategory;
    }
    return self;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        NSMutableArray *termsPostTags = [[NSMutableArray alloc] init];
        for (NSDictionary *termsPostTag in [attributes valueForKeyPath:@"post_tag"]) {
            FCPostTag *tag = [[FCPostTag alloc] initWithAttributes:termsPostTag];
            [termsPostTags addObject:tag];
        }
        self.termsPostTag = termsPostTags;

        NSMutableArray *termsCategories = [[NSMutableArray alloc] init];
        for (NSDictionary *termsCategory in [attributes valueForKeyPath:@"category"]) {
            FCCategory *category = [[FCCategory alloc] initWithAttributes:termsCategory];
            [termsCategories addObject:category];
        }
        self.termsCategory = termsCategories;
    }
    return self;
}

@end
