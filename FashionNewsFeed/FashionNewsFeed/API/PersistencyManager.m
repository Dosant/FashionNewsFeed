//
//  PersistencyManager.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 01.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "PersistencyManager.h"
#import "DataPost.h"
#import "DataAuthor.h"
#import "DataTerms.h"
#import "DataCategory.h"
#import "DataPostTag.h"
#import "DataImage.h"
#import "DataFeaturedImage.h"

NSUInteger const MAXNUMBERPOST = 49;
NSUInteger const MAXNUMBERIMAGE = 100;

@interface PersistencyManager ()

@property (strong, nonatomic) NSUserDefaults *counter;
@property (strong, nonatomic) NSUserDefaults *postCounter;

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

#pragma mark - get from Data

- (NSUInteger)getPostCountByCategory:(NSString *)category {
    
    NSUInteger counter = 0;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"DataPost"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    for (DataPost *dataPost in resultArray) {
        
        for (DataCategory *categoryName in dataPost.term.categories) {
            
            if ([categoryName.categoryName isEqual:category]) {
                
                counter++;
            }
        }
    }
    return counter;
}

- (UIImage *)getImageForUrl:(NSURL *)url {
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"DataImage"
                                                   inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url = %@", [url absoluteString]];
    
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (requestError) {
        
        NSLog(@"%@", [requestError localizedDescription]);
        return nil;
    } else {
        
        for (DataImage *dataImage in resultArray) {
            UIImage* image = [UIImage imageWithData: dataImage.image];
            return image;
            
        }
    }
    return nil;
}

- (FCPost *)getPostById:(NSUInteger)postId {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"DataPost"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
        return nil;
    }
    
    NSMutableArray *categories = [NSMutableArray array];
    NSMutableArray *postTags = [NSMutableArray array];

    for (DataPost *dataPost in resultArray) {
        
        if ([dataPost.postId integerValue] == postId) {
            
            FCAuthor *author = [[FCAuthor alloc] initAuthorWithId:[dataPost.author.authorId integerValue]
                                                      andUserName:dataPost.author.authorUserName
                                                     andFirstName:dataPost.author.authorFirstName
                                                      andLastName:dataPost.author.authorLastName
                                                      andNickName:dataPost.author.authorNickName
                                                        andAvatar:nil
                                                    andRegistered:dataPost.author.authorRegistered andMeta:nil];

            for (DataCategory *dataCategory in dataPost.term.categories) {
                
                FCCategory *category = [[FCCategory alloc] initCategoryWithId:[dataCategory.categoryId integerValue]
                                                                      andName:dataCategory.categoryName
                                                                     andTitle:dataCategory.categoryTitle
                                                                     andCount:[dataCategory.categoryCount integerValue]
                                                                      andLink:[NSURL URLWithString:dataCategory.categoryLink]
                                                                      andMeta:nil];
                NSLog(@"CATEGORY, %@",dataCategory.categoryName);
                [categories addObject:category];
            }
            
            for (DataPostTag *dataPostTag in dataPost.term.postTags) {
                
                FCPostTag *postTag = [[FCPostTag alloc] initPostTagWithId:[dataPostTag.postTagId integerValue]
                                                                  andName:dataPostTag.postTagName
                                                                 andCount:[dataPostTag.postTagCount integerValue]
                                                                  andLink:[NSURL URLWithString:dataPostTag.postTagLink]
                                                                  andMeta:nil];
                [postTags addObject:postTag];
            }
            
            FCTerms *terms = [[FCTerms alloc] initTermsWithPostTag:postTags andCategory:categories];
            
            FCFeaturedImage *featuredImage = [[FCFeaturedImage alloc] init];
            featuredImage.imageId = [dataPost.featuredImage.imageId integerValue];
            featuredImage.imageTitle = dataPost.featuredImage.imageTitl;
            featuredImage.imageSource = [NSURL URLWithString: dataPost.featuredImage.imageSource];
            featuredImage.imageHeight = [dataPost.featuredImage.imageHeight integerValue];
            featuredImage.imageWidth = [dataPost.featuredImage.imageWidth integerValue];
            
            FCPost *post = [[FCPost alloc] initPostWithId:[dataPost.postId integerValue]
                                                 andTitle:dataPost.postTitle
                                                andAuthor:author
                                               andContent:dataPost.postContent
                                                  andLink:[NSURL URLWithString: dataPost.postLink]
                                                  andDate:dataPost.postDate
                                          andDateModified:dataPost.postDateModified
                                               andExcerpt:dataPost.postExcerpt
                                                  andMeta:nil
                                         andFeaturedImage:featuredImage
                                                 andTerms:terms];
            return post;
        }
    }
    return nil;
}

- (NSArray *)getPostsByCategory:(NSString *)category {

    NSMutableArray *posts = [NSMutableArray array];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"DataPost"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"postDate" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
        return nil;
    }
    
    for (DataPost *dataPost in resultArray) {
        
        NSMutableArray *categories = [NSMutableArray array];
        NSMutableArray *postTags = [NSMutableArray array];
        
        for (DataCategory *categoryName in dataPost.term.categories) {
        
            NSLog(@"CATEGORY to load %@",category);
            NSLog(@"CATEGORY to find %@",categoryName.categoryName);
        if ([categoryName.categoryName isEqual:category]) {
        
            FCAuthor *author = [[FCAuthor alloc] initAuthorWithId:[dataPost.author.authorId integerValue]
                                                      andUserName:dataPost.author.authorUserName
                                                     andFirstName:dataPost.author.authorFirstName
                                                      andLastName:dataPost.author.authorLastName
                                                      andNickName:dataPost.author.authorNickName
                                                        andAvatar:nil
                                                    andRegistered:dataPost.author.authorRegistered andMeta:nil];

            for (DataCategory *dataCategory in dataPost.term.categories) {
                
                 FCCategory *category = [[FCCategory alloc] initCategoryWithId:[dataCategory.categoryId integerValue]
                                                                      andName:dataCategory.categoryName
                                                                     andTitle:dataCategory.categoryTitle
                                                                     andCount:[dataCategory.categoryCount integerValue]
                                                                      andLink:[NSURL URLWithString:dataCategory.categoryLink]
                                                                      andMeta:nil];
                
                [categories addObject:category];

            }
            
            for (DataPostTag *dataPostTag in dataPost.term.postTags) {
                
                FCPostTag *postTag = [[FCPostTag alloc] initPostTagWithId:[dataPostTag.postTagId integerValue]
                                                                  andName:dataPostTag.postTagName
                                                                 andCount:[dataPostTag.postTagCount integerValue]
                                                                  andLink:[NSURL URLWithString:dataPostTag.postTagLink]
                                                                  andMeta:nil];
                [postTags addObject:postTag];

            }
            
            FCTerms *terms = [[FCTerms alloc] initTermsWithPostTag:postTags andCategory:categories];
            
            FCFeaturedImage *featuredImage = [[FCFeaturedImage alloc] init];
            featuredImage.imageId = [dataPost.featuredImage.imageId integerValue];
            featuredImage.imageTitle = dataPost.featuredImage.imageTitl;
            featuredImage.imageSource = [NSURL URLWithString: dataPost.featuredImage.imageSource];
            featuredImage.imageHeight = [dataPost.featuredImage.imageHeight integerValue];
            featuredImage.imageWidth = [dataPost.featuredImage.imageWidth integerValue];
            
            FCPost *post = [[FCPost alloc] initPostWithId:[dataPost.postId integerValue]
                                                 andTitle:dataPost.postTitle
                                                andAuthor:author
                                               andContent:dataPost.postContent
                                                  andLink:[NSURL URLWithString: dataPost.postLink]
                                                  andDate:dataPost.postDate
                                          andDateModified:dataPost.postDateModified
                                               andExcerpt:dataPost.postExcerpt
                                                  andMeta:nil
                                         andFeaturedImage:featuredImage
                                                 andTerms:terms];
            
            [posts addObject: post];
        }
        }
    }
    return posts;
}

- (NSArray *)getAllPosts {
    
    NSMutableArray *posts = [NSMutableArray array];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"DataPost"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];

    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
        return nil;
    }
    
    
    
    for (DataPost *dataPost in resultArray) {
        
        NSMutableArray *categories = [NSMutableArray array];
        NSMutableArray *postTags = [NSMutableArray array];
        
        FCAuthor *author = [[FCAuthor alloc] initAuthorWithId:[dataPost.author.authorId integerValue]
                                                  andUserName:dataPost.author.authorUserName
                                                 andFirstName:dataPost.author.authorFirstName
                                                  andLastName:dataPost.author.authorLastName
                                                  andNickName:dataPost.author.authorNickName
                                                    andAvatar:nil
                                                andRegistered:dataPost.author.authorRegistered andMeta:nil];
        
        for (DataCategory *dataCategory in dataPost.term.categories) {
            
            FCCategory *category = [[FCCategory alloc] initCategoryWithId:[dataCategory.categoryId integerValue]
                                                                  andName:dataCategory.categoryName
                                                                 andTitle:dataCategory.categoryTitle
                                                                 andCount:[dataCategory.categoryCount integerValue]
                                                                  andLink:[NSURL URLWithString:dataCategory.categoryLink]
                                                                  andMeta:nil];
            [categories addObject:category];
            
        }
        
        for (DataPostTag *dataPostTag in dataPost.term.postTags) {
            
            FCPostTag *postTag = [[FCPostTag alloc] initPostTagWithId:[dataPostTag.postTagId integerValue]
                                                              andName:dataPostTag.postTagName
                                                             andCount:[dataPostTag.postTagCount integerValue]
                                                              andLink:[NSURL URLWithString:dataPostTag.postTagLink]
                                                              andMeta:nil];
            [postTags addObject:postTag];
            
        }
        
        FCTerms *terms = [[FCTerms alloc] initTermsWithPostTag:postTags andCategory:categories];
        
        FCFeaturedImage *featuredImage = [[FCFeaturedImage alloc] init];
        featuredImage.imageId = [dataPost.featuredImage.imageId integerValue];
        featuredImage.imageTitle = dataPost.featuredImage.imageTitl;
        featuredImage.imageSource = [NSURL URLWithString: dataPost.featuredImage.imageSource];
        featuredImage.imageHeight = [dataPost.featuredImage.imageHeight integerValue];
        featuredImage.imageWidth = [dataPost.featuredImage.imageWidth integerValue];
        
        FCPost *post = [[FCPost alloc] initPostWithId:[dataPost.postId integerValue]
                                             andTitle:dataPost.postTitle
                                            andAuthor:author
                                           andContent:dataPost.postContent
                                              andLink:[NSURL URLWithString: dataPost.postLink]
                                              andDate:dataPost.postDate
                                      andDateModified:dataPost.postDateModified
                                           andExcerpt:dataPost.postExcerpt
                                              andMeta:nil
                                     andFeaturedImage:featuredImage
                                             andTerms:terms];
        
        [posts addObject: post];
    }
    return posts;
    
}

# pragma mark set to Data

- (void)cacheImage:(UIImage *)image forURL:(NSURL *)url {
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"DataImage"
                                                         inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSError* reqError = nil;
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:fetchRequest error:&reqError]];
    
    if (reqError) {
        NSLog(@"%@", [reqError localizedDescription]);
    }
    
    if (array.count >= MAXNUMBERIMAGE) {
        
        [self deleteImage];
        [self setToDataImage:image forURL:url];
    } else {
        
        [self setToDataImage:image forURL:url];
    }
    
}

- (void)setToDataImage:(UIImage *)image forURL:(NSURL *)url {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"DataImage"
                                                   inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url = %@", url];
    
    [request setPredicate:predicate];
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    if (resultArray.count == 0) {
        
        DataImage *dataImage = [NSEntityDescription insertNewObjectForEntityForName:@"DataImage"
                                                             inManagedObjectContext: self.managedObjectContext];

        dataImage.url = [url absoluteString];
        dataImage.image = UIImagePNGRepresentation(image);

        [self saveContext];
    }
}

- (void) setToDataPosts:(NSArray *)posts {
    
    for (FCPost *post in posts) {
        
        [self addPostToQueue:post];
    }
}

- (void)addPostToQueue:(FCPost *)post {
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"DataPost"
                                                         inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSError* reqError = nil;
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:fetchRequest error:&reqError]];
    
    if (reqError) {
        NSLog(@"%@", [reqError localizedDescription]);
    }
    
    if (array.count >= MAXNUMBERPOST) {
        
        [self deleteFirstPost];
        [self cachePost:post];
    } else {
        
        [self cachePost:post];
    }
}

- (void)cachePost:(FCPost *)post {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"DataPost"
                                                   inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"postId = %d", post.postId];
    
    [request setPredicate:predicate];
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    if (resultArray.count == 0) {

        DataAuthor *dataAuthor = [NSEntityDescription insertNewObjectForEntityForName:@"DataAuthor"
                                                               inManagedObjectContext: self.managedObjectContext];
        
        dataAuthor.authorFirstName = post.postAuthor.authorFirstName;
        dataAuthor.authorId        = [NSNumber numberWithInteger: post.postAuthor.authorId];
        dataAuthor.authorLastName  = post.postAuthor.authorLastName;
        dataAuthor.authorNickName  = post.postAuthor.authorNickName;
        dataAuthor.authorRegistered= post.postAuthor.authorRegistered;
        dataAuthor.authorUserName  = post.postAuthor.authorUserName;
        [self saveContext];
        
        NSMutableArray *postTags = [NSMutableArray array];
        NSMutableArray *categories = [NSMutableArray array];
        
        for (FCPostTag *obj in post.postTerms.termsPostTag) {
            
            DataPostTag *dataPostTag = [NSEntityDescription insertNewObjectForEntityForName:@"DataPostTag"
                                                                     inManagedObjectContext: self.managedObjectContext];
            
            dataPostTag.postTagCount   = [NSNumber numberWithInteger: obj.postTagCount];
            dataPostTag.postTagId      = [NSNumber numberWithInteger: obj.postTagId];
            dataPostTag.postTagLink    = [obj.postTagLink absoluteString];
            dataPostTag.postTagName    = obj.postTagName;
            
            [postTags addObject:dataPostTag];
            [self saveContext];
        }
        
        for (FCCategory *obj in post.postTerms.termsCategory) {
            
            DataCategory *dataCategory = [NSEntityDescription insertNewObjectForEntityForName:@"DataCategory"
                                                                       inManagedObjectContext: self.managedObjectContext];
            
            dataCategory.categoryCount = [NSNumber numberWithInteger: obj.categoryCount];
            dataCategory.categoryId    = [NSNumber numberWithInteger: obj.categoryId];
            dataCategory.categoryTitle = obj.categoryTitle;
            dataCategory.categoryLink  = [obj.categoryLink absoluteString];
            dataCategory.categoryName  = obj.categoryName;
            
            NSLog(@"%@", dataCategory.categoryName);
            
            [categories addObject:dataCategory];
            [self saveContext];
        }
        
        DataTerms *dataTerms = [NSEntityDescription insertNewObjectForEntityForName:@"DataTerms"
                                                             inManagedObjectContext: self.managedObjectContext];
        dataTerms.postTags = [NSSet setWithArray: postTags];
        dataTerms.categories = [NSSet setWithArray:categories];
        [self saveContext];
        
        DataFeaturedImage *dataFeaturedImage  = [NSEntityDescription insertNewObjectForEntityForName:@"DataFeaturedImage"
                                                                              inManagedObjectContext: self.managedObjectContext];
        
        dataFeaturedImage.imageId = [NSNumber numberWithInteger: post.postFeaturedImage.imageId];
        dataFeaturedImage.imageSource = [post.postFeaturedImage.imageSource absoluteString];
        dataFeaturedImage.imageTitl = post.postFeaturedImage.imageTitle;
        dataFeaturedImage.imageHeight = [NSNumber numberWithInteger:post.postFeaturedImage.imageHeight];
        dataFeaturedImage.imageWidth = [NSNumber numberWithInteger:post.postFeaturedImage.imageWidth];

        
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
        dataPost.featuredImage = dataFeaturedImage;
        
        [self saveContext];
    }
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

- (void)deletePosts {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"DataPost"
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

- (void)deleteFirstPost {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"DataPost"
                inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"postId" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    request.fetchLimit = 1;
    
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

- (void)deleteImage {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"DataImage"
                inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"url" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    request.fetchLimit = 1;
    
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

- (void)deleteImages {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"DataImage"
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
