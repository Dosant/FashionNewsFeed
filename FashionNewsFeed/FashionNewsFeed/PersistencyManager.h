//
//  PersistencyManager.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#include <CoreData/CoreData.h>
#import "FCPost.h"
#import "FCAuthor.h"
#import "FCTerms.h"
#import "FCCategory.h"
#import "FCPostTag.h"
#import "DataPost.h"
#import "DataAuthor.h"
#import "DataTerms.h"
#import "DataCategory.h"
#import "DataPostTag.h"

@interface PersistencyManager : NSObject

//Core Data manager
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//Methods return posts from Core Data
- (FCPost *)getPostById:(NSUInteger)postId;
- (FCPost *)getPostByCategory:(NSString *)category;

//Method set post to Core Data
- (void)setToDataPost:(FCPost *)post;

//Other
- (void)deleteAllObjects;

@end
