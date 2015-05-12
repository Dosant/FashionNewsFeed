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
    UITextView* _textView;
    NSTextStorage* _textStorage;
    
    MarkdownParser* _parser;
    
    
    NSString* _htmlString;
    NSMutableAttributedString* _content;
    
    CGFloat contentWidth;
    
}

-(instancetype)initWithFrame:(CGRect)frame htmlString:(NSString*)htmlString{
    self = [super initWithFrame:frame];
    if (self){
        
        contentWidth = self.bounds.size.width - 5;
        
        [self setHtmlStringWithPostContent:htmlString];
        
        _parser = [[MarkdownParser alloc] init];
        
        _parser.textContainerWidth = contentWidth;
        _parser.delegate = self;
        
        NSLog(@"ContentInit");
        _content = [_parser parseMarkdownHtmlString:_htmlString];
        
    }
    
    return self;
    
}

-(void)buildFrames{
     _textStorage = [[NSTextStorage alloc] init];
    [_textStorage setAttributedString:_content];
    _layoutManager = [[NSLayoutManager alloc] init];
    
    [_textStorage addLayoutManager:_layoutManager];
    
    NSTextContainer *textcontainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(contentWidth, FLT_MAX)];
    [_layoutManager addTextContainer:textcontainer];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, contentWidth, self.bounds.size.height) textContainer:textcontainer];
    _textView.scrollEnabled = true;
    _textView.editable = false;
    _textView.showsVerticalScrollIndicator = false;
    [self addSubview:_textView];
    
    [_parser downloadImagesToAttribtutedString];
    
}

- (void)setHtmlStringWithPostContent:(NSString*)postContent{
    
    NSMutableString *htmlString = [NSMutableString stringWithString: @"<html><head><title></title></head><body>"];
    //continue building the string
    [htmlString appendString: postContent];
    [htmlString appendString:@"</body></html>"];
    
    _htmlString = htmlString;
    
}

#pragma mark -MarkdownParserDelegate

- (void)markdownParserImageDownloaded:(MarkdownParser *)parser withTextAttachemnt:(NSTextAttachment*)textAttachment
                            WithRange:(NSRange)range{
    
    [_textStorage replaceCharactersInRange:range withAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
    
}

@end
