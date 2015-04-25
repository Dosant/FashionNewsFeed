//
//  FCFeaturedImage.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>
#import "FCAttachmentMeta.h"

@interface FCFeaturedImage : NSObject

@property(assign, nonatomic) NSUInteger imageId;
@property(strong, nonatomic) NSString *imageTitle;
@property(strong, nonatomic) NSURL *imageSource;
//@property(strong, nonatomic) NSMutableArray *imageAttachmentMeta; // FCAttachmentMeta

@property(strong,nonatomic) FCAttachmentMeta *maxFeaturedImage;

@property(assign, nonatomic) NSUInteger featuredImageMaxHeight;

- (instancetype)initImageWithId:(NSUInteger)imageId
                       andTitle:(NSString *)imageTitle
                      andSource:(NSURL *)imageSource
              andAttachmentMeta:(NSMutableArray *)imageAttachmentMeta;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
