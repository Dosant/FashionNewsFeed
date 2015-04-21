//
//  FCCategory.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCCategory : NSObject

@property(assign, nonatomic) NSUInteger categoryId;
@property(strong, nonatomic) NSString *categoryName;
@property(assign, nonatomic) NSUInteger categoryCount;
@property(strong, nonatomic) NSURL *categoryLink;
@property(strong, nonatomic) NSMutableDictionary *categoryMeta;

- (instancetype)initCategoryWithId:(NSUInteger)categoryId
                           andName:(NSString *)categoryName
                          andCount:(NSUInteger)categoryCount
                           andLink:(NSURL *)categoryLink
                           andMeta:(NSMutableDictionary *)categoryMeta;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end