//
//  FashionCollectionAPI.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 01.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "FashionCollectionAPI.h"

#import "FCHTTPClient.h"
#import "PersistencyManager.h"


@interface FashionCollectionAPI ()
{
    PersistencyManager * persistencyManager;
    FCHTTPClient * httpClient;
    
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
        
        
    }
    return self;
}

-(NSArray *)getCategories{
    
    return persistencyManager.categoriesList;
}

- (void) addNewsItem:(FCPost *)post {
    
    [[persistencyManager arrayOfPost] addObject: post];
}

- (FCPost *)getNewsItemWithId:(NSUInteger)newsId {
    
    for (FCPost *post in [persistencyManager arrayOfPost] ) {
        
        if (newsId == [post postId]) {
            
            return post;
        }
    }
    
    return nil;
}

@end
