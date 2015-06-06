//
//  InformationViewController.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 30.05.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)closeInfo:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden{
    return true;
}
- (IBAction)fb:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/FashionCollectionBY"]];
    
}
- (IBAction)vk:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vk.com/fashioncollectionbelarus"]];
    
    
    
}
- (IBAction)fc:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.fcollection.by"]];
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
