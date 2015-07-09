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
  NSDictionary *_emStrongTextAttributes;
  
  NSDictionary *_headingTextAttributesOne;
  NSDictionary *_headingTextAttributesTwo;
  NSDictionary *_headingTextAttributesThree;
  
  NSMutableAttributedString* _parsedOutput;
  
  NSDictionary *_nextTextAttributes;
  
  NSMutableArray *_imagesQueueToDownload;
  NSArray* _safe_imagesQueueToDownload;
  
  
  
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self createTextAttributes];
    _imagesQueueToDownload = [[NSMutableArray alloc] init];
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
  
  _pTextAttributes = [self attributesWithDescriptor:proxima size:bodyFontSizeValue lineSpacing:3.0];
  
  _headingTextAttributesOne = [self attributesWithDescriptor:playfareBold
                                                        size:bodyFontSizeValue * 1.3f
                                                 lineSpacing:2.0];
  _headingTextAttributesTwo = [self attributesWithDescriptor:playfareBold
                                                        size:bodyFontSizeValue * 1.2f
                                                 lineSpacing:2.0];
  _headingTextAttributesThree = [self attributesWithDescriptor:playfareBold
                                                          size:bodyFontSizeValue * 1.15f
                                                   lineSpacing:3.0];
  
  _strongTextAttributes = [self attributesWithDescriptor:proximaBold
                                                    size:bodyFontSizeValue
                                             lineSpacing:3.0];
  _emTextAttributes = [self attributesWithDescriptor:proximaItalic
                                                size:bodyFontSizeValue
                                         lineSpacing:3.0];
  _emStrongTextAttributes = [self attributesWithDescriptor:proximaItalic
                                                      size:bodyFontSizeValue
                                               lineSpacing:3.0];
  
}

- (NSDictionary *)attributesWithDescriptor: (UIFontDescriptor*)descriptor size:(CGFloat)size lineSpacing:(CGFloat)lineSpacing {
  
  UIFont *font = [UIFont fontWithDescriptor:descriptor size:size];
  
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.paragraphSpacing = 10.0;
  paragraphStyle.lineSpacing = lineSpacing;
  
  
  
  return @{NSFontAttributeName: font,
           NSParagraphStyleAttributeName:paragraphStyle};
}

-(NSDictionary * )attributesForImage{
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.paragraphSpacing = 10.0;
  paragraphStyle.alignment = NSTextAlignmentCenter;
  return @{NSParagraphStyleAttributeName:paragraphStyle};
}


-(NSMutableAttributedString*) parseMarkdownHtmlString:(NSString*)htmlString{
  _parsedOutput = [[NSMutableAttributedString alloc] init];
  
  
  HTMLDocument* doc = [[HTMLDocument alloc] initWithString:htmlString];
  HTMLElement* html = doc.rootElement;
  HTMLNode* body = [html childAtIndex:1];
  
  
  _nextTextAttributes = _pTextAttributes;
  [self recursiveFormat:body];
  
  _safe_imagesQueueToDownload = [NSArray arrayWithArray:_imagesQueueToDownload];
  
  
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
      _nextTextAttributes = _emTextAttributes;
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
      
      NSURL*  imgUrl = [NSURL URLWithString: [el.attributes[@"src"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
      
      CGSize placeholderSize = [self sizeFromElement:el];
      UIImage* placeholderImage = [self generatePlaceholderImage:placeholderSize];
      
      NSTextAttachment *textAttachment = [NSTextAttachment new];
      textAttachment.image = placeholderImage;
      
      
      [_parsedOutput appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
      [_parsedOutput appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
      
      [_parsedOutput appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
      
      NSUInteger index = [_parsedOutput length] - 2;
      [_parsedOutput addAttributes:[self attributesForImage] range:NSMakeRange(index, 1)];
      
      NSURL* imageURL = [NSURL URLWithString: [el.attributes[@"src"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
      
      MarkdownImage* imageToDownload = [[MarkdownImage alloc] initWithImageUrl:imageURL placeholderSize:placeholderSize index:index];
      
      [_imagesQueueToDownload addObject:imageToDownload];
      
      return;
    }
    
    if([[el tagName] isEqualToString:@"a"]){
      
      
      NSOrderedSet* children = el.children;
      
      BOOL isImage = false;
      
      for(HTMLElement* node in children){
        if ([node respondsToSelector:@selector(tagName)]) {
          if([node.tagName isEqualToString:@"img"]){
            isImage = true;
            break;
          }
        }
        
      }
      if(!isImage){
        NSURL*  url = [NSURL URLWithString: [el.attributes[@"href"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSString* string = el.textContent;
        
        NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:string];
        [str addAttribute: NSLinkAttributeName value: url range: NSMakeRange(0, str.length)];
        [str addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, str.length)];
        [_parsedOutput appendAttributedString:str];
        
        
        return;
        
        
      }
      
    }
    
    
    
    for(HTMLNode* n in [el children]){
      [self recursiveFormat:n];
    }
    
    if([[el tagName] isEqualToString:@"p"] || [[[el tagName] substringToIndex:1] isEqualToString:@"h"] ||
       [[el tagName] isEqualToString:@"address"]){
      [_parsedOutput appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    
  }
}

-(void)downloadImagesToAttribtutedString{
  
  
  for (MarkdownImage* imageMarkdown in _safe_imagesQueueToDownload) {
    
    [[FashionCollectionAPI sharedInstance] getImageWithUrl:imageMarkdown.url success:^(NSURLSessionDataTask *task, UIImage *image) {
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
      if(image == nil){
        NSRange range = NSMakeRange(imageMarkdown.index,1);
        dispatch_sync(dispatch_get_main_queue(), ^{
        [self.delegate markdownParserImageDownloaded:self withTextAttachemnt:nil WithRange:range];
          });
        return;
      }
      
      
      
      UIImage* resizedImage = [self resizeImage:image size:imageMarkdown.size];
      NSRange range = NSMakeRange(imageMarkdown.index, 1);
      NSTextAttachment *textAttachment = [NSTextAttachment new];
      
      textAttachment.image = resizedImage;
      NSLog(@"placeholder: %f %f image: %f %f", imageMarkdown.size.height,imageMarkdown.size.width,resizedImage.size.height, resizedImage.size.width);
      
      
      dispatch_sync(dispatch_get_main_queue(), ^{
        
        //[_parsedOutput replaceCharactersInRange:NSMakeRange(imageMarkdown.index, 1) withAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
        [self.delegate markdownParserImageDownloaded:self withTextAttachemnt:textAttachment WithRange:range];
      
      });
      
      });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      NSLog([error localizedDescription]);
    }];
    
  }
  
  
  
  
}

-(UIImage*)resizeImage:(UIImage*)imageToResize size:(CGSize)newSize{
  CGFloat height = imageToResize.size.height;
  CGFloat width = imageToResize.size.width;
  
  if( width <= self.textContainerWidth ){ // to small to resize
    return imageToResize;
  }
  
  UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0);
  [imageToResize drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
  UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
  
  UIGraphicsEndImageContext();
  return [UIImage imageWithData: UIImagePNGRepresentation(newImage)];
  
}

-(CGSize)newSize:(CGFloat)width height:(CGFloat)height{
  if( width <= self.textContainerWidth ){ // to small to resize
    return CGSizeMake(width, height);
  }
  
  CGFloat newWidth = self.textContainerWidth;
  CGFloat ar = width/height;
  CGFloat newHeight = newWidth/ar;
  
  return CGSizeMake(newWidth, newHeight);
  
}

-(CGSize)sizeFromElement:(HTMLElement*)el{
  NSString* widthString = el.attributes[@"width"];
  NSString* heightString = el.attributes[@"height"];
  
  if(widthString == nil || heightString == nil){
    return CGSizeZero;
  }
  
  CGFloat width = [widthString floatValue];
  CGFloat height = [heightString floatValue];
  
  return [self newSize:width height:height];
}

-(UIImage*)generatePlaceholderImage:(CGSize)size{
  UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
  
  UIBezierPath* path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
  [[UIColor colorWithWhite:0.9 alpha:1.0] setFill];
  [path fill];
  
  UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

-(NSDictionary*)getHeadingTextAttributesOne{
  return _headingTextAttributesOne;
}


@end
