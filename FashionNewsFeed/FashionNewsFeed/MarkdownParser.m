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
    NSDictionary *_emTextAttributes;
    
    NSDictionary *_headingTextAttributesOne;
    NSDictionary *_headingTextAttributesTwo;
    NSDictionary *_headingTextAttributesThree;
    
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
    UIFontDescriptor *proxima = [UIFontDescriptor
                                     fontDescriptorWithFontAttributes: @{UIFontDescriptorFamilyAttribute: @"Proxima Nova"}];
    UIFontDescriptor *proximaBold = [proxima fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    UIFontDescriptor *proximaItalic = [proxima fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic];


    // 2. determine the current text size preference
    UIFontDescriptor *playfare = [UIFontDescriptor
                              fontDescriptorWithFontAttributes: @{UIFontDescriptorFamilyAttribute: @"Playfair Display"}];
    UIFontDescriptor *playfareBold = [playfare fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    
    NSNumber *bodyFontSize = @16;
    CGFloat bodyFontSizeValue = [bodyFontSize floatValue];


    // 3. create the attributes for the various styles

    _pTextAttributes = [self attributesWithDescriptor:proxima size:bodyFontSizeValue];
    
    _headingTextAttributesOne = [self attributesWithDescriptor:playfareBold
                                                      size:bodyFontSizeValue * 1.6f];
    _headingTextAttributesTwo = [self attributesWithDescriptor:playfareBold
                                                          size:bodyFontSizeValue * 1.4f];
    _headingTextAttributesThree = [self attributesWithDescriptor:playfareBold
                                                          size:bodyFontSizeValue * 1.2f];
    
    _strongTextAttributes = [self attributesWithDescriptor:proximaBold
                                                      size:bodyFontSizeValue];
    _emTextAttributes = [self attributesWithDescriptor:proximaItalic
                                                  size:bodyFontSizeValue];
    
}

- (NSDictionary *)attributesWithDescriptor: (UIFontDescriptor*)descriptor size:(CGFloat)size {
    
    UIFont *font = [UIFont fontWithDescriptor:descriptor size:size];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.paragraphSpacing = 10.0;
    
    return @{NSFontAttributeName: font,
             NSParagraphStyleAttributeName:paragraphStyle};
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
        
        else if([lastTag isEqualToString:@"a"]){
            _nextTextAttributes = _emTextAttributes;
        }
        
        else if([lastTag isEqualToString:@"h3"]){
            _nextTextAttributes = _headingTextAttributesThree;
        }
        
        else if([lastTag isEqualToString:@"h2"]){
            _nextTextAttributes = _headingTextAttributesTwo;
        }
        
        else if([lastTag isEqualToString:@"h1"]){
            _nextTextAttributes = _headingTextAttributesOne;
        }
        
        else if([lastTag isEqualToString:@"strong"]){
            _nextTextAttributes = _strongTextAttributes;
        }
        else if([lastTag isEqualToString:@"em"]){
            _nextTextAttributes = _strongTextAttributes;
        }
        
        else { // not recognize selector
            return;
        }
        
        
        
        NSAttributedString* append = [[NSAttributedString alloc] initWithString:node.textContent attributes:_nextTextAttributes];
        
        [_parsedOutput appendAttributedString:append];
        
        
        
        //NSLog([_parsedOutput string]);
        
        return;
        
    }
    
    if([node isKindOfClass:[HTMLElement class]]){
        
        HTMLElement* el = (HTMLElement*)node;
        
        if([[el tagName] isEqualToString:@"style"] ||
           [[el tagName] isEqualToString:@"iframe"] ){ // don't show
            
            return;
            
        }
        
        
        if([[el tagName] isEqualToString:@"img"]){
            
            NSData* imgData = [NSData dataWithContentsOfURL:
                               [NSURL URLWithString: [el.attributes[@"src"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
            
            
            UIImage* image = [UIImage imageWithData:imgData];
            UIImage* scimage = [UIImage imageWithCGImage:image.CGImage scale:2.0 orientation:UIImageOrientationUp];
            NSLog(@"%f, %f",image.size.height,image.size.width);
            
            NSTextAttachment *textAttachment = [NSTextAttachment new];
            
            textAttachment.image = scimage;
            
            
            [_parsedOutput appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
            [_parsedOutput appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
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
