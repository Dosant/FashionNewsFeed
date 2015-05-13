//
//  PersistencyManager.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <CoreData/CoreData.h>
#import "FCPost.h"
#import "FCAuthor.h"
#import "FCTerms.h"
#import "FCCategory.h"
#import "FCPostTag.h"

@interface PersistencyManager : NSObject

//Core Data manager
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//Methods return posts from Core Data
- (UIImage *)getImageForUrl:(NSURL *)request;
- (FCPost *)getPostById:(NSUInteger)postId;
- (NSArray *)getPostsOnPageNumber:(NSUInteger)pageNumber;
- (NSArray *)getPostsByCategory:(NSString *)category pageNumber:(NSUInteger)pageNumber;

//Method set post to Core Data
- (void)cacheImage:(UIImage *)image forURL:(NSURL*)url;
- (void)setToDataPosts:(NSArray *)post;

//Other
- (void)deleteAllObjects;

@end
