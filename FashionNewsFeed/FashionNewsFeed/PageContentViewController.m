//
//  PageContentViewConroller.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "PageContentViewController.h"
#import "FashionCollectionAPI.h"
#import "FCTableViewCell.h"
#import "NewsContentContoller.h"

#import "FCAttachmentMeta.h"

#import <AFNetworking/UIKit+AFNetworking.h>




@interface PageContentViewController ()



@end

@implementation PageContentViewController{
    
    NSMutableArray* postsToPresent;
    
    
    UIActivityIndicatorView *activityView;
    BOOL postsLoaded;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _pageTitle;
    postsLoaded = NO;
    
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

    
    
    
    [self loadMorePostsFromPage:1];
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[self delegate] setScrollEnabled:self enabled:YES];
    
}

-(void)reloadPosts{
    
    [postsToPresent removeAllObjects];
    [self loadMorePostsFromPage:1];
    
}


-(void)loadMorePostsFromPage:(NSUInteger)page{
    
     void (^success)(NSURLSessionDataTask *task, NSMutableArray *posts) = ^(NSURLSessionDataTask *task, NSMutableArray *posts) {
    
        
        NSLog(@"%d",[posts count]);
        if (postsToPresent != nil){
            [postsToPresent addObjectsFromArray:posts];
        } else {
            
            postsToPresent = [NSMutableArray arrayWithArray:posts];
            
            
        }
        if (!postsLoaded){
            postsLoaded = YES;
            [activityView stopAnimating];
            [activityView removeFromSuperview];
        }
        
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
        
    
    
    };
    
    
     void (^failure)(NSURLSessionDataTask *task, NSError* error) = ^(NSURLSessionDataTask *task,  NSError *error) {

        NSLog(@"%@",[error localizedDescription]);
        
    };
    
    __weak void (^successWeak)(NSURLSessionDataTask *task, NSMutableArray *posts) = success;
    __weak void (^failureWeak)(NSURLSessionDataTask *task, NSError *error) = failure;
    
    switch (_pageIndex) {
        case 0:
            
            [[FashionCollectionAPI sharedInstance] getNewsPosts:page postsPerPage:12 success:successWeak failure:failureWeak];
            break;
        case 1:
            
            [[FashionCollectionAPI sharedInstance] getFashionPosts:page postsPerPage:12 success:successWeak failure:failureWeak];
            break;
        case 2:
            
            [[FashionCollectionAPI sharedInstance] getEventsPosts:page postsPerPage:12 success:successWeak failure:failureWeak];
            break;
        case 3:
            
            [[FashionCollectionAPI sharedInstance] getBeautyBoxPosts:page postsPerPage:12 success:successWeak failure:failureWeak];
            break;
            
            
            
        default:
            
            NSLog(@"Wrong pageIndex lol?");
            break;
    }
    
    
}




#pragma mark - tableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    FCTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FCCell" forIndexPath:indexPath];

    //TODO
    FCPost* post = (FCPost*)[postsToPresent objectAtIndex:indexPath.row];
    
    
    
    cell.FCCellTitle.text = post.postTitle;
    cell.post = post;
    
    FCAttachmentMeta* meta =  [self getTheLargestPicture:post.postFeaturedImage.imageAttachmentMeta];
    cell.FCCellFeaturedImage.image = nil;
    [cell.FCCellFeaturedImage setImageWithURL:meta.attachmentMetaUrl];
    
    
    
   // cell.FCCellFeaturedImage.image = post.postFeaturedImage;
    cell.FCCellCategoryAndDate.text = @"вчера";
    
    
    
    
    
    
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //TODO
    //return  [[self.fCollectionAPI getLatestsPosts] count];
    return [postsToPresent count];
}


#pragma mark - tableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([postsToPresent count] - 1 <= indexPath.row){
        
        NSLog(@"%d",(indexPath.row + 1)/12);
        [self loadMorePostsFromPage:1 + (indexPath.row + 1)/12];
        
        
    }
    
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.imageView.image = nil;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString: @"moveToContent"]){
        
        //Disable Nav scroll
        [[self delegate] setScrollEnabled:self enabled: NO];
        
        
        //Pass post to the contentView
        NewsContentContoller* dvt = (NewsContentContoller*)[segue destinationViewController];
        NSIndexPath* ip = [self.tableView indexPathForSelectedRow];
        dvt.post = ((FCTableViewCell*)[self.tableView cellForRowAtIndexPath:ip]).post;
        
    }
}


#pragma mark - preparingContent

-(FCAttachmentMeta*)getTheLargestPicture:(NSArray*)attachmentsArray{
    
    NSUInteger maxWidth = 0;
    FCAttachmentMeta* _meta;
    
    for(FCAttachmentMeta* meta in attachmentsArray){
        NSLog(@"%d",meta.attachmentMetaWidth);
        
        if (maxWidth < meta.attachmentMetaWidth){
            maxWidth = meta.attachmentMetaWidth;
            _meta = meta;
        }
        
        
    }
    NSLog(@"%d", maxWidth);
    return _meta;
    
}


@end
