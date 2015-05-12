//
//  NewsContentContoller.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 31.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "NewsContentContoller.h"

#import "ArticleView.h"
#import <HTMLReader/HTMLReader.h>



@interface NewsContentContoller ()
@property (weak, nonatomic) IBOutlet UIWebView *contentView;
@property (strong,nonatomic) NSString* contentString;

@end

@implementation NewsContentContoller{
    ArticleView* _articleView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",_post.postContent);
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
    
    
    _articleView = [[ArticleView alloc] initWithFrame:CGRectMake(0,50,self.view.frame.size.width,self.view.frame.size.height - 50) htmlString:_post.postContent];
    _articleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    
    [self.view addSubview:_articleView];
    
    
}

-(void)viewDidLayoutSubviews{
    [_articleView buildFrames];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[FashionCollectionAPI sharedInstance] cancelAllOperations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
