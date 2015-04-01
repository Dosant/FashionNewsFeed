//
//  ViewController.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController{
    
// Pages Controls
    
    NSMutableArray* contentPages;
    NSUInteger _currentPage;
    
// Flags defining if scroll disabled
    BOOL isPageToBounce;
    BOOL isDisableScroll;
    
// MenuOpen
    
    BOOL isSideBarOpen;
    UIView* overlayViewToDisableMainController;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.pageTitles = [[NewsAPI sharedInstance] getCategories];
    
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    isPageToBounce = NO;
    isDisableScroll = NO;
    isSideBarOpen = NO;
    
    
    
    
    
    // Adding pageConroller on the mainViewController
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    
    //Find and set ScrollView of pageViewConroller delegate
    for (UIView *view in self.pageViewController.view.subviews ) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scroll = (UIScrollView *)view;
            scroll.delegate = self;
        }
    }
    
    self.revealViewController.delegate = self;
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - RevealMenu Setup

- (void)setupRevealControllerContentPage:(PageContentViewController* )contollerToSetup{
    
   
    UIBarButtonItem* menuButton = contollerToSetup.barButtonMenuIcon;
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [menuButton setTarget: self.revealViewController];
        [menuButton setAction: @selector( revealToggle: )];
        
        if(contollerToSetup.pageIndex == 0){
            
            [contollerToSetup.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
        }
        
    }
    
}

#pragma mark - RevealMenu Delegate

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position{

    if (position == 3 || position == 4){
        
        
        UINavigationController* nav = _pageViewController.viewControllers[0];
        PageContentViewController* pc = [self pageContentControllerInNavigationController:nav];
        
        if(!overlayViewToDisableMainController){
            overlayViewToDisableMainController = [[UIView alloc]initWithFrame:pc.view.frame];
            overlayViewToDisableMainController.alpha = 0.2;
            overlayViewToDisableMainController.backgroundColor = [UIColor blackColor];
            [overlayViewToDisableMainController addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
        }
        
        
    
        if(position == 3){ // SideBar is Closed
            
            isSideBarOpen = NO;
            [overlayViewToDisableMainController removeFromSuperview];
        
        
        
        
        } else if(position == 4) { // SideBar is Opened
            
            isSideBarOpen = YES;
            [pc.view addSubview:overlayViewToDisableMainController];
            
        }
    }
    
    
}



    





#pragma mark - PageViewContoller DataSource


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    PageContentViewController* currentContentPage = [self pageContentControllerInNavigationController:((UINavigationController *) viewController) ];
    
    if (currentContentPage == nil) {
        return nil;
    }
    NSUInteger index = currentContentPage.pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    PageContentViewController* currentContentPage = [self pageContentControllerInNavigationController:((UINavigationController *) viewController) ];
    
    if (currentContentPage == nil) {
        return nil;
    }
    
    NSUInteger index = currentContentPage.pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    
    
    index++;
    
    if (index == [self.pageTitles count] ) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

#pragma mark - Additinal setup for pageContoller

-(PageContentViewController *)pageContentControllerInNavigationController:(UINavigationController *)navigationController{
    
    if([[navigationController topViewController] isKindOfClass: [PageContentViewController class]]){
        
        return (PageContentViewController *)[navigationController topViewController];
    }
    
    return nil;
    
}


- (UIViewController *)viewControllerAtIndex:(NSUInteger)index // Determine which page is next
{
    
    // out of bounds
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    
    //if cache array not initialized yet
    if(contentPages == nil) {
        contentPages = [NSMutableArray array];
        [contentPages addObject: [self initializePageContentController:index]];
    }
    
    //initialize next after next
    if (contentPages.count <= index + 1) {
        
        UINavigationController* nextNextPage = (UINavigationController *)[self initializePageContentController:index + 1];
        if (nextNextPage != nil){
            
            [contentPages addObject: nextNextPage];
        }
    }
    
    
    
    
    return contentPages[index];
}

-(UIViewController *) initializePageContentController:(NSUInteger)index{
    
    if(index >= self.pageTitles.count){
        return nil;
    }
    
    UINavigationController* nav = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentNavigationController"];
    
    
    PageContentViewController* pageContentViewContoller = [self pageContentControllerInNavigationController: nav];
    
    
    pageContentViewContoller.pageIndex = index;
    pageContentViewContoller.pageTitle = self.pageTitles[index];
    pageContentViewContoller.delegate = self;
    [self setupRevealControllerContentPage:pageContentViewContoller];
    
    
    return nav;
    
}








#pragma mark - UIScrollViewConroller DELEGATE


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!isDisableScroll){
    if (NO == isPageToBounce) {
        if (_currentPage == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width) {
            scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        }
        if (_currentPage == ([self.pageTitles count] - 1) && scrollView.contentOffset.x > scrollView.bounds.size.width) {
            scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        }
    }
    } else {
        
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        
    }
    // more
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if(!isDisableScroll){
    if (NO == isPageToBounce) {
        if (_currentPage == 0 && scrollView.contentOffset.x <= scrollView.bounds.size.width) {
            velocity = CGPointZero;
            *targetContentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        }
        if (_currentPage == ([self.pageTitles count] - 1) && scrollView.contentOffset.x >= scrollView.bounds.size.width) {
            velocity = CGPointZero;
            *targetContentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        }
    }
    } else {
        
        
        velocity = CGPointZero;
        *targetContentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        
        
    }
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    if(completed){
        
        _currentPage = [ self pageContentControllerInNavigationController:((UINavigationController*)pageViewController.viewControllers.lastObject) ].pageIndex;
        if(_currentPage == 0 || _currentPage == ([self.pageTitles count] - 1)){
            isPageToBounce = NO;
        } else {
            isPageToBounce = YES;
        }
        
    }
    
    
}


#pragma mark - PageContentViewControllerDelegate
-(void) setScrollEnabled:(PageContentViewController *)pageContentViewConroller
                 enabled:(BOOL)enabled{
    
    isDisableScroll = !enabled;
    
    
}






@end
