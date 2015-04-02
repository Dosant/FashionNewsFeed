//
//  PersistencyManager.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 01.04.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "PersistencyManager.h"
#import "FCPost.h"

@implementation PersistencyManager


- (id)init
{
    self = [super init];
    if (self)
    {
        self.categoriesList = @[@"news", @"fashion",@"collections",@"people",@"beaty"];
        
        FCPost *post = [[FCPost alloc] initPostWithId: 123
                                                 type: @"Type1"
                                            urlString: [NSURL URLWithString:@"http://apple.com"]
                                                title: @"bla-bla-bla"
                                        contentString: @"BLA"
                                           dateString: [NSDate date]];
        [self.arrayOfPost addObject: post];

        FCPost *post1 = [[FCPost alloc] initPostWithId: 124
                                                 type: @"Type2"
                                            urlString: [NSURL URLWithString:@"http://apple.com"]
                                                title: @"FORTE GROUP"
                                        contentString: @"BLA"
                                        dateString: [NSDate date]];
        [self.arrayOfPost addObject: post1];

        FCPost *post2 = [[FCPost alloc] initPostWithId: 125
                                                 type: @"Type1"
                                            urlString: [NSURL URLWithString:@"http://apple.com"]
                                                title: @"IOS DEV"
                                        contentString: @"BLA"
                                           dateString: [NSDate date]];
        [self.arrayOfPost addObject: post2];

        FCPost *post3 = [[FCPost alloc] initPostWithId: 126
                                                 type: @"Type2"
                                            urlString: [NSURL URLWithString:@"http://apple.com"]
                                                title: @"HI MY NAME IS VLADISLAV"
                                        contentString: @"BLA"
                                           dateString: [NSDate date]];
        [self.arrayOfPost addObject: post3];
    }
    return self;
}




@end
