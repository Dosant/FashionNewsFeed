#import <Foundation/Foundation.h>
#import "FCCategory.h"

@implementation FCCategory

@synthesize categoryId;
@synthesize categoryName;

-(id)initWithNameAndId:(NSString *)categoryName_ categoryId:(int)categoryId_
{
    self = [super init];
    if (self) {
        self.categoryName = categoryName_;
        self.categoryId = categoryId_;
    }
    return self;
}

@end
