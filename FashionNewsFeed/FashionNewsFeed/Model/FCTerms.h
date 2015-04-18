//
//  FCTerms.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCTerms : NSObject

@property (assign, nonatomic) NSUInteger termsId;
@property (strong, nonatomic) NSMutableArray *termsPostTag; //FCPostTag
@property (strong, nonatomic) NSMutableArray *termsCategory; //FCCategory

- (instancetype)initTermsWithId:(NSUInteger)termsId
                     andPostTag:(NSMutableArray *)termsPostTag
                    andCategory:(NSMutableArray *)termsCategory;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
