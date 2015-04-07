//
// Implementation.
// Downloading the news from web site.
// http://fcollection.by
//

// Test urls
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

static NSString * const kFCollectionBaseURLString = @"http://fcollection.by";

@implementation FCHTTPClient

+ (FCHTTPClient *)sharedClient {
    static FCHTTPClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kFCollectionBaseURLString]];
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

- (void)getLatestPosts:(int)numberOfPosts
               success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
               failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //NSString* path = [NSString stringWithFormat:@"user/calendar/shows.json/%@/%@/%@/%d",
    //                 kTraktAPIKey, username, dateString, numberOfDays];
    
    NSString* path = [NSString init];
    
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
    
    
// How to call
//    FCHTTPClient *client = [FCHTTPClient sharedClient];
//    
//    [client getLatestPosts:10
//                   success:^(NSURLSessionDataTask *task, id responseObject) {
//                       NSLog(@"Success -- %@", responseObject);
//                    }
//                   failure:^(NSURLSessionDataTask *task, NSError *error) {
//                       NSLog(@"Failure -- %@", error);
//                    }];
    
}

@end
