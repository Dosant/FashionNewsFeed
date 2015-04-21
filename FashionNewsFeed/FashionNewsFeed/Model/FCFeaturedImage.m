//
//  FCFeaturedImage.m
//  FashionNewsFeed
//

#import "FCFeaturedImage.h"
#import "FCAttachmentMeta.h"

@implementation FCFeaturedImage

- (instancetype)initImageWithId:(NSUInteger)imageId
                       andTitle:(NSString *)imageTitle
                      andSource:(NSURL *)imageSource
              andAttachmentMeta:(NSMutableArray *)imageAttachmentMeta // FCAttachmentMeta
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

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.imageId = (NSUInteger) [[attributes valueForKeyPath:@"ID"] integerValue];
        self.imageTitle = [attributes valueForKeyPath:@"title"];

        NSURL *url = [NSURL URLWithString:[attributes valueForKeyPath:@"source"]];
        self.imageSource = url;

        NSMutableArray *meta = [[NSMutableArray alloc] init];
        for (NSString *attachment in [attributes valueForKeyPath:@"attachment_meta"]) {
            if ([attachment isEqualToString:@"sizes"]) {
                id sizes = [[attributes valueForKeyPath:@"attachment_meta"] objectForKey:attachment];
                for (NSString *size in sizes) {
                    id values = [sizes objectForKey:size];
                    FCAttachmentMeta *attachmentMeta = [[FCAttachmentMeta alloc] initWithAttributes:values];
                    [meta addObject:attachmentMeta];
                }
            }
        }
        self.imageAttachmentMeta = meta;
    }
    return self;
}

@end
