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


@interface PageContentViewController ()

@property (weak, nonatomic) FashionCollectionAPI *fCollectionAPI;

@end

@implementation PageContentViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.title = _pageTitle;
    self.fCollectionAPI = [FashionCollectionAPI sharedInstance];
   
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[self delegate] setScrollEnabled:self enabled:YES];
    
}

#pragma mark - tableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    FCTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FCCell"];

    FCPost* post = (FCPost*)[[self.fCollectionAPI getLatestsPosts] objectAtIndex:indexPath.row];
    
    
    cell.post = post;
    
    cell.FCCellTitle.text = post.postTitle;
   // cell.FCCellFeaturedImage.image = post.postFeaturedImage;
    cell.FCCellCategoryAndDate.text = @"вчера";
    
    
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  [[self.fCollectionAPI getLatestsPosts] count];
}


#pragma mark - tableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString: @"showNewsContent"]){

        
        [[self delegate] setScrollEnabled:self enabled: NO];
        
    }
    
    if([segue.identifier isEqualToString: @"moveToContent"]){
        
        //Pass post to the contentView
        
        NewsContentContoller* dvt = (NewsContentContoller*)[segue destinationViewController];
        NSIndexPath* ip = [self.tableView indexPathForSelectedRow];
        dvt.post = ((FCTableViewCell*)[self.tableView cellForRowAtIndexPath:ip]).post;
        
    }
}


@end
