//
//  FashionCollectionAPI.m
//  FashionNewsFeed
//

#import "FashionCollectionAPI.h"
#import "FCHTTPClient.h"
#import "FCCategory.h"
#import "FCResponseHeaders.h"
#import "PersistencyManager.h"

@interface FashionCollectionAPI () {
    FCHTTPClient *httpClient;
    PersistencyManager *persistencyManager;
}
@end

@implementation FashionCollectionAPI

+ (FashionCollectionAPI *)sharedInstance {

    static FashionCollectionAPI *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[FashionCollectionAPI alloc] init];
    });
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        httpClient = [FCHTTPClient sharedClient];
        persistencyManager = [[PersistencyManager alloc] init];
    }
    return self;
}

- (void)cachePosts:(NSArray *)posts {
    
    [persistencyManager setToDataPosts:posts];
}


-(void)getImageWithUrl:(NSURL*)url
               success:(void(^)(NSURLSessionDataTask* task, UIImage* image))success
               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    //TODO: ask if image with url is already in cache
    
    UIImage* cachedImaged = [persistencyManager getImageForUrl:url];
    
    if (cachedImaged == nil) {
        [httpClient getImageWithURL:url success:
         ^(NSURLSessionDataTask *task, UIImage* image) {
             [persistencyManager cacheImage:image forURL:url];
             success(task, image);
         }failure:failure];
        
    } else {
        NSLog(@"cashed image for url: %@",[url absoluteString]);
        success(nil,cachedImaged);
    }
}



- (NSMutableArray *)processResponse:(id)responseObject {
    NSMutableArray *responses = [[NSMutableArray alloc] init];
    for (NSDictionary *attributes in responseObject) {
        FCPost *response = [[FCPost alloc] initWithAttributes:attributes];
        [responses addObject:response];
    }
    return responses;
}

- (void)getCategories:(void (^)(NSURLSessionDataTask *task, NSMutableArray *categories))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getCategories:^(NSURLSessionDataTask *task, id responseObject) {
                NSMutableArray *categories = [[NSMutableArray alloc] init];
                for (NSDictionary *attributes in responseObject) {
                    FCCategory *category = [[FCCategory alloc] initWithAttributes:attributes];
                    [categories addObject:category];
                }
                success(task, categories);
            }
                      failure:^(NSURLSessionDataTask *task, NSError *error) {
                          failure(task, error);
                      }];
}

- (void)getPostById:(NSUInteger)postId
            success:(void (^)(NSURLSessionDataTask *task, FCPost *post))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getPostById:postId
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        FCPost *post = [[FCPost alloc] initWithAttributes:responseObject];
                        success(task, post);
                    }
                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                        failure(task, error);
                    }];
}

- (void)getLatestsPosts:(NSUInteger)pageNumber
           postsPerPage:(NSUInteger)postsPerPage
                success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getPostsNoCategory:pageNumber
                   andPostsPerPage:postsPerPage
                           success:^(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers) {
                               NSMutableArray *responses = [self processResponse:responseObject];
                               FCResponseHeaders *responseHeaders = [[FCResponseHeaders alloc] initWithAttributes:headers];
                               success(task, responses, responseHeaders);
                           }
                           failure:^(NSURLSessionDataTask *task, NSError *error) {
                               failure(task, error);
                           }];
}

- (void)getBeautyBoxPosts:(NSUInteger)pageNumber
             postsPerPage:(NSUInteger)postsPerPage
                  success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getPostsByCategory:@"beauty_box"
                     andPageNumber:pageNumber
                   andPostsPerPage:postsPerPage
                           success:^(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers) {
                               NSMutableArray *responses = [self processResponse:responseObject];
                               FCResponseHeaders *responseHeaders = [[FCResponseHeaders alloc] initWithAttributes:headers];
                               success(task, responses, responseHeaders);
                           }
                           failure:^(NSURLSessionDataTask *task, NSError *error) {
                               failure(task, error);
                           }];
}

- (void)getLifestylePosts:(NSUInteger)pageNumber
             postsPerPage:(NSUInteger)postsPerPage
                  success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getPostsByCategory:@"lifestyle"
                     andPageNumber:pageNumber
                   andPostsPerPage:postsPerPage
                           success:^(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers) {
                               NSMutableArray *responses = [self processResponse:responseObject];
                               FCResponseHeaders *responseHeaders = [[FCResponseHeaders alloc] initWithAttributes:headers];
                               success(task, responses, responseHeaders);
                           }
                           failure:^(NSURLSessionDataTask *task, NSError *error) {
                               failure(task, error);
                           }];
}

- (void)getBreakfastPosts:(NSUInteger)pageNumber
             postsPerPage:(NSUInteger)postsPerPage
                  success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getPostsByCategory:@"breakfast"
                     andPageNumber:pageNumber
                   andPostsPerPage:postsPerPage
                           success:^(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers) {
                               NSMutableArray *responses = [self processResponse:responseObject];
                               FCResponseHeaders *responseHeaders = [[FCResponseHeaders alloc] initWithAttributes:headers];
                               success(task, responses, responseHeaders);
                           }
                           failure:^(NSURLSessionDataTask *task, NSError *error) {
                               failure(task, error);
                           }];
}

- (void)getKonkursPosts:(NSUInteger)pageNumber
           postsPerPage:(NSUInteger)postsPerPage
                success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getPostsByCategory:@"konkurs"
                     andPageNumber:pageNumber
                   andPostsPerPage:postsPerPage
                           success:^(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers) {
                               NSMutableArray *responses = [self processResponse:responseObject];
                               FCResponseHeaders *responseHeaders = [[FCResponseHeaders alloc] initWithAttributes:headers];
                               success(task, responses, responseHeaders);
                           }
                           failure:^(NSURLSessionDataTask *task, NSError *error) {
                               failure(task, error);
                           }];
}

- (void)getBeautyPosts:(NSUInteger)pageNumber
          postsPerPage:(NSUInteger)postsPerPage
               success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getPostsByCategory:@"beauty"
                     andPageNumber:pageNumber
                   andPostsPerPage:postsPerPage
                           success:^(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers) {
                               NSMutableArray *responses = [self processResponse:responseObject];
                               FCResponseHeaders *responseHeaders = [[FCResponseHeaders alloc] initWithAttributes:headers];
                               success(task, responses, responseHeaders);
                           }
                           failure:^(NSURLSessionDataTask *task, NSError *error) {
                               failure(task, error);
                           }];
}

- (void)getFacePosts:(NSUInteger)pageNumber
        postsPerPage:(NSUInteger)postsPerPage
             success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getPostsByCategory:@"face"
                     andPageNumber:pageNumber
                   andPostsPerPage:postsPerPage
                           success:^(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers) {
                               NSMutableArray *responses = [self processResponse:responseObject];
                               FCResponseHeaders *responseHeaders = [[FCResponseHeaders alloc] initWithAttributes:headers];
                               success(task, responses, responseHeaders);
                           }
                           failure:^(NSURLSessionDataTask *task, NSError *error) {
                               failure(task, error);
                           }];
}

- (void)getBestPosts:(NSUInteger)pageNumber
        postsPerPage:(NSUInteger)postsPerPage
             success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getPostsByCategory:@"best"
                     andPageNumber:pageNumber
                   andPostsPerPage:postsPerPage
                           success:^(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers) {
                               NSMutableArray *responses = [self processResponse:responseObject];
                               FCResponseHeaders *responseHeaders = [[FCResponseHeaders alloc] initWithAttributes:headers];
                               success(task, responses, responseHeaders);
                           }
                           failure:^(NSURLSessionDataTask *task, NSError *error) {
                               failure(task, error);
                           }];
}

- (void)getFashionPosts:(NSUInteger)pageNumber
           postsPerPage:(NSUInteger)postsPerPage
                success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getPostsByCategory:@"fashion"
                     andPageNumber:pageNumber
                   andPostsPerPage:postsPerPage
                           success:^(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers) {
                               NSMutableArray *responses = [self processResponse:responseObject];
                               FCResponseHeaders *responseHeaders = [[FCResponseHeaders alloc] initWithAttributes:headers];
                               success(task, responses, responseHeaders);
                           }
                           failure:^(NSURLSessionDataTask *task, NSError *error) {
                               failure(task, error);
                           }];
}

- (void)getNewsPosts:(NSUInteger)pageNumber
        postsPerPage:(NSUInteger)postsPerPage
             success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getPostsByCategory:@"news"
                     andPageNumber:pageNumber
                   andPostsPerPage:postsPerPage
                           success:^(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers) {
                               NSMutableArray *responses = [self processResponse:responseObject];
                               FCResponseHeaders *responseHeaders = [[FCResponseHeaders alloc] initWithAttributes:headers];
                               success(task, responses, responseHeaders);
                           }
                           failure:^(NSURLSessionDataTask *task, NSError *error) {
                               failure(task, error);
                           }];
}

- (void)getEventsPosts:(NSUInteger)pageNumber
          postsPerPage:(NSUInteger)postsPerPage
               success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getPostsByCategory:@"events"
                     andPageNumber:pageNumber
                   andPostsPerPage:postsPerPage
                           success:^(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers) {
                               NSMutableArray *responses = [self processResponse:responseObject];
                               FCResponseHeaders *responseHeaders = [[FCResponseHeaders alloc] initWithAttributes:headers];
                               success(task, responses, responseHeaders);
                           }
                           failure:^(NSURLSessionDataTask *task, NSError *error) {
                               failure(task, error);
                           }];
}

- (NSArray *)getHardCodedCategories {

    FCCategory *cat1 = [[FCCategory alloc] initCategoryWithId:0 andName:@"Новости" andTitle:@"Новости" andCount:nil andLink:nil andMeta:nil];
    FCCategory *cat2 = [[FCCategory alloc] initCategoryWithId:1 andName:@"Мода" andTitle:@"Мода" andCount:nil andLink:nil andMeta:nil];
    FCCategory *cat3 = [[FCCategory alloc] initCategoryWithId:2 andName:@"События" andTitle:@"События" andCount:nil andLink:nil andMeta:nil];
    FCCategory *cat4 = [[FCCategory alloc] initCategoryWithId:3 andName:@"Beauty Box" andTitle:@"Beauty Box" andCount:nil andLink:nil andMeta:nil];
    return @[cat1, cat2, cat3, cat4];
}

- (void)cancelAllOperations{
    [httpClient cancelAllOperations];
}

@end