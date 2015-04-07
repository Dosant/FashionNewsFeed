//
//  FCFeaturedImage.m
//  FashionNewsFeed
//

#import "FCFeaturedImage.h"

@implementation FCFeaturedImage

- (instancetype)initImageWithId:(NSUInteger)imageId
                       andTitle:(NSString *)imageTitle
                      andAuthor:(NSString *)imageSource
                     andContent:(NSMutableArray *)imageAttachmentMeta
{
    self = [super init];
    if (self) {
        self.imageId = imageId;
        self.imageTitle = imageTitle;
        self.imageSource = imageSource;
        self.imageAttachmentMeta = imageAttachmentMeta;
    }
    return self;
}

@end
