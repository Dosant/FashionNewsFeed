//
//  articleView.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 07.05.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "ArticleView.h"

@implementation ArticleView{
    
    NSLayoutManager *_layoutManager;
    NSString* _htmlString;
    
    NSAttributedString* _content;
    
}

-(instancetype)initWithFrame:(CGRect)frame htmlString:(NSString*)htmlString{
    self = [super initWithFrame:frame];
    if (self){
        
        [self setHtmlStringWithPostContent:htmlString];
        MarkdownParser* parser = [[MarkdownParser alloc] init];
        _content = [parser parseMarkdownHtmlString:_htmlString];
        
    }
    
    return self;
    
}

-(void)buildFrames{
    NSTextStorage *textStorage = [[NSTextStorage alloc] init];
    [textStorage setAttributedString:_content];
    _layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:_layoutManager];
    
    NSTextContainer *textcontainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(self.bounds.size.width, FLT_MAX)];
    [_layoutManager addTextContainer:textcontainer];
    
    UITextView* textView = [[UITextView alloc] initWithFrame:self.bounds textContainer:textcontainer];
    textView.scrollEnabled = true;
    textView.editable = false;
    textView.showsVerticalScrollIndicator = false;
    [self addSubview:textView];
    
    
}

- (void)setHtmlStringWithPostContent:(NSString*)postContent{
    
    NSMutableString *htmlString = [NSMutableString stringWithString: @"<html><head><title></title></head><body>"];
    //continue building the string
    [htmlString appendString: postContent];
    [htmlString appendString:@"</body></html>"];
    
    _htmlString = htmlString;
    
}

@end
