//
// Header.
// Downloading posts from web site http://fcollection.by
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface FCHTTPClient : AFHTTPSessionManager

+ (FCHTTPClient *)sharedClient;

- (void)getCategories:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)getPostById:(NSUInteger)postId
            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)getPostsByCategory:(NSString *)categoryName
             andPageNumber:(NSUInteger)pageNumber
           andPostsPerPage:(NSUInteger)postsPerPage
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)getPostsNoCategory:(NSUInteger)pageNumber
           andPostsPerPage:(NSUInteger)postsPerPage
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end