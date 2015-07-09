//
//  FashionCollectionAPI.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>
#import "FCPost.h"
#import "FCResponseHeaders.h"
#import "PendingOperations.h"

@interface FashionCollectionAPI : NSObject

+ (FashionCollectionAPI *)sharedInstance;

@property (nonatomic,assign) BOOL isNetwork;
@property (nonatomic, strong) PendingOperations *pendingOperations;

#pragma mark - Core Data

- (NSUInteger)getDataPostCountByCategory:(NSString *)category;
- (NSArray *)getDataPostsByCategory:(NSUInteger)category;


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
- (void)suspendAllOperations;
- (void)resumeAllOperations;
- (void)cancelDownloadForImageUrl:(NSURL*)url;


@end


