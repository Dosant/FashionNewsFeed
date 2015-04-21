//
//  FCAttachmentMeta.m
//  FashionNewsFeed
//

#import "FCAttachmentMeta.h"

@implementation FCAttachmentMeta

- (instancetype)initAttachmentMetaWithFile:(NSString *)attachmentMetaFile
                                  andWidth:(NSUInteger)attachmentMetaWidth
                                 andHeight:(NSUInteger)attachmentMetaHeight
                                    andUrl:(NSURL *)attachmentMetaUrl {
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
        self.attachmentMetaWidth = (NSUInteger) [[attributes valueForKeyPath:@"width"] integerValue];
        self.attachmentMetaHeight = (NSUInteger) [[attributes valueForKeyPath:@"height"] integerValue];

        NSURL *url = [NSURL URLWithString:[attributes valueForKeyPath:@"url"]];
        self.attachmentMetaUrl = url;
    }
    return self;
}

@end
