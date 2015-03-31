//
//  PageContentViewConroller.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 Page representating news list (One page for each category + all news)
*/

@class PageContentViewController;
@protocol PageContentViewControllerDelegate <NSObject>

- (void)setScrollEnabled:(PageContentViewController*) pageContentViewConroller enabled: (BOOL)enabled;

@end

@interface PageContentViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonMenuIcon;
@property NSUInteger pageIndex;
@property (weak,nonatomic) id<PageContentViewControllerDelegate> delegate;

@end


