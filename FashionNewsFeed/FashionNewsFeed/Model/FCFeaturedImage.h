//
//  FCFeaturedImage.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCFeaturedImage : NSObject

@property(assign, nonatomic) NSUInteger imageId;
@property(strong, nonatomic) NSString *imageTitle;
@property(strong, nonatomic) NSURL *imageSource;
@property(strong, nonatomic) NSMutableArray *imageAttachmentMeta; // FCAttachmentMeta

- (instancetype)initImageWithId:(NSUInteger)imageId
                       andTitle:(NSString *)imageTitle
                      andSource:(NSURL *)imageSource
              andAttachmentMeta:(NSMutableArray *)imageAttachmentMeta;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
