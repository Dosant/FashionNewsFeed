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
    AFImageResponseSerializer* noScalingImageSerializer = [AFImageResponseSerializer serializer];
    noScalingImageSerializer.imageScale = 1.0;
    
    self.responseSerializer = [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:@[[AFJSONResponseSerializer serializer],noScalingImageSerializer]];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    return self;
}

- (void)getImageWithURL:(NSURL*)url
                success:(void (^)(NSURLSessionDataTask *task, UIImage* responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    
    
    
    [self GET:[url absoluteString] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        UIImage* image = responseObject;
        
        success(task,image);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
    }];
    
    
    
    
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
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    NSString *path = [NSString stringWithFormat:@"%@posts?filter[category_name]=%@&page=%lu&filter[posts_per_page]=%lu&status=publish&count=true",
                                                kFCollectionBaseURLString,
                                                categoryName,
                                                (unsigned long) pageNumber,
                                                (unsigned long) postsPerPage];

    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            // handle response headers
            NSHTTPURLResponse *response = ((NSHTTPURLResponse *) [task response]);
            NSDictionary *headers = [response allHeaderFields];
            success(task, responseObject, headers);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

- (void)getPostsNoCategory:(NSUInteger)pageNumber
           andPostsPerPage:(NSUInteger)postsPerPage
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    NSString *path = [NSString stringWithFormat:@"%@posts?page=%lu&filter[posts_per_page]=%lu&status=publish&count=true",
                                                kFCollectionBaseURLString,
                                                (unsigned long) pageNumber,
                                                (unsigned long) postsPerPage];

    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            // handle response headers
            NSHTTPURLResponse *response = ((NSHTTPURLResponse *) [task response]);
            NSDictionary *headers = [response allHeaderFields];
            success(task, responseObject, headers);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

-(void)cancelAllOperations{
    
    
    for (NSURLSessionTask *task in self.tasks) {
        [task cancel];
    }
    
    
}
@end
