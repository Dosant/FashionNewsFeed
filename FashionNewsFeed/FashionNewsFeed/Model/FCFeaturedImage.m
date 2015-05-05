//
//  FCFeaturedImage.m
//  FashionNewsFeed
//

#import "FCFeaturedImage.h"

@implementation FCFeaturedImage

- (instancetype)initImageWithId:(NSUInteger)imageId
                       andTitle:(NSString *)imageTitle
                      andSource:(NSURL *)imageSource {
    self = [super init];
    if (self) {
        self.imageId = imageId;
        self.imageTitle = imageTitle;
        self.imageSource = imageSource;
    }
    return self;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.imageId = (NSUInteger) [[attributes valueForKeyPath:@"ID"] integerValue];
        self.imageTitle = [attributes valueForKeyPath:@"title"];

        NSString *urlString = [[attributes valueForKeyPath:@"source"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        self.imageSource = url;

        self.imageHeight = (NSUInteger) [[[attributes valueForKeyPath:@"attachment_meta"] valueForKeyPath:@"height"] integerValue];
        self.imageWidth = (NSUInteger) [[[attributes valueForKeyPath:@"attachment_meta"] valueForKeyPath:@"width"] integerValue];

        // NSLog(@"%@",self.imageSource);

        /*
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
         */
        //self.imageAttachmentMeta = meta;
        //self.maxFeaturedImage = [self getTheLargestPicture:meta];

    }
    return self;
}

- (CGFloat)imageAspectRatio {
    return (CGFloat) self.imageHeight / self.imageWidth;
}

@end
