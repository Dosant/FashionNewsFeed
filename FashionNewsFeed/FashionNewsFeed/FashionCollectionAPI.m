//
//  FashionCollectionAPI.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 01.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "FashionCollectionAPI.h"
#import "FCHTTPClient.h"
#import "FCFakeHTTPClient.h"
#import "PersistencyManager.h"

@interface FashionCollectionAPI () {
    PersistencyManager *persistencyManager;
    FCHTTPClient *httpClient;
    FCFakeHTTPClient *fakeClient;
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
        persistencyManager = [[PersistencyManager alloc] init];
        httpClient = [[FCHTTPClient alloc] init];
        fakeClient = [[FCFakeHTTPClient alloc] init];
    }
    return self;
}

- (NSMutableArray *)getCategoriesNew {

    NSMutableArray *categories = [[NSMutableArray alloc] init];

    [httpClient getCategories:1
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[responseObject count]];
                          for (NSDictionary *attributes in responseObject) {
                              FCCategory *post = [[FCCategory alloc] initWithAttributes:attributes];
                              [mutablePosts addObject:post];
                          }
                      }
                      failure:^(NSURLSessionDataTask *task, NSError *error) {
                      }];

    return categories;
}

- (NSMutableArray *)getCategories {
    NSMutableArray *categories = [fakeClient getCategories];
    return categories;
}

- (NSMutableArray *)getLatestsPosts {
    NSMutableArray *posts = [fakeClient getPosts];
    return posts;
}

@end
