//
//  PersistencyManager.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 01.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

/*
 Caсhe logic
 CoreData
*/



#import <Foundation/Foundation.h>

@interface PersistencyManager : NSObject

@property (strong, nonatomic) NSArray * categoriesList;
@property (strong, nonatomic) NSMutableArray *arrayOfPost;

@end
