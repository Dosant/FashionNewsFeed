#import <Foundation/Foundation.h>

@interface FCCategory : NSObject {
    int categoryId;
    NSString* categoryName;
}

@property (nonatomic) int categoryId;
@property (strong, nonatomic) NSString* categoryName;

- (id)initWithNameAndId:(NSString*)categoryName categoryId:(int)categoryId;

@end