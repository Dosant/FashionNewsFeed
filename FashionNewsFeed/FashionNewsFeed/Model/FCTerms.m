//
//  FCTerms.m
//  FashionNewsFeed
//

#import "FCTerms.h"

@implementation FCTerms

- (instancetype)initTermsWithId:(NSUInteger)termsId
                     andPostTag:(NSMutableArray *)termsPostTag
                    andCategory:(NSMutableArray *)termsCategory
{
    self = [super init];
    if (self) {
        self.termsId = termsId;
        self.termsPostTag = termsPostTag;
        self.termsCategory = termsCategory;
    }
    
    return self;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        
        self.termsId = (NSUInteger)[[attributes valueForKeyPath:@"id"] integerValue];
        self.termsPostTag = [attributes valueForKeyPath:@"text"];
        self.termsCategory = [attributes valueForKeyPath:@"text"];
    }
    return self;
}

@end
