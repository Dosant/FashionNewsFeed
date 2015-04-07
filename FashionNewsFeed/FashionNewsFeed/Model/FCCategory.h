//
//  FCCategory.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCCategory : NSObject

@property (assign, nonatomic) NSUInteger categoryId;
@property (strong, nonatomic) NSString* categoryName;
@property (assign, nonatomic) NSUInteger categoryCount;
@property (strong, nonatomic) NSString* categoryLink;
@property (strong, nonatomic) NSMutableDictionary* categoryMeta;

- (id)initCategoryWithId:(NSUInteger)categoryId
                 andName:(NSString *)categoryName
                andCount:(NSUInteger) categoryCount
                 andLink:(NSString *)categoryLink
                 andMeta:(NSMutableDictionary *)categoryMeta;
@end