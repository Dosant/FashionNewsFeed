//
//  PageContentViewConroller.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "PageContentViewController.h"
#import "FashionCollectionAPI.h"
#import "FCTableViewCell1.h"
#import "FCTableViewCell2.h"
#import "FCTableViewCell3.h"
#import "FCTableViewCell4.h"
#import "NewsContentContoller.h"

#import <AFNetworking/UIKit+AFNetworking.h>
#import <DateTools/DateTools.h>

#import "RKDropdownAlert.h"
#import <GTScrollNavigationBar.h>

@interface PageContentViewController ()

@end

@implementation PageContentViewController{
    
    NSMutableArray* postsToPresent;
    NSUInteger postsPerPage;
    UIActivityIndicatorView *activityView;
    BOOL postsLoaded;
    
    NSUInteger totalPosts;
    NSUInteger totalPages;
    
    
    BOOL newPostsAreLoading;
    
    BOOL isNetwork;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    isNetwork = [FashionCollectionAPI sharedInstance].isNetwork;
    
    
    self.title = _pageTitle;
    postsLoaded = NO;
    postsPerPage = 7;
    
    
    //Starting activity
    activityView = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.center= CGPointMake(self.view.center.x, 20);
    
    [activityView startAnimating];
    [self.view addSubview:activityView];
    
    
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadPosts)
                  forControlEvents:UIControlEventValueChanged];

    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    
    
    [self reloadPosts];
    
    
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[self delegate] setScrollEnabled:self enabled:YES];
    self.navigationController.scrollNavigationBar.scrollView = self.tableView;
    [[FashionCollectionAPI sharedInstance] addObserver:self forKeyPath:@"isNetwork" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    //[self.tableView reloadData];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    @try {
        [[FashionCollectionAPI sharedInstance] removeObserver:self forKeyPath:@"isNetwork"];
    }
    @catch (NSException * __unused exception) {}
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isNetwork"]) {
        NSLog(@"isNetwork");
        NSLog(@"%@", change);

        isNetwork = [[FashionCollectionAPI sharedInstance] isNetwork];
        
        if (!isNetwork) {
            if (change[@"new"] != change[@"old"]) {
                [RKDropdownAlert title:@"Нет Интернета ..." time:3];
            }
            [self loadCachePosts];
        }
    }
}



-(void)reloadPosts{
    
    [self loadMorePostsFromPage:1];
    
}
-(void)loadCachePosts{
    
    newPostsAreLoading = false;
    [self.refreshControl endRefreshing];
    
    
    if (!postsLoaded){
        postsLoaded = YES;
        [activityView stopAnimating];
        [activityView removeFromSuperview];
    }
    
    NSArray* posts = [[FashionCollectionAPI sharedInstance] getDataPostsByCategory:_pageIndex];
    postsToPresent = [NSMutableArray arrayWithArray:posts];
    [self.tableView reloadData];
    
}

-(void)loadMorePostsFromPage:(NSUInteger)page{
    
    if (newPostsAreLoading) {
        return;
    } else {
    
        newPostsAreLoading = true;
    
     void (^success)(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers) = ^(NSURLSessionDataTask *task, NSMutableArray *posts, FCResponseHeaders *headers) {
    
        
        // NSLog(@"total posts : %d \n totalPages : %d",headers.totalPosts,headers.totalPages);
         totalPages = headers.totalPages;
         totalPosts = headers.totalPosts;
         
         
         
        [self.tableView beginUpdates];
         
        if (postsToPresent != nil){
            
            if(page == 1){ // reload
                
                NSUInteger count = [self.tableView numberOfRowsInSection:0];
                
                for (int i = 0 ; i < count ; i++) {
                    NSIndexPath* path = [NSIndexPath indexPathForRow:i inSection:0];
                    [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
                 }
                
                [postsToPresent removeAllObjects];
            }
            
            [postsToPresent addObjectsFromArray:posts];
        } else {
            postsToPresent = [NSMutableArray arrayWithArray:posts];

        }
        if (!postsLoaded){
            postsLoaded = YES;
            [activityView stopAnimating];
            [activityView removeFromSuperview];
        }
        
         
        newPostsAreLoading = false;
        [self.refreshControl endRefreshing];
         
         //TODO
         
         for (int i = 0 ; i < MIN(postsPerPage,posts.count); i++) {
             NSIndexPath* path = [NSIndexPath indexPathForRow:((page - 1)*postsPerPage + i) inSection:0];
              [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
         }
         
         [self.tableView endUpdates];
    
    };
    
    
     void (^failure)(NSURLSessionDataTask *task, NSError* error) = ^(NSURLSessionDataTask *task,  NSError *error) {
        newPostsAreLoading = false;
        NSLog(@"%@",[error localizedDescription]);
        
    };
    
    
    
        [[FashionCollectionAPI sharedInstance] getPostsForPageCategory:_pageIndex pageNumber:page postsPerPage:postsPerPage success:success failure:failure];
    
    }
}




#pragma mark - tableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    FCPost* post = (FCPost*)[postsToPresent objectAtIndex:indexPath.row];
    FCFeaturedImage* featuredImage =  post.postFeaturedImage;
    
    NSDate* date = post.postDate;
    
    //post.post
    
    switch ([self whichCellToUse:featuredImage]) {
        case 0: // small image -- no image
        {
            FCTableViewCell3* cell = [tableView dequeueReusableCellWithIdentifier:@"FCCell3" forIndexPath:indexPath];
            cell.FCCellTitle.text = post.postTitle;
            cell.post = post;
            
            cell.FCCellCategory.text = post.getCategoriesString;
            cell.FCCellDate.text = date.timeAgoSinceNow;
            
            return cell;
        }
            break;
            
        case 1: // w>>h
        {
            FCTableViewCell2* cell = [tableView dequeueReusableCellWithIdentifier:@"FCCell2" forIndexPath:indexPath];
            cell.FCCellTitle.text = post.postTitle;
            cell.post = post;
            
            cell.FCCellDate.text = date.timeAgoSinceNow;
            cell.FCCellCategory.text = post.getCategoriesString;
            
            [self downloadImageToUIImageView:cell.FCCellFeaturedImage imageURL:featuredImage.imageSource forIndexPath:indexPath];
            
            
            return cell;
        }
            break;
        case 2: // 1:1
        {
            FCTableViewCell1* cell = [tableView dequeueReusableCellWithIdentifier:@"FCCell" forIndexPath:indexPath];
            cell.FCCellTitle.text = post.postTitle;
            cell.post = post;
            
            
            cell.FCCellDate.text = date.timeAgoSinceNow;
            cell.FCCellCategory.text = post.getCategoriesString;
            
            [self downloadImageToUIImageView:cell.FCCellFeaturedImage imageURL:featuredImage.imageSource forIndexPath:indexPath];
            
            
            
            return cell;
        }
            break;
            
        case 3: // h>>w
        {
            FCTableViewCell4* cell = [tableView dequeueReusableCellWithIdentifier:@"FCCell4" forIndexPath:indexPath];
            cell.FCCellTitle.text = post.postTitle;
            cell.post = post;
            
            cell.FCCellDate.text = date.timeAgoSinceNow;
            cell.FCCellCategory.text = post.getCategoriesString;
            
            [self downloadImageToUIImageView:cell.FCCellFeaturedImage imageURL:featuredImage.imageSource forIndexPath:indexPath];
            
            return cell;
        }
            break;
            
        default:
            return nil;
            break;
    }
}

- (NSInteger)whichCellToUse:(FCFeaturedImage*)featuredImage{
    
    if(!isNetwork){
        
        
        
    }
    
    if(featuredImage.imageWidth < 200) {
        // The image is small. Show only text cell.
        return 0;
    }
    if (featuredImage.imageAspectRatio < 0.7){ // w >> h
        return 1;
    }
    if (featuredImage.imageAspectRatio >= 0.7 && featuredImage.imageAspectRatio <= 1.3) { // 1:1
        return 2;
    }
    return 3; // h>>w
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //TODO
    //return  [[self.fCollectionAPI getLatestsPosts] count];
    return [postsToPresent count];
}


#pragma mark - tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat estHeight = 250;
    
    if([postsToPresent count] <= indexPath.row){
        return estHeight;
    }
    
    FCPost* post = [postsToPresent objectAtIndex:indexPath.row];
    FCFeaturedImage* image = post.postFeaturedImage;
    
    switch ([self whichCellToUse:image]) {
        case 0:
            estHeight = 120;
            break;
        case 1:
            estHeight = 260;
            break;
        case 2:
            estHeight = 360;
            break;
        case 3:
            estHeight = 410;
            break;
            
        default:
            break;
    }
    return estHeight;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(0, 0.25);
    cell.layer.shadowOpacity = 0.2;
    cell.layer.shadowRadius = 0.2;
    
    if(isNetwork){
        if (postsToPresent.count - 3 <= indexPath.row){
            if (postsToPresent.count < totalPosts) {
            NSLog(@"loadnextpage = %lu", 1 + (indexPath.row + 3)/postsPerPage);
            [self loadMorePostsFromPage:1 + (indexPath.row + 3)/postsPerPage];
            }
        }
    
    }
    
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
  
  
  
  if ([cell isKindOfClass:[FCTableViewCell1 class]]){
    FCTableViewCell1* c = (FCTableViewCell1*)cell;
    UIImageView* im = c.FCCellFeaturedImage;
    
    if (im.image == nil){
      NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
      FCPost* post = c.post;
      [[FashionCollectionAPI sharedInstance] cancelDownloadForImageUrl:post.postFeaturedImage.imageSource];
    } else {
      c.FCCellFeaturedImage.image = nil;
    }
    
  }
  
  
  if ([cell isKindOfClass:[FCTableViewCell2 class]]){
    FCTableViewCell2* c = (FCTableViewCell2*)cell;
    UIImageView* im = c.FCCellFeaturedImage;
    
    if (im.image == nil){
      FCPost* post = c.post;
      [[FashionCollectionAPI sharedInstance] cancelDownloadForImageUrl:post.postFeaturedImage.imageSource];
    } else {
      c.FCCellFeaturedImage.image = nil;
    }
  }
  
  
  if ([cell isKindOfClass:[FCTableViewCell4 class]]){
    FCTableViewCell4* c = (FCTableViewCell4*)cell;
    UIImageView* im = c.FCCellFeaturedImage;
    
    if (im.image == nil){
      FCPost* post = c.post;
      [[FashionCollectionAPI sharedInstance] cancelDownloadForImageUrl:post.postFeaturedImage.imageSource];
    } else {
      c.FCCellFeaturedImage.image = nil;
    }
  }
  
  
 
  
  
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString: @"moveToContent1"]){
        
        //Disable Nav scroll
        [[self delegate] setScrollEnabled:self enabled: NO];
        
        
        //Pass post to the contentView
        NewsContentContoller* dvt = (NewsContentContoller*)[segue destinationViewController];
        NSIndexPath* ip = [self.tableView indexPathForSelectedRow];
        dvt.post = ((FCTableViewCell1*)[self.tableView cellForRowAtIndexPath:ip]).post;
        dvt.postImage = ((FCTableViewCell2*)[self.tableView cellForRowAtIndexPath:ip]).FCCellFeaturedImage.image;
        
    }
    
    if([segue.identifier isEqualToString: @"moveToContent2"]){
        
        //Disable Nav scroll
        [[self delegate] setScrollEnabled:self enabled: NO];
        
        
        //Pass post to the contentView
        NewsContentContoller* dvt = (NewsContentContoller*)[segue destinationViewController];
        NSIndexPath* ip = [self.tableView indexPathForSelectedRow];
        dvt.post = ((FCTableViewCell2*)[self.tableView cellForRowAtIndexPath:ip]).post;
        dvt.postImage = ((FCTableViewCell2*)[self.tableView cellForRowAtIndexPath:ip]).FCCellFeaturedImage.image;
        
    }
    
    if([segue.identifier isEqualToString: @"moveToContent3"]){
        
        //Disable Nav scroll
        [[self delegate] setScrollEnabled:self enabled: NO];
        
        
        //Pass post to the contentView
        NewsContentContoller* dvt = (NewsContentContoller*)[segue destinationViewController];
        NSIndexPath* ip = [self.tableView indexPathForSelectedRow];
        dvt.post = ((FCTableViewCell3*)[self.tableView cellForRowAtIndexPath:ip]).post;
        dvt.postImage = nil;
      
    }
    
    if([segue.identifier isEqualToString: @"moveToContent4"]){
        
        //Disable Nav scroll
        [[self delegate] setScrollEnabled:self enabled: NO];
        
        
        //Pass post to the contentView
        NewsContentContoller* dvt = (NewsContentContoller*)[segue destinationViewController];
        NSIndexPath* ip = [self.tableView indexPathForSelectedRow];
        dvt.post = ((FCTableViewCell4*)[self.tableView cellForRowAtIndexPath:ip]).post;
        dvt.postImage = ((FCTableViewCell4*)[self.tableView cellForRowAtIndexPath:ip]).FCCellFeaturedImage.image;
        
    }
}


-(void)downloadImageToUIImageView:(UIImageView*)imageView
                         imageURL:(NSURL*)imageURL
                     forIndexPath:(NSIndexPath*)indexPath{
    
    imageView.alpha = 0.0;
    
    [[FashionCollectionAPI sharedInstance] getImageWithUrl:imageURL success:^(NSURLSessionDataTask *task, UIImage *image) {
        if(image != nil){
        
        imageView.image = image;
        
        [UIView animateWithDuration:0.3 animations:^{
            imageView.alpha = 1.0;
        }];
        } else {
            
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog([error localizedDescription]);
              }];
    
}






- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    [self.navigationController.scrollNavigationBar resetToDefaultPositionWithAnimation:NO];
}



-(void)dealloc{
    @try {
        [[FashionCollectionAPI sharedInstance] removeObserver:self forKeyPath:@"isNetwork"];
    }
    @catch (NSException * __unused exception) {}
}





@end
