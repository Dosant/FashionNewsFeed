//
//  ShareFbVkView.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 28.06.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "ShareFbVkView.h"




@implementation ShareFbVkView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"ShareFbVkView" owner:self options:nil];
    id mainView = [subviewArray objectAtIndex:0];
    self.isInformationContoller = false;
    
    return mainView;
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
        isInformtionContoller:(BOOL)isInformtionContoller
{
  self = [super initWithFrame:frame];
  if (self) {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"ShareFbVkView" owner:self options:nil];
    id mainView = [subviewArray objectAtIndex:0];
    self.isInformationContoller = isInformtionContoller;
    
    return mainView;
  }
  return self;
}

-(void)layoutSubviews{
  if (self.isInformationContoller) {
    self.fbLabel.text = @"Группа в Facebook";
    self.vkLabel.text = @"Группа в ВКонтакте";
    self.webLabel.text = @"Наш Сайт";
    [self.separatorLine removeFromSuperview];
  }
  [super layoutSubviews];
}


- (IBAction)vkAction:(id)sender {
  [self.delegate shareVk:self];
}

- (IBAction)fbAction:(id)sender {
  [self.delegate shareFb:self];
}
- (IBAction)webAction:(id)sender {
  [self.delegate goWeb:self];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  
  [super touchesBegan:touches withEvent:event];
  
  UITouch* touch = [touches anyObject];
  
  if (touch.view == self.vkText) {
    [self vkAction:nil];
    return;
  }
  
  if (touch.view == self.fbText) {
    [self fbAction:nil];
    return;
  }
  
  if (touch.view == self.fcText) {
    [self webAction:nil];
    return;
  }
  
}

@end
