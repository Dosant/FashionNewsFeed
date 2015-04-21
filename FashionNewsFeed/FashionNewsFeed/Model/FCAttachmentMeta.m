//
//  FCAttachmentMeta.m
//  FashionNewsFeed
//

#import "FCAttachmentMeta.h"

@implementation FCAttachmentMeta

- (instancetype)initAttachmentMetaWithFile:(NSString *)attachmentMetaFile
                                  andWidth:(NSString *)attachmentMetaWidth
                                 andHeight:(NSString *)attachmentMetaHeight
                                    andUrl:(NSString *)attachmentMetaUrl {
    self = [super init];
    if (self) {
        self.attachmentMetaFile = attachmentMetaFile;
        self.attachmentMetaWidth = attachmentMetaWidth;
        self.attachmentMetaHeight = attachmentMetaHeight;
        self.attachmentMetaUrl = attachmentMetaUrl;
    }
    return self;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.attachmentMetaFile = [attributes valueForKeyPath:@"file"];
        self.attachmentMetaWidth = [attributes valueForKeyPath:@"width"];
        self.attachmentMetaHeight = [attributes valueForKeyPath:@"height"];
        self.attachmentMetaUrl = [attributes valueForKeyPath:@"url"];
    }
    return self;
}

@end
