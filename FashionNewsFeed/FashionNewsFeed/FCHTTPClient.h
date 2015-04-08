//
// Header.
// Downloading the news from web site.
// http://fcollection.by
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

extern NSString * const kFCBaseURLString;

@interface FCHTTPClient : AFHTTPSessionManager

+ (FCHTTPClient *)sharedClient;

- (void)getPostById:(NSUInteger)postId
            success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
            failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end