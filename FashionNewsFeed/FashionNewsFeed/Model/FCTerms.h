//
//  FCTerms.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCTerms : NSObject

@property (assign, nonatomic) NSUInteger termsId;
@property (strong, nonatomic) NSMutableArray *termsPostTag;
@property (strong, nonatomic) NSMutableArray *termsCategory;

- (id)initTermsWithId:(NSUInteger)termsId
           andPostTag:(NSMutableArray *)termsPostTag
          andCategory:(NSMutableArray *)termsCategory;

@end
