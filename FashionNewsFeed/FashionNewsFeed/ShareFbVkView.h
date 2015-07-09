//
//  ShareFbVkView.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 28.06.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShareFbVkView;

@protocol ShareFbVkViewProtocol <NSObject>

@required
-(void)shareFb:(ShareFbVkView*)delegate;
-(void)shareVk:(ShareFbVkView*)delegate;
-(void)goWeb:(ShareFbVkView*)delegate;


@end


@interface ShareFbVkView : UIView

@property (weak,nonatomic) id <ShareFbVkViewProtocol> delegate;
@property (weak, nonatomic) IBOutlet UIView *fbText;
@property (weak, nonatomic) IBOutlet UIView *vkText;
@property (weak, nonatomic) IBOutlet UIView *fcText;
@property (weak, nonatomic) IBOutlet UILabel *fbLabel;
@property (weak, nonatomic) IBOutlet UILabel *vkLabel;
@property (weak, nonatomic) IBOutlet UILabel *webLabel;

@property (assign,nonatomic) BOOL isInformationContoller;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

- (instancetype)initWithFrame:(CGRect)frame
        isInformtionContoller:(BOOL)isInformtionContoller;

@end
