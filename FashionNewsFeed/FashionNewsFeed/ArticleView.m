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
    FCPost* _post;
    
    
    NSString* _htmlString;
    NSMutableAttributedString* _content;
    
    CGFloat contentWidth;
    
}

-(instancetype)initWithFrame:(CGRect)frame htmlString:(NSString*)htmlString postTitle:(NSString*)postTitle{
    self = [super initWithFrame:frame];
    if (self){
        
        contentWidth = self.bounds.size.width - 8;
        
        
        [self setHtmlStringWithPostContent:htmlString postTitle:postTitle];
        
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
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(2, 0, contentWidth, self.bounds.size.height) textContainer:textcontainer];
    _textView.scrollEnabled = true;
    _textView.editable = false;
    _textView.showsVerticalScrollIndicator = false;
    
    [self addSubview:_textView];
    
    [_parser downloadImagesToAttribtutedString];
    
}

- (void)setHtmlStringWithPostContent:(NSString*)postContent postTitle:(NSString*)postTitle{
    
    NSMutableString *htmlString = [NSMutableString stringWithString: @"<html><head><title></title></head><body>"];
    //continue building the string
    [htmlString appendString:@"<h1>"];
    [htmlString appendString:postTitle];
    [htmlString appendString:@"</h1>"];
    [htmlString appendString: postContent];
    [htmlString appendString:@"</body></html>"];
    
    _htmlString = htmlString;
    
}

#pragma mark -MarkdownParserDelegate

- (void)markdownParserImageDownloaded:(MarkdownParser *)parser withTextAttachemnt:(NSTextAttachment*)textAttachment
                            WithRange:(NSRange)range{
    if(textAttachment == nil){
        [_textStorage replaceCharactersInRange:range withString:@" "];
        return;
    }
    
    
    [_textStorage replaceCharactersInRange:range withAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
    
    
}



@end
