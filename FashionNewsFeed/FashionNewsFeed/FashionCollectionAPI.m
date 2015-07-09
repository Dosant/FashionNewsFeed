//
//  FashionCollectionAPI.m
//  FashionNewsFeed
//

#import "FashionCollectionAPI.h"
#import "FCHTTPClient.h"
#import "FCCategory.h"
#import "FCResponseHeaders.h"
#import "PersistencyManager.h"
#import "ImageTransformUtility.h"
#import "ImageRecord.h"
#import "ImageDownloader.h"

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
        _isNetwork = true;
        
    }
  
    return self;
}

- (PendingOperations *)pendingOperations {
  if (!_pendingOperations) {
    _pendingOperations = [[PendingOperations alloc] init];
  }
  return _pendingOperations;
}



#pragma mark - Core Data

- (NSUInteger)getDataPostCountByCategory:(NSString *)category {
    
    return [persistencyManager getPostCountByCategory:category];
}

- (NSArray *)getDataPostsByCategory:(NSUInteger)category {
    switch (category) {
        case 0:
            return [persistencyManager getAllPosts];
            break;
        case 1:
            return [persistencyManager getPostsByCategory:@"fashion"];
            break;
        case 2:
            return  [persistencyManager getPostsByCategory:@"events"];
            break;
        case 3:
            return [persistencyManager getPostsByCategory:@"beauty_box"];
            break;
            
        default:
            return [NSArray array];
            break;
    }
    return [NSArray array];
}

- (NSArray *)getAllDataPosts {
    
    return [persistencyManager getAllPosts];
}

#pragma mark - gets

-(void)getImageWithUrl:(NSURL*)url
               success:(void(^)(NSURLSessionDataTask* task, UIImage* image))success
               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
        UIImage* cachedImaged = [persistencyManager getImageForUrl:url];
  
  
        if (_isNetwork && !cachedImaged) {
//            [httpClient getImageWithURL:url success:
//             ^(NSURLSessionDataTask *task, UIImage* image) {
//                 UIImage* resizeImage = [ImageTransformUtility resizeImage:image];
//                 [persistencyManager cacheImage:resizeImage forURL:url];
//                 success(task, resizeImage);
//                 
//             }failure: failure];
          
          
          void (^nsuccess)(NSURLSessionDataTask* task, UIImage* image) = ^void((NSURLSessionDataTask* task, UIImage* image)) {
            self.isNetwork = YES;
            [self.pendingOperations.downloadsInProgress removeObjectForKey:url];
            [persistencyManager cacheImage:image forURL:url];
            success(task,image);
          };
          
          void (^nfailure)(NSURLSessionDataTask* task, NSError* error) = ^void((NSURLSessionDataTask* task, NSError* error)) {
            self.isNetwork = NO;
            [self.pendingOperations.downloadsInProgress removeObjectForKey:url];
            failure(task,error);
          };

          
          ImageRecord* record = [[ImageRecord alloc] initWithURL:url];
          [self startOperationsForImageRecord:record success:nsuccess failure:nfailure];
          
        } else {
            if(cachedImaged != nil){
            NSLog(@"data image for url: %@",[url absoluteString]);
            }
            success(nil,cachedImaged);
            
        }
}

#pragma mark -
#pragma mark - Operations

// 1: To keep it simple, you pass in an instance of PhotoRecord that requires operations, along with its indexPath.
- (void)startOperationsForImageRecord:(ImageRecord *)record
                              success:(void(^)(NSURLSessionDataTask* task, UIImage* image))success
                              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
  
  // 2: You inspect it to see whether it has an image; if so, then ignore it.
  if (!record.hasImage) {
    
    // 3: If it does not have an image, start downloading the image by calling startImageDownloadingForRecord:atIndexPath: (which will be implemented shortly). Youíll do the same for filtering operations: if the image has not yet been filtered, call startImageFiltrationForRecord:atIndexPath: (which will also be implemented shortly).
    [self startImageDownloadingForRecord:record success:success failure:failure];
    
  }
}


- (void)startImageDownloadingForRecord:(ImageRecord *)record
                               success:(void(^)(NSURLSessionDataTask* task, UIImage* image))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
  
  // 1: First, check for the particular indexPath to see if there is already an operation in downloadsInProgress for it. If so, ignore it.
  if (![self.pendingOperations.downloadsInProgress.allKeys containsObject:record.URL]) {
    
    // 2: If not, create an instance of ImageDownloader by using the designated initializer, and set ListViewController as the delegate. Pass in the appropriate indexPath and a pointer to the instance of PhotoRecord, and then add it to the download queue. You also add it to downloadsInProgress to help keep track of things.
    // Start downloading
    
    ImageDownloader* imageDownloader = [[ImageDownloader alloc] initWithImageRecord:record success:success failure:failure];
    [self.pendingOperations.downloadsInProgress setObject:imageDownloader forKey:record.URL];
    [self.pendingOperations.downloadQueue addOperation:imageDownloader];
  }
}

- (void)cachePost:(FCPost *)post {
  
    [persistencyManager addPostToQueue:post];
}

#pragma mark - Network

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

-(void)getPostsForPageCategory:(NSUInteger)pageCategory
                    pageNumber:(NSUInteger)pageNumber
                  postsPerPage:(NSUInteger)postsPerPage
                       success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
     void (^nFailure)(NSURLSessionDataTask *task, NSError* error) = ^(NSURLSessionDataTask *task,  NSError *error) {
         self.isNetwork = NO;
         failure(task,error);
     };
    
    void (^nSuccess)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers) = ^(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers) {
        self.isNetwork = YES;
        success(task,posts,headers);
    };
    
    switch (pageCategory) {
        case 0:
            [self getLatestsPosts:pageNumber postsPerPage:postsPerPage success:nSuccess failure:nFailure];
            break;
        case 1:
            [self getFashionPosts:pageNumber postsPerPage:postsPerPage success:nSuccess failure:nFailure];
            break;
        case 2:
            [self getEventsPosts:pageNumber postsPerPage:postsPerPage success:nSuccess failure:nFailure];
            break;
        case 3:
            [self getBeautyBoxPosts:pageNumber postsPerPage:postsPerPage success:nSuccess failure:nFailure];
            break;
            
        default:
            break;
    }
    
    
}


- (void)getLatestsPosts:(NSUInteger)pageNumber
           postsPerPage:(NSUInteger)postsPerPage
                success:(void (^)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [httpClient getPostsNoCategory:pageNumber
                   andPostsPerPage:postsPerPage
                           success:^(NSURLSessionDataTask *task, id responseObject, NSDictionary *headers) {
                               NSMutableArray *responses = [self processResponse:responseObject];
                               
                               [persistencyManager setToDataPosts:responses];

                               
                               
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
                               
                               [persistencyManager setToDataPosts:responses];
                               
                               
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
                               
                               [persistencyManager setToDataPosts:responses];
                               
                               
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
                               
                               [persistencyManager setToDataPosts:responses];
                               
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
                               
                               [persistencyManager setToDataPosts:responses];
                               
                               
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

- (void)loadImagesForOnscreenCellsWithSet:(NSSet*)visibleCells{
  
  // 1: Get a set of visible rows.
  NSSet *visibleRows = visibleCells;
  
  // 2: Get a set of all pending operations (download and filtration).
  NSMutableSet *pendingOperations = [NSMutableSet setWithArray:[self.pendingOperations.downloadsInProgress allKeys]];
  
  NSMutableSet *toBeCancelled = [pendingOperations mutableCopy];
  
  // 4: Rows (or indexPaths) that their operations should be cancelled = pendings ñ visible rows.
  [toBeCancelled minusSet:visibleRows];
  
  // 5: Loop through those to be cancelled, cancel them, and remove their reference from PendingOperations.
  for (NSURL *anUrl in toBeCancelled) {
    
    ImageDownloader *pendingDownload = [self.pendingOperations.downloadsInProgress objectForKey:anUrl];
    [pendingDownload cancel];
    [self.pendingOperations.downloadsInProgress removeObjectForKey:anUrl];
    
    
  }
  toBeCancelled = nil;
}

-(void)cancelDownloadForImageUrl:(NSURL*)url{
  
  if([self.pendingOperations.downloadsInProgress objectForKey:url] != nil){
    ImageDownloader *pendingDownload = [self.pendingOperations.downloadsInProgress objectForKey:url];
    [pendingDownload cancel];
    [self.pendingOperations.downloadsInProgress removeObjectForKey:url];
  }
  
  
}

- (void)suspendAllOperations {
  [self.pendingOperations.downloadQueue setSuspended:YES];
  
}


- (void)resumeAllOperations {
  [self.pendingOperations.downloadQueue setSuspended:NO];
  
}


- (void)cancelAllOperations {
  [self.pendingOperations.downloadQueue cancelAllOperations];
}




@end