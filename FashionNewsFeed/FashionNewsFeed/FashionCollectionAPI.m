//
//  FashionCollectionAPI.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 01.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "FashionCollectionAPI.h"

#import "HTTPClient.h"
#import "PersistencyManager.h"


@interface FashionCollectionAPI ()
{
    PersistencyManager * persistencyManager;
    HTTPClient * httpClient;
    
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
        httpClient = [[HTTPClient alloc] init];
        
    }
    return self;
}

-(NSArray *)getCategories{
    
    return persistencyManager.categoriesList;
}

@end
