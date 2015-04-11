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


@interface PageContentViewController ()

@property (strong, nonatomic) FashionCollectionAPI *fCollectionAPI;

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.rowHeight = 100;

    self.title = _pageTitle;
    self.fCollectionAPI = [FashionCollectionAPI sharedInstance];
  
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[self delegate] setScrollEnabled:self enabled:YES];
    
}

#pragma mark - tableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FCTableViewCell* cell = (FCTableViewCell * )[tableView dequeueReusableCellWithIdentifier: @"tableViewCell"];
        
    switch (self.pageIndex) {
            
        case 0:
            
            [cell setPostTitle: [[[self.fCollectionAPI getLatestsPosts] objectAtIndex: indexPath.row] postTitle]
                    postAuthor:[[[self.fCollectionAPI getLatestsPosts] objectAtIndex: indexPath.row] postAuthor]
                      postDate:[[[self.fCollectionAPI getLatestsPosts] objectAtIndex: indexPath.row] postDate]
              postDateModified:[[[self.fCollectionAPI getLatestsPosts] objectAtIndex: indexPath.row] postDateModified]
                   postExcerpt:[[[self.fCollectionAPI getLatestsPosts] objectAtIndex: indexPath.row] postExcerpt]
                      postMeta:[[[self.fCollectionAPI getLatestsPosts] objectAtIndex: indexPath.row] postMeta]
             postFeaturedImage:[[[self.fCollectionAPI getLatestsPosts] objectAtIndex: indexPath.row] postFeaturedImage]
                     postTerms:[[[self.fCollectionAPI getLatestsPosts] objectAtIndex: indexPath.row] postTerms] ];
                        
            break;
            
        case 1:
            cell.textLabel.text = [[[self.fCollectionAPI getCategories] objectAtIndex: 1] categoryName];
            break;
        case 2:
            cell.textLabel.text = [[[self.fCollectionAPI getCategories] objectAtIndex: 2] categoryName];
            break;
        case 3:
            cell.textLabel.text = [[[self.fCollectionAPI getCategories] objectAtIndex: 3] categoryName];
            break;
            
    }
    
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  [[self.fCollectionAPI getLatestsPosts] count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString: @"showNewsContent"]){
        
        [[self delegate] setScrollEnabled:self enabled: NO];
        
    }
}

@end
