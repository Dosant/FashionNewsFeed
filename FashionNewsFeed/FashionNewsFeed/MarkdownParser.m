//
//  MarkdownParser.m
//  FashionNewsFeed
//
//  Created by Anton Dosov on 07.05.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "MarkdownParser.h"

@implementation MarkdownParser{
    NSDictionary *_pTextAttributes;
    NSDictionary *_strongTextAttributes;
    NSDictionary *_headingTextAttributes;
    
    NSMutableAttributedString* _parsedOutput;
    
    NSDictionary *_nextTextAttributes;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createTextAttributes];
    }
    return self;
}

-(void)createTextAttributes{
    
        // 1. Create the font descriptors
        UIFontDescriptor *baskerville = [UIFontDescriptor
                                         fontDescriptorWithFontAttributes: @{UIFontDescriptorFamilyAttribute: @"Baskerville"}];
        UIFontDescriptor *baskervilleBold = [baskerville fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    
    
        // 2. determine the current text size preference
        UIFontDescriptor *bodyFont = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
        NSNumber *bodyFontSize = bodyFont.fontAttributes[UIFontDescriptorSizeAttribute];
        CGFloat bodyFontSizeValue = [bodyFontSize floatValue];
    
    
        // 3. create the attributes for the various styles
    
        _pTextAttributes = [self attributesWithDescriptor:baskerville size:bodyFontSizeValue];
        _headingTextAttributes = [self attributesWithDescriptor:baskervilleBold
                                                          size:bodyFontSizeValue * 2.0f];
        _strongTextAttributes = [self attributesWithDescriptor:baskervilleBold
                                                          size:bodyFontSizeValue];
    
}

- (NSDictionary *)attributesWithDescriptor: (UIFontDescriptor*)descriptor size:(CGFloat)size {
    
    UIFont *font = [UIFont fontWithDescriptor:descriptor size:size];
    return @{NSFontAttributeName: font};
}


-(NSAttributedString*) parseMarkdownHtmlString:(NSString*)htmlString{
    _parsedOutput = [[NSMutableAttributedString alloc] init];
    
    
    HTMLDocument* doc = [[HTMLDocument alloc] initWithString:htmlString];
    HTMLElement* html = doc.rootElement;
    HTMLNode* body = [html childAtIndex:1];
    
    
    _nextTextAttributes = _pTextAttributes;
    [self recursiveFormat:body];
    
    return _parsedOutput;
    
}

-(void)recursiveFormat:(HTMLNode*)node{
    if([node isKindOfClass:[HTMLTextNode class]]){
        
        NSString* lastTag = node.parentElement.tagName;
        
        if([lastTag isEqualToString:@"p"]){
            _nextTextAttributes = _pTextAttributes;
        }
        
        if([lastTag isEqualToString:@"h3"]){
            _nextTextAttributes = _headingTextAttributes;
        }
        
        if([lastTag isEqualToString:@"strong"]){
            _nextTextAttributes = _strongTextAttributes;
        }
        
        
        
        NSAttributedString* append = [[NSAttributedString alloc] initWithString:node.textContent attributes:_nextTextAttributes];
        [_parsedOutput appendAttributedString:append];
        
        
        
        return;
        
    }
    
    if([node isKindOfClass:[HTMLElement class]]){
        
        HTMLElement* el = (HTMLElement*)node;
        if([[el tagName] isEqualToString:@"img"]){
            [_parsedOutput appendAttributedString:[[NSAttributedString alloc] initWithString:@"img\n\n"]];
            return;
        }
        
        
        
        for(HTMLNode* n in [el children]){
            [self recursiveFormat:n];
        }
        
        if([[el tagName] isEqualToString:@"p"]){
            [_parsedOutput appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        }
        
    }
}


@end
