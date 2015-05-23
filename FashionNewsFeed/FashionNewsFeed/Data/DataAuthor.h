//
//  DataAuthor.h
//  FashionNewsFeed
//
//  Created by Владислав Станишевский on 5/23/15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DataPost;

@interface DataAuthor : NSManagedObject

@property (nonatomic, retain) NSString * authorFirstName;
@property (nonatomic, retain) NSNumber * authorId;
@property (nonatomic, retain) NSString * authorLastName;
@property (nonatomic, retain) NSString * authorNickName;
@property (nonatomic, retain) NSDate * authorRegistered;
@property (nonatomic, retain) NSString * authorUserName;
@property (nonatomic, retain) DataPost *post;

@end
