//
//  NewsContentContoller.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 31.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//


/* 
 News Content Presetation goes here
*/ 
 
#import <UIKit/UIKit.h>
#import "FCPost.h"


@interface NewsContentContoller : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *tempWebView;

@property (strong,nonatomic) FCPost* post;

@end
