//
//  InformationViewController.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 30.05.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.shareView.isInformationContoller = true;
  self.tableView.contentInset = UIEdgeInsetsMake(450, 0, 30, 0);
}



-(void)addTableViewUnder:(UITableView *)tableView{
  
  [self.view insertSubview:tableView belowSubview:self.navBar];
}

-(CGRect)frameForShareView:(CGSize)size{
  
  return CGRectMake(0, size.height, size.width, 152);
  
  
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

-(void)shareFb:(ShareFbVkView *)delegate{
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/FashionCollectionBY"]];
}

-(void)shareVk:(ShareFbVkView *)delegate{
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vk.com/fashioncollectionbelarus"]];
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
