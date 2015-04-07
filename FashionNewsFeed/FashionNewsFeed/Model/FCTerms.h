//
//  FCTerms.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCTerms : NSObject

@property (assign, nonatomic) NSUInteger termsId;
//Please use FCPostTag class for termsPostTag array
@property (strong, nonatomic) NSMutableArray *termsPostTag;
//Please use FCCategory for termsCategory array
@property (strong, nonatomic) NSMutableArray *termsCategory;

- (id)initTermsWithId:(NSUInteger)termsId
           andPostTag:(NSMutableArray *)termsPostTag
          andCategory:(NSMutableArray *)termsCategory;

@end
