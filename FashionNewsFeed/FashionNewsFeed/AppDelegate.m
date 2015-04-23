//
//  AppDelegate.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "AppDelegate.h"
#import "PersistencyManager.h"
#import "FCCategory.h"
#import "FCPostTag.h"
#import "FCAuthor.h"
#import "FCTerms.h"
#import "FCPost.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
      
 [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:4.0 forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setBackgroundVerticalPositionAdjustment:4 forBarMetrics:UIBarMetricsDefault];
    
    
    PersistencyManager *manager = [[PersistencyManager alloc] init];
    
    FCCategory *category = [[FCCategory alloc] initCategoryWithId:1
                                                          andName:@"Fashion"
                                                         andTitle:@"News"
                                                         andCount:20
                                                          andLink:[NSURL URLWithString:@"www.tut.by"]
                                                          andMeta:nil];
    
    FCCategory *category2 = [[FCCategory alloc] initCategoryWithId:2
                                                          andName:@"Profession"
                                                         andTitle:@"News"
                                                         andCount:20
                                                          andLink:[NSURL URLWithString:@"www.tut.by"]
                                                          andMeta:nil];
    
    FCPostTag *postTag = [[FCPostTag alloc] initPostTagWithId:1
                                                      andName:@"t-shirts"
                                                     andCount:10
                                                      andLink:[NSURL URLWithString:@"http//"]
                                                      andMeta:nil];
    
    FCPostTag *postTag2 = [[FCPostTag alloc] initPostTagWithId:2
                                                      andName:@"shirts"
                                                     andCount:10
                                                      andLink:[NSURL URLWithString:@"http//"]
                                                      andMeta:nil];
    
    FCAuthor *author = [[FCAuthor alloc] initAuthorWithId:1
                                              andUserName:@"Vladok"
                                             andFirstName:@"Vladislav"
                                              andLastName:@"Solo"
                                              andNickName:@"Stas"
                                                andAvatar:nil
                                            andRegistered:[NSDate dateWithTimeIntervalSince1970:37273]
                                                  andMeta:nil];
    
    FCTerms *terms = [[FCTerms alloc] initTermsWithPostTag:[NSMutableArray arrayWithObjects: postTag, postTag2, nil]
                                               andCategory:[NSMutableArray arrayWithObjects: category,category2, nil]];
    
    FCPost *post = [[FCPost alloc] initPostWithId:1
                                         andTitle:@"Welcome to FCollection"
                                        andAuthor:author
                                       andContent:@"Helo bla bla"
                                          andLink:[NSURL URLWithString:@"www.fcollection.by"]
                                          andDate:[NSDate dateWithTimeIntervalSince1970:12345]
                                  andDateModified:[NSDate dateWithTimeIntervalSince1970:12789]
                                       andExcerpt:@"Ok"
                                          andMeta:nil
                                 andFeaturedImage:nil
                                         andTerms:terms];
    
    [manager setToDataPost: post];
    [manager get];
    
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
