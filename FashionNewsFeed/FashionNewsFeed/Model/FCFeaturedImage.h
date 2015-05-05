//
//  FCFeaturedImage.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FCFeaturedImage : NSObject

@property(assign, nonatomic) NSUInteger imageId;
@property(strong, nonatomic) NSString *imageTitle;
@property(strong, nonatomic) NSURL *imageSource;
@property(assign, nonatomic) NSUInteger imageHeight;
@property(assign, nonatomic) NSUInteger imageWidth;

- (instancetype)initImageWithId:(NSUInteger)imageId
                       andTitle:(NSString *)imageTitle
                      andSource:(NSURL *)imageSource;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

- (CGFloat)imageAspectRatio;

@end
