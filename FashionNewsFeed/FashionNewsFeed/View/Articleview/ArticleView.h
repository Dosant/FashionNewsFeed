//
//  articleView.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 07.05.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HTMLReader/HTMLReader.h>
#import "MarkdownParser.h"
@class ArticleView;

@protocol ArticleViewDelegate <NSObject>

-(void)relayoutView:(ArticleView*)delegate;

@end

@interface ArticleView : UIView <MarkdownParserDelegate>

@property (nonatomic,strong) UITextView* textView;

@property (weak,nonatomic) id <ArticleViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame htmlString:(NSString*)htmlString postTitle:(NSString*)postTitle;

- (void)buildFrames;
- (void)setHtmlStringWithPostContent:(NSString*)postContent;
- (void)downloadImages;


@end
