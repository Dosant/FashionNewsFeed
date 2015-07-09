//
//  PersistencyManager.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
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

//Get from Core Data
- (UIImage *)getImageForUrl:(NSURL *)request;
- (FCPost *)getPostById:(NSUInteger)postId;
- (NSArray *)getAllPosts;
- (NSArray *)getPostsByCategory:(NSString *)category;
- (NSUInteger)getPostCountByCategory:(NSString *)category;

//Set to Core Data
- (void)cacheImage:(UIImage *)image forURL:(NSURL*)url;
- (void)setToDataPosts:(NSArray *)post;
- (void)addPostToQueue:(FCPost *)post;

//Other
- (void)deleteAllObjects;

@end
