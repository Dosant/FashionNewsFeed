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

@interface FashionCollectionAPI ()
{
    PersistencyManager * persistencyManager;
    FCHTTPClient * httpClient;
    FCFakeHTTPClient * fakeClient;
}
@end


@implementation FashionCollectionAPI

+ (FashionCollectionAPI *) sharedInstance{
    
    static FashionCollectionAPI * _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[FashionCollectionAPI alloc] init];
    });
    
    return _sharedInstance;
    
}

- (id)init
{
    self = [super init];
    if (self)
    {
        persistencyManager = [[PersistencyManager alloc] init];
        httpClient = [[FCHTTPClient alloc] init];
        fakeClient = [[FCFakeHTTPClient alloc] init];
    }
    
    return self;
}

-(NSMutableArray *)getCategories{
    
    //Load data from PersistencyManager
    //if it is not null - return
    //otherwise load it from FCHttpClient
    
    //TODO Remove fake implementation
    NSMutableArray *categories = [fakeClient getCategories];
    
    //Save data to PersistencyManager
    
    return categories;
}

-(NSMutableArray *)getLatestsPosts{
    
    //Load data from PersistencyManager
    //if it is not null - return
    //otherwise load it from FCHttpClient
    
    //TODO Remove fake implementation
    NSMutableArray *posts = [fakeClient getPosts];
    
    //Save data to PersistencyManager
    
    return posts;
}

- (FCPost *)getPostWithId:(NSUInteger)postId {    
    return nil;
}

@end
