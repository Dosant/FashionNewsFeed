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

#pragma mark - Data Manager

- (void) setToDataPostTag:(FCPostTag *)postTag category:(FCCategory *)category author:(FCAuthor *)author term:(FCTerms *)term post:(FCPost *)post {
    
    self.dataPostTag = [NSEntityDescription insertNewObjectForEntityForName:@"DataPostTag"
                                                     inManagedObjectContext: self.managedObjectContext];
    
    self.dataPostTag.postTagCount   = [NSNumber numberWithInteger: postTag.postTagCount];
    self.dataPostTag.postTagId      = [NSNumber numberWithInteger: postTag.postTagId];
    self.dataPostTag.postTagLink    = postTag.postTagLink;
    self.dataPostTag.postTagName    = postTag.postTagName;
    
    
    self.dataCategory = [NSEntityDescription insertNewObjectForEntityForName:@"DataCategory"
                                                      inManagedObjectContext: self.managedObjectContext];
    
    self.dataCategory.categoryCount = [NSNumber numberWithInteger: category.categoryCount];
    self.dataCategory.categoryId    = [NSNumber numberWithInteger: category.categoryId];
    self.dataCategory.categoryLink  = category.categoryLink;
    self.dataCategory.categoryName  = category.categoryName;
    
    self.dataAuthor = [NSEntityDescription insertNewObjectForEntityForName:@"DataAuthor"
                                                    inManagedObjectContext: self.managedObjectContext];
    
    self.dataAuthor.authorFirstName = author.authorFirstName;
    self.dataAuthor.authorId        = [NSNumber numberWithInteger: author.authorId];
    self.dataAuthor.authorLastName  = author.authorLastName;
    self.dataAuthor.authorNickName  = author.authorNickname;
    self.dataAuthor.authorRegistered= author.authorRegistered;
    self.dataAuthor.authorUserName  = author.authorUsername;
    
    self.dataTerms = [NSEntityDescription insertNewObjectForEntityForName:@"DataTerms"
                                                   inManagedObjectContext: self.managedObjectContext];
    
    self.dataTerms.termsId = [NSNumber numberWithInteger: term.termsId];
    self.dataTerms.postTags = [NSSet setWithObject: self.dataPostTag];
    self.dataTerms.categories = [NSSet setWithObject: self.dataCategory];
    
    self.dataPost = [NSEntityDescription insertNewObjectForEntityForName:@"DataPost"
                                                  inManagedObjectContext: self.managedObjectContext];
    
    self.dataPost.postContent       = post.postContent;
    self.dataPost.postDate          = post.postDate;
    self.dataPost.postDateModified  = post.postDateModified;
    self.dataPost.postExcerpt       = post.postExcerpt;
    self.dataPost.postId            = [NSNumber numberWithInteger: post.postId];
    self.dataPost.postLink          = post.postLink;
    self.dataPost.postTitle         = post.postTitle;
    self.dataPost.author            = self.dataAuthor;
    self.dataPost.term              = self.dataTerms;
    
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

#pragma mark - Core Data Saving support

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

@end
