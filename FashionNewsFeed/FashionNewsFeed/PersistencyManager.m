//
//  PersistencyManager.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 01.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "PersistencyManager.h"

@interface PersistencyManager ()

@property (strong, nonatomic) DataPost     *dataPost;
@property (strong, nonatomic) DataAuthor   *dataAuthor;
@property (strong, nonatomic) DataTerms    *dataTerms;
@property (strong, nonatomic) DataCategory *dataCategory;
@property (strong, nonatomic) DataPostTag  *dataPostTag;

@end

@implementation PersistencyManager

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

//#pragma mark - addOtherInPost

//- (BOOL)addCategory:(NSString *)category {
//    
//    PersistencyManager *manager = [[PersistencyManager alloc] init];
//    
//    if (![[manager categoriesList] containsObject: category]) {
//        
//        return NO;
//    }
//    
//    //[self.postCategories addObject: category];
//    
//    return YES;
//}
//
//- (void)addTag:(NSString *)tag {
//    
//    //[self.postTags addObject: tag];
//}
//
//- (void)addAttachment:(id) attachment {
//    
//    //[self.postAttachments addObject: attachment];
//}

//#pragma mark - getOtherInPost

//- (NSArray *)getCurrentPostCategories {
//    NSArray *anArray = @[@1, @2, @3, @4];
//    return anArray;
//    //return self.postCategories;
//}
//
//- (NSArray *)getCurrentPostTags {
//    NSArray *anArray = @[@1, @2, @3, @4];
//    return anArray;
//    //return self.postTags;
//}
//
//- (id)getCurrentPostAttachments {
//    
//    return nil;
//}

#pragma mark - get from Data

- (void) get {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"DataTerms"
                inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    for (DataTerms *obj in resultArray) {
        
        for (DataPostTag *postTag in obj.postTags) {
            NSLog(@"%@ %@", postTag.postTagId, postTag.postTagName);
        }
        for (DataCategory *categories in obj.categories) {
            NSLog(@"%@ %@", categories.categoryId, categories.categoryName);
        }
    }
}

- (FCCategory *)getDataCategoryById:(NSUInteger)idCategory {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"DataCategory"
                inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    for (DataCategory *obj in resultArray) {
        
        if ([obj.categoryId integerValue] == idCategory) {
            
            FCCategory *category = [[FCCategory alloc]  initCategoryWithId:[obj.categoryId integerValue]
                                                                   andName:obj.categoryName
                                                                  andTitle:obj.categoryTitle
                                                                  andCount:[obj.categoryCount integerValue]
                                                                   andLink:[NSURL URLWithString:obj.categoryLink]
                                                                   andMeta:nil];
            NSLog(@"%lu %@ %@ %lu %@", (unsigned long)category.categoryId, category.categoryName, category.categoryTitle,
                                        (unsigned long)category.categoryCount, category.categoryLink);
            return category;
        } else {
            NSLog(@"%@", @"Неверный ID");
        }
    }
    
    return nil;
}

- (FCPostTag *)getDataPostTagById:(NSUInteger)idPostTag {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"DataPostTag"
                inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    for (DataPostTag *obj in resultArray) {
        
        if ([obj.postTagId integerValue] == idPostTag) {
            
            FCPostTag *postTag = [[FCPostTag alloc] initPostTagWithId:[obj.postTagId integerValue]
                                                              andName:obj.postTagName
                                                             andCount:[obj.postTagCount integerValue]
                                                              andLink:[NSURL URLWithString: obj.postTagLink]
                                                              andMeta:nil];
            
            NSLog(@"%lu %@ %@ %lu", (unsigned long)postTag.postTagId, postTag.postTagName, postTag.postTagLink, (unsigned long)postTag.postTagCount);
            return postTag;
        } else {
            NSLog(@"%@", @"Неверный ID");
        }
    }
    
    return nil;
}

# pragma mark set to Data

- (void) setToDataAuthor:(FCAuthor *)author terms:(FCTerms *)terms post:(FCPost *)post {
    
    NSMutableArray *postTags = [NSMutableArray array];
    NSMutableArray *categories = [NSMutableArray array];

    for (FCPostTag *obj in terms.termsPostTag) {
        
        DataPostTag *dataPostTag = [NSEntityDescription insertNewObjectForEntityForName:@"DataPostTag"
                                                     inManagedObjectContext: self.managedObjectContext];
    
        dataPostTag.postTagCount   = [NSNumber numberWithInteger: obj.postTagCount];
        dataPostTag.postTagId      = [NSNumber numberWithInteger: obj.postTagId];
        dataPostTag.postTagLink    = [obj.postTagLink absoluteString];
        dataPostTag.postTagName    = obj.postTagName;
        
        [postTags addObject:dataPostTag];
        [self saveContext];
    }
    
    for (FCCategory *obj in terms.termsCategory) {
    
        DataCategory *dataCategory = [NSEntityDescription insertNewObjectForEntityForName:@"DataCategory"
                                                      inManagedObjectContext: self.managedObjectContext];
    
        dataCategory.categoryCount = [NSNumber numberWithInteger: obj.categoryCount];
        dataCategory.categoryId    = [NSNumber numberWithInteger: obj.categoryId];
        dataCategory.categoryTitle = obj.categoryTitle;
        dataCategory.categoryLink  = [obj.categoryLink absoluteString];
        dataCategory.categoryName  = obj.categoryName;
        
        [categories addObject:dataCategory];
        [self saveContext];
    }
    
    DataTerms *dataTerms = [NSEntityDescription insertNewObjectForEntityForName:@"DataTerms"
                                                         inManagedObjectContext: self.managedObjectContext];
    dataTerms.postTags = [NSSet setWithArray: postTags];
    dataTerms.categories = [NSSet setWithArray:categories];
    [self saveContext];
    
    DataAuthor *dataAuthor = [NSEntityDescription insertNewObjectForEntityForName:@"DataAuthor"
                                                    inManagedObjectContext: self.managedObjectContext];
    
    dataAuthor.authorFirstName = author.authorFirstName;
    dataAuthor.authorId        = [NSNumber numberWithInteger: author.authorId];
    dataAuthor.authorLastName  = author.authorLastName;
    dataAuthor.authorNickName  = author.authorNickName;
    dataAuthor.authorRegistered= author.authorRegistered;
    dataAuthor.authorUserName  = author.authorUserName;
    [self saveContext];

    DataPost *dataPost      = [NSEntityDescription insertNewObjectForEntityForName:@"DataPost"
                                                  inManagedObjectContext: self.managedObjectContext];
    
    dataPost.postContent       = post.postContent;
    dataPost.postDate          = post.postDate;
    dataPost.postDateModified  = post.postDateModified;
    dataPost.postExcerpt       = post.postExcerpt;
    dataPost.postId            = [NSNumber numberWithInteger: post.postId];
    dataPost.postLink          = [post.postLink absoluteString];
    dataPost.postTitle         = post.postTitle;
    dataPost.author            = dataAuthor;
    dataPost.term              = dataTerms;
    [self saveContext];
}

#pragma mark - Core Data Stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"coreData" withExtension:@"momd"];
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"coreData.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving & Delete

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)deleteAllObjects {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"DataObject"
                inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    for (id object in resultArray) {
        [self.managedObjectContext deleteObject:object];
    }
    [self.managedObjectContext save:nil];
}

@end
