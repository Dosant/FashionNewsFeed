//
//  FCAttachmentMeta.m
//  FashionNewsFeed
//

#import "FCAttachmentMeta.h"

@implementation FCAttachmentMeta

- (instancetype)initAttachmentMetaWithId:(NSUInteger)attachmentMetaId
                                 andFile:(NSString *)attachmentMetaFile
                                andWidth:(NSString *)attachmentMetaWidth
                               andHeight:(NSString *)attachmentMetaHeight
                                  andUrl:(NSString *)attachmentMetaUrl
{
    self = [super init];
    if (self) {
        self.attachmentMetaId = attachmentMetaId;
        self.attachmentMetaFile = attachmentMetaFile;
        self.attachmentMetaWidth = attachmentMetaWidth;
        self.attachmentMetaHeight = attachmentMetaHeight;
        self.attachmentMetaUrl = attachmentMetaUrl;
    }
    return self;
}

@end
