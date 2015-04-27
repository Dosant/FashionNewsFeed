//
// Implementation.
// Downloading posts from web site http://fcollection.by
//

// http://fcollection.by/wp-json/
// /posts/<id>
// /posts/<id>/revisions
// /posts/types
// /posts/types/<type>
// /posts/statuses
// /posts/<id>/comments
// /posts/<id>/comments/<comment>
// /users
// /users/<id>
// /users/me
// /posts/<id>/meta
// /posts/<id>/meta/<mid>
// /media
// /media/<id>
// /taxonomies
// /taxonomies/<taxonomy>
// /taxonomies/<taxonomy>/terms
// /pages
// /pages/<id>
// /pages/<id>/revisions
// /pages/<id>/comments
// /pages/<id>/comments/<comment>
// /pages/<path>

#import "FCHTTPClient.h"

static NSString *const kFCollectionBaseURLString = @"http://fcollection.by/wp-json/";

@implementation FCHTTPClient

+ (FCHTTPClient *)sharedClient {
    static FCHTTPClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kFCollectionBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    return self;
}

- (void)getCategories:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    NSString *path = [NSString stringWithFormat:@"%@%@", kFCollectionBaseURLString, @"taxonomies/category/terms"];

    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

- (void)getPostById:(NSUInteger)postId
            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    NSString *path = [NSString stringWithFormat:@"%@posts/%lu", kFCollectionBaseURLString, (unsigned long) postId];

    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

- (void)getPostsByCategory:(NSString *)categoryName
             andPageNumber:(NSUInteger)pageNumber
           andPostsPerPage:(NSUInteger)postsPerPage
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    NSString *path = [NSString stringWithFormat:@"%@posts?filter[category_name]=%@&page=%lu&filter[posts_per_page]=%lu&status=publish&count=true",
                                                kFCollectionBaseURLString,
                                                categoryName,
                                                (unsigned long) pageNumber,
                                                (unsigned long) postsPerPage];

    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

- (void)getPostsNoCategory:(NSUInteger)pageNumber
           andPostsPerPage:(NSUInteger)postsPerPage
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    NSString *path = [NSString stringWithFormat:@"%@posts?page=%lu&filter[posts_per_page]=%lu&status=publish&count=true",
                                                kFCollectionBaseURLString,
                                                (unsigned long) pageNumber,
                                                (unsigned long) postsPerPage];

    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

@end
