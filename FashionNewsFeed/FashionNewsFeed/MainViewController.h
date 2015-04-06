//
//  ViewController.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//


/*
 Main ViewConroller. -- Wrapper for PageViewController.
 Goes Here
 
*/

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import "SWRevealViewController.h"
#import "FashionCollectionAPI.h"


@interface MainViewController : UIViewController <UIPageViewControllerDataSource, UIScrollViewDelegate, UIPageViewControllerDelegate , PageContentViewControllerDelegate, SWRevealViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;

@end

