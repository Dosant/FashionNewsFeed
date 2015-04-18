//
//  FCFeaturedImage.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCFeaturedImage : NSObject

@property (assign, nonatomic) NSUInteger imageId;
@property (strong, nonatomic) NSString *imageTitle;
@property (strong, nonatomic) NSString *imageSource;
@property (strong, nonatomic) NSMutableArray *imageAttachmentMeta; //FCAttachmentMeta

- (instancetype)initImageWithId:(NSUInteger)imageId
                       andTitle:(NSString *)imageTitle
                      andAuthor:(NSString *)imageSource
                     andContent:(NSMutableArray *)imageAttachmentMeta;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
