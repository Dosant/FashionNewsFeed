//
//  MarkdownParser.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 07.05.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HTMLReader/HTMLReader.h>

@interface MarkdownParser : NSObject

-(NSAttributedString*) parseMarkdownHtmlString:(NSString*)htmlString;

@end
