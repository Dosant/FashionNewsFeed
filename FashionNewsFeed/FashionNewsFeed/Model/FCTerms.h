//
//  FCTerms.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCTerms : NSObject

@property(strong, nonatomic) NSMutableArray *termsPostTag;  // FCPostTag
@property(strong, nonatomic) NSMutableArray *termsCategory; // FCCategory

- (instancetype)initTermsWithPostTag:(NSMutableArray *)termsPostTag
                         andCategory:(NSMutableArray *)termsCategory;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
