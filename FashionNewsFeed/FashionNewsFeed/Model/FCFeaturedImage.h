//
//  FCFeaturedImage.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCFeaturedImage : NSObject

@property (assign, nonatomic) NSUInteger imageId;
@property (strong, nonatomic) NSString *imageTitle;
@property (strong, nonatomic) NSString *imageSource;
//Please use FCAttachmentMeta for imageAttachmentMeta array
@property (strong, nonatomic) NSMutableArray *imageAttachmentMeta;

- (id)initImageWithId:(NSUInteger)imageId
             andTitle:(NSString *)imageTitle
            andAuthor:(NSString *)imageSource
           andContent:(NSMutableArray *)imageAttachmentMeta;
@end
