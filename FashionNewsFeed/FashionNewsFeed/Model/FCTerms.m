//
//  FCTerms.m
//  FashionNewsFeed
//

#import "FCTerms.h"

@implementation FCTerms


- (id)initTermsWithId:(NSUInteger)termsId
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

@end
