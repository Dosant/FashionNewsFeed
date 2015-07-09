//
//  DataFeaturedImage.h
//  FashionNewsFeed
//
//  Created by Владислав Станишевский on 5/23/15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DataPost;

@interface DataFeaturedImage : NSManagedObject

@property (nonatomic, retain) NSNumber * imageId;
@property (nonatomic, retain) NSString * imageTitl;
@property (nonatomic, retain) NSString * imageSource;
@property (nonatomic, retain) NSNumber * imageHeight;
@property (nonatomic, retain) NSNumber * imageWidth;
@property (nonatomic, retain) DataPost *post;

@end
