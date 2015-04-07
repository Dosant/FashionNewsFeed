//
//  FCAttachmentMeta.h
//  FashionNewsFeed
//

#import <Foundation/Foundation.h>

@interface FCAttachmentMeta : NSObject

@property (assign, nonatomic) NSUInteger attachmentMetaId;
@property (strong, nonatomic) NSString *attachmentMetaFile;
@property (strong, nonatomic) NSString *attachmentMetaWidth;
@property (strong, nonatomic) NSString *attachmentMetaHeight;
@property (strong, nonatomic) NSString *attachmentMetaUrl;

- (id)initAttachmentMetaWithId:(NSUInteger)attachmentMetaId
                       andFile:(NSString *)attachmentMetaFile
                      andWidth:(NSString *)attachmentMetaWidth
                     andHeight:(NSString *)attachmentMetaHeight
                        andUrl:(NSString *)attachmentMetaUrl;
@end
