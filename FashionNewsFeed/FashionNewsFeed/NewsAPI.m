//
//  NewsAPI.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 01.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "NewsAPI.h"

#import "HTTPClient.h"
#import "PersistencyManager.h"


@interface NewsAPI ()
{
    PersistencyManager * persistencyManager;
    HTTPClient * httpClient;
    
}
@end


@implementation NewsAPI

+ (NewsAPI *) sharedInstance{
    
    static NewsAPI * _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[NewsAPI alloc] init];
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
