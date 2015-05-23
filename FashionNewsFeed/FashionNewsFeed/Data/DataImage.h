//
//  DataImage.h
//  FashionNewsFeed
//
//  Created by Владислав Станишевский on 5/23/15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DataImage : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * url;

@end
