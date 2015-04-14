//
//  FashionCollectionAPI.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>
#import "FCCategory.h"
#import "FCPost.h"
#import "FCAuthor.h"
#import "FCFeaturedImage.h"
#import "FCAttachmentMeta.h"
#import "FCTerms.h"
#import "FCPostTag.h"

@interface FashionCollectionAPI : NSObject

+ (FashionCollectionAPI *)sharedInstance;

- (NSMutableArray *)getCategories;
- (NSMutableArray *)getLatestsPosts;
- (FCPost *)getPostWithId:(NSUInteger)id;

@end
