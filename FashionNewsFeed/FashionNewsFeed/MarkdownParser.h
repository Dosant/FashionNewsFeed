//
//  MarkdownParser.h
//  FashionNewsFeed
//
//  Created by Anton Dosov on 07.05.15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HTMLReader/HTMLReader.h>
#import "FashionCollectionAPI.h"
#import "MarkdownImage.h"

@class MarkdownParser;

@protocol MarkdownParserDelegate <NSObject>

@required

- (void)markdownParserImageDownloaded:(MarkdownParser *)parser withTextAttachemnt:(NSTextAttachment*)textAttachment
                            WithRange:(NSRange)range;



@end


@interface MarkdownParser : NSObject

@property (nonatomic, weak) id <MarkdownParserDelegate> delegate;
@property (nonatomic,assign) CGFloat textContainerWidth;

-(NSMutableAttributedString*) parseMarkdownHtmlString:(NSString*)htmlString;
-(void)downloadImagesToAttribtutedString;




@end
