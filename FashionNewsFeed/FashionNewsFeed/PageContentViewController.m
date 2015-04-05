//
//  PageContentViewConroller.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 27.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "PageContentViewController.h"





@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _pageTitle;
  
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[self delegate] setScrollEnabled:self enabled:YES];
    
}



#pragma mark - tableViewDataSource
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = (UITableViewCell * )[tableView dequeueReusableCellWithIdentifier: @"newsCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"Hey, %ld", indexPath.row];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}


#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString: @"showNewsContent"]){
        
        [[self delegate] setScrollEnabled:self enabled: NO];
        
    }
    
    
}





@end
