/*
 "id": 1,
 "type": "post",
 "slug": "hello-world",
 "url": "http:\/\/localhost\/wordpress\/?p=1",
 "title": "Hello world!",
 "title_plain": "Hello world!",
 "content": "<p>Welcome to WordPress. This is your first post. Edit or delete it, then start blogging!<\/p>\n",
 "excerpt": "Welcome to WordPress. This is your first post. Edit or delete it, then start blogging!\n",
 "date": "2009-11-11 12:50:19",
 "modified": "2009-11-11 12:50:19",
 "categories": [],
 "tags": [],
 "attachments" : []
 */

#import <Foundation/Foundation.h>

@interface FCPost : NSObject

@property(nonatomic) int postId;
@property(strong, nonatomic) NSString* type;
@property(strong, nonatomic) NSString* url;
@property(strong, nonatomic) NSString* title;
@property(strong, nonatomic) NSString* content;
@property(strong, nonatomic) NSString* date;
@property(strong, nonatomic) NSArray* categories;
@property(strong, nonatomic) NSArray* tags;
@property(strong, nonatomic) NSArray* attachments;

- (id)initWithContentAndId:(NSString*)content postId:(int)postId;

@end
