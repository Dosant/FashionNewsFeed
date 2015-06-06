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

@interface ArticleView : UIView <MarkdownParserDelegate>

@property (nonatomic,strong) UITextView* textView;

-(instancetype)initWithFrame:(CGRect)frame htmlString:(NSString*)htmlString postTitle:(NSString*)postTitle;

- (void)buildFrames;
- (void)setHtmlStringWithPostContent:(NSString*)postContent;



@end
