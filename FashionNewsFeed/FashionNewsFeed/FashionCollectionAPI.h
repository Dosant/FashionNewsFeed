//
//  FashionCollectionAPI.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>
#import "FCPost.h"
#import "FCResponseHeaders.h"

@interface FashionCollectionAPI : NSObject

+ (FashionCollectionAPI *)sharedInstance;

@property (nonatomic,assign) BOOL isNetwork;

#pragma mark - Core Data

- (void)cachePosts:(NSArray *)posts;
- (void)cachePost:(FCPost *)post;
- (NSUInteger)getDataPostCountByCategory:(NSString *)category;
- (NSArray *)getDataPostsByCategory:(NSString *)category onPage:(NSUInteger)pageNumber;
- (NSArray *)getLatestDataPostsOnPage:(NSUInteger)pageNumber;

#pragma mark - Network

-(void)getImageWithUrl:(NSURL*)url
               success:(void(^)(NSURLSessionDataTask* task, UIImage* image))success
               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(void)getPostsForPageCategory:(NSUInteger)pageCategory
                    pageNumber:(NSUInteger)pageNumber
                  postsPerPage:(NSUInteger)postsPerPage
                       success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSArray *)getHardCodedCategories;

- (void)cancelAllOperations;

@end


