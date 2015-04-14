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

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.attachmentMetaId = (NSUInteger)[[attributes valueForKeyPath:@"id"] integerValue];
        self.attachmentMetaFile = [attributes valueForKeyPath:@"text"];
        self.attachmentMetaWidth = [attributes valueForKeyPath:@"text"];
        self.attachmentMetaHeight = [attributes valueForKeyPath:@"text"];
        self.attachmentMetaUrl = [attributes valueForKeyPath:@"text"];
    }
    return self;
}

@end
