//
//  FCAttachmentMeta.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FCAttachmentMeta : NSObject

@property(strong, nonatomic) NSString *attachmentMetaFile;
@property(assign, nonatomic) NSUInteger attachmentMetaWidth;
@property(assign, nonatomic) NSUInteger attachmentMetaHeight;
@property(strong, nonatomic) NSURL *attachmentMetaUrl;

- (instancetype)initAttachmentMetaWithFile:(NSString *)attachmentMetaFile
                                  andWidth:(NSUInteger)attachmentMetaWidth
                                 andHeight:(NSUInteger)attachmentMetaHeight
                                    andUrl:(NSURL *)attachmentMetaUrl;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

-(CGFloat)attachmentAspectRation;


- (void)printMeta;

@end
