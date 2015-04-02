#import "FCPost.h"

@implementation FCPost

@synthesize postId;
@synthesize content;

-(id)initWithContentAndId:(NSString *)content_ postId:(int)postId_
{
    self = [super init];
    if (self) {
        self.content = content_;
        self.postId = postId_;
    }
    return self;
}

@end
