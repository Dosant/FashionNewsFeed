//
//  ForteInfoViewContollerViewController.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 02.06.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "ForteInfoViewContollerViewController.h"

@interface ForteInfoViewContollerViewController ()

@end

@implementation ForteInfoViewContollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* view = nil;
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"ForteInfo"
                                                     owner:self
                                                   options:nil];
    view = [objects firstObject];
    [self.containerView addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

-(BOOL)prefersStatusBarHidden{
    return true;
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
