//
//  NewsContentContoller.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 31.03.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "NewsContentContoller.h"

@interface NewsContentContoller ()
@property (weak, nonatomic) IBOutlet UIWebView *contentView;
@property (strong,nonatomic) NSString* contentString;

@end

@implementation NewsContentContoller



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",_post.postContent);
    
    
    NSMutableString *html = [NSMutableString stringWithString: @"<html><head><title></title></head><body\">"];
    
    //continue building the string
    [html appendString:[self resizeImages:_post.postContent]];
    [html appendString:@"</body></html>"];
    
   
    
    [self.contentView loadHTMLString:html baseURL:nil];
    
    
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)resizeImages:(NSString*)htmlString{
    
    NSString* out = [htmlString stringByReplacingOccurrencesOfString:@"400" withString:@"300"];
    out = [out stringByReplacingOccurrencesOfString:@"600" withString:@"450"];
    out = [out stringByReplacingOccurrencesOfString:@"601" withString:@"450"];
    NSLog(out);
    
    return out;
    
    
    
    
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
