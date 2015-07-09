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

#import "ShareFbVkView.h"
#import "ArticleView.h"


@interface NewsContentContoller : UIViewController <UITableViewDataSource, UITableViewDelegate, ShareFbVkViewProtocol,ArticleViewDelegate>
@property (strong,nonatomic) FCPost* post;
@property (strong,nonatomic) UIImage* postImage;
@property (strong,nonatomic) UITableView* tableView;
@property (strong,nonatomic) ShareFbVkView* shareView;

-(void)addTableViewUnder:(UITableView*)tableView;
-(CGRect)frameForShareView:(CGSize)size;
-(ShareFbVkView*)configureShareView:(CGRect)frame;


-(void)shareVk:(ShareFbVkView *)delegate;
  
-(void)shareFb:(ShareFbVkView *)delegate;
    
-(void)goWeb:(ShareFbVkView *)delegate;

@end
