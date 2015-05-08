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
#import "VKSdk.h"


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
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareContent:)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    NSMutableString *htmlString = [NSMutableString stringWithString: @"<html><head><title></title></head><body>"];
    
    //continue building the string
    [htmlString appendString: _post.postContent];
    [htmlString appendString:@"</body></html>"];
    
    HTMLDocument* doc = [[HTMLDocument alloc] initWithString:htmlString];
    HTMLElement* html = doc.rootElement;
    HTMLNode* body = [html childAtIndex:1];
    
    NSArray* nodes = [body childElementNodes];
//    NSLog([nodes description]);
//    
//    for(HTMLNode* node in nodes){
//        NSLog([node recursiveDescription]);
//    }
    
//    NSEnumerator* en = [html treeEnumerator];
//    
//    HTMLNode* node;
//    while ((node = en.nextObject)) {
//        NSLog([node description]);
//    }
    
    [self recursiveFormat:body];
    
    
    
    
    // Do any additional setup after loading the view.
    
    
    _articleView = [[ArticleView alloc] initWithFrame:CGRectMake(0,50,self.view.frame.size.width,self.view.frame.size.height - 50) htmlString:_post.postContent];
    _articleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    
    [self.view addSubview:_articleView];
    
    
}

-(void)shareContent:(id)sender {
    NSURL* sharedURL = _post.postLink;
    NSArray* items = @[sharedURL];
    
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:@[[VKActivity new]]];
    
    if (VK_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") && UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom])
    {
        UIPopoverPresentationController *popover = activity.popoverPresentationController;
        popover.sourceView = self.view;
        popover.barButtonItem = self.navigationItem.rightBarButtonItem;
    }
    
    [self presentViewController:activity animated:YES completion:nil];
    
}

-(void)viewDidLayoutSubviews{
    [_articleView buildFrames];
}

-(void)recursiveFormat:(HTMLNode*)node{
    if([node isKindOfClass:[HTMLNode class]]){
        
        NSLog(@"textNode: %@",[node textContent]);
        return;
        
    }
    
    if([node isKindOfClass:[HTMLElement class]]){
        
        HTMLElement* el = (HTMLElement*)node;
        NSLog([el tagName]);
        
        if([[el tagName] isEqualToString:@"img"]){
           
            [el tagName];
           
            
        }
        
        for(HTMLNode* n in [el children]){
            
            [self recursiveFormat:n];
            
        }
        
        
        
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)resizeImages:(NSString*)htmlString{
    
//    NSString* out = [htmlString stringByReplacingOccurrencesOfString:@"400" withString:@"300"];
//    out = [out stringByReplacingOccurrencesOfString:@"600" withString:@"450"];
//    out = [out stringByReplacingOccurrencesOfString:@"601" withString:@"450"];
//    NSLog(out);
    
    return htmlString;
    
    
    
    
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
