//
//  FCFakeHTTPClient.m
//  FashionNewsFeed
//

#import "FCFakeHTTPClient.h"

@implementation FCFakeHTTPClient

+ (FCFakeHTTPClient *) sharedInstance{
    
    static FCFakeHTTPClient * _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[FCFakeHTTPClient alloc] init];
    });
    
    return _sharedInstance;
    
}

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    
    return self;
}

- (NSMutableArray *)getPosts{
    
    FCPost *post1 = [[FCPost alloc] init];
    post1.postId = 1000;
    post1.postTitle = @"Comme des Garçons: энергия взрыва";
    post1.postAuthor = nil;
    post1.postContent = @"<p>Показывать нужно только то, чего еще никогда не было — это философия дизайнера Рей Кавакубо.<!--more--></p>\n<blockquote><p>«Я всегда начинаю с того, что забываю все, что делала раньше, и игнорирую все, что уже существует. Меня может вдохновить случайная фотография, человек на улице, чувство или ощущение, ничего не значащий, может быть, даже бесполезный и выброшенный в мусорную корзину предмет – все, что угодно. Самое трудное – начало, концепция коллекции. Самое интересное – закончить коллекцию вовремя», — говорит дизайнер.</p></blockquote>\n<p>«Сокрушающая. Это энергия взрыва», — вкратце описала свою коллекцию Comme des Garçons весна-лето 2013 Рей Кавакубо.</p>\n<p>[simple_slideshow]</p>\n";
    post1.postLink = @"http://fcollection.by/archives/989";
    post1.postDate = nil;
    post1.postDateModified = nil;
    post1.postExcerpt = @"<p>Показывать нужно только то, чего еще никогда не было — это философия дизайнера Рей Кавакубо.</p>\n";
    post1.postMeta = nil;
    post1.postFeaturedImage = nil;
    post1.postTerms = nil;
    
    
    FCPost *post2 = [[FCPost alloc] init];
    post2.postId = 1200;
    post2.postTitle = @"Lookbook: Zara ноябрь 2012";
    post2.postAuthor = nil;
    post2.postContent = @"<p>Испанский бренд представил лукбук практичный и выдержанный в стиле военной парадной тематики: жакеты с воротничками, леггинсы с полосками и многое другое.<!--more--></p>\n<p><a href=\"http://fcollection.by/wp-content/uploads/2012/11/zara1.jpg\"><img src=\"http://fcollection.by/wp-content/uploads/2012/11/zara1.jpg\" alt=\"\" title=\"zara1\" width=\"400\" height=\"601\" class=\"aligncenter size-full wp-image-1196\" /></a></p>\n<p><a href=\"http://fcollection.by/wp-content/uploads/2012/11/zara2.jpg\"><img src=\"http://fcollection.by/wp-content/uploads/2012/11/zara2.jpg\" alt=\"\" title=\"zara2\" width=\"400\" height=\"600\" class=\"aligncenter size-full wp-image-1197\" /></a></p>\n<p><a href=\"http://fcollection.by/wp-content/uploads/2012/11/zara3.jpg\"><img src=\"http://fcollection.by/wp-content/uploads/2012/11/zara3.jpg\" alt=\"\" title=\"zara3\" width=\"400\" height=\"600\" class=\"aligncenter size-full wp-image-1198\" /></a></p>\n<p><a href=\"http://fcollection.by/wp-content/uploads/2012/11/zara4.jpg\"><img src=\"http://fcollection.by/wp-content/uploads/2012/11/zara4.jpg\" alt=\"\" title=\"zara4\" width=\"400\" height=\"600\" class=\"aligncenter size-full wp-image-1199\" /></a></p>\n<p><a href=\"http://fcollection.by/wp-content/uploads/2012/11/zara5.jpg\"><img src=\"http://fcollection.by/wp-content/uploads/2012/11/zara5.jpg\" alt=\"\" title=\"zara5\" width=\"400\" height=\"600\" class=\"aligncenter size-full wp-image-1200\" /></a></p>\n<p><a href=\"http://fcollection.by/wp-content/uploads/2012/11/zara6.jpg\"><img src=\"http://fcollection.by/wp-content/uploads/2012/11/zara6.jpg\" alt=\"\" title=\"zara6\" width=\"400\" height=\"600\" class=\"aligncenter size-full wp-image-1201\" /></a></p>\n<p><a href=\"http://fcollection.by/wp-content/uploads/2012/11/zara7.jpg\"><img src=\"http://fcollection.by/wp-content/uploads/2012/11/zara7.jpg\" alt=\"\" title=\"zara7\" width=\"400\" height=\"600\" class=\"aligncenter size-full wp-image-1202\" /></a></p>\n<p><a href=\"http://fcollection.by/wp-content/uploads/2012/11/zara8.jpg\"><img src=\"http://fcollection.by/wp-content/uploads/2012/11/zara8.jpg\" alt=\"\" title=\"zara8\" width=\"400\" height=\"600\" class=\"aligncenter size-full wp-image-1203\" /></a></p>\n<p><a href=\"http://fcollection.by/wp-content/uploads/2012/11/zara9.jpg\"><img src=\"http://fcollection.by/wp-content/uploads/2012/11/zara9.jpg\" alt=\"\" title=\"zara9\" width=\"400\" height=\"600\" class=\"aligncenter size-full wp-image-1204\" /></a></p>\n<p><a href=\"http://fcollection.by/wp-content/uploads/2012/11/zara10.jpg\"><img src=\"http://fcollection.by/wp-content/uploads/2012/11/zara10.jpg\" alt=\"\" title=\"zara10\" width=\"400\" height=\"600\" class=\"aligncenter size-full wp-image-1205\" /></a></p>\n<p><a href=\"http://fcollection.by/wp-content/uploads/2012/11/zara11.jpg\"><img src=\"http://fcollection.by/wp-content/uploads/2012/11/zara11.jpg\" alt=\"\" title=\"zara11\" width=\"400\" height=\"600\" class=\"aligncenter size-full wp-image-1206\" /></a></p>\n<p><a href=\"http://fcollection.by/wp-content/uploads/2012/11/zara12.jpg\"><img src=\"http://fcollection.by/wp-content/uploads/2012/11/zara12.jpg\" alt=\"\" title=\"zara12\" width=\"400\" height=\"600\" class=\"aligncenter size-full wp-image-1207\" /></a></p>\n<p><a href=\"http://fcollection.by/wp-content/uploads/2012/11/zara13.jpg\"><img src=\"http://fcollection.by/wp-content/uploads/2012/11/zara13.jpg\" alt=\"\" title=\"zara13\" width=\"400\" height=\"600\" class=\"aligncenter size-full wp-image-1208\" /></a></p>\n";
    post2.postLink = @"http://fcollection.by/archives/1195";
    post2.postDate = nil;
    post2.postDateModified = nil;
    post2.postExcerpt = @"<p>Испанский бренд представил лукбук практичный и выдержанный в стиле военной парадной тематики: жакеты с воротничками, леггинсы с полосками и многое другое.</p>\n";
    post2.postMeta = nil;
    post2.postFeaturedImage = nil;
    post2.postTerms = nil;
    
    NSMutableArray *posts = [NSMutableArray arrayWithObjects: post1, post2, nil];
    return posts;
}

- (NSMutableArray *)getCategories{
    
<<<<<<< HEAD
    FCCategory *category1 = [[FCCategory alloc] init];
    category1.categoryId = 1;
    category1.categoryName = @"НОВОСТИ";
    category1.categoryCount = 100;
    category1.categoryLink = @"http://fcollection.by/archives/category/news";
    category1.categoryMeta = nil;

    FCCategory *category2 = [[FCCategory alloc] init];
    category2.categoryId = 2;
    category2.categoryName = @"МОДА";
    category2.categoryCount = 200;
    category2.categoryLink = @"http://fcollection.by/archives/category/fashion";
    category2.categoryMeta = nil;

    FCCategory *category3 = [[FCCategory alloc] init];
    category3.categoryId = 3;
    category3.categoryName = @"СОБЫТИЯ";
    category3.categoryCount = 300;
    category3.categoryLink = @"http://fcollection.by/archives/category/events";
    category3.categoryMeta = nil;

    FCCategory *category4 = [[FCCategory alloc] init];
    category4.categoryId = 4;
    category4.categoryName = @"FC BEAUTY BOX";
    category4.categoryCount = 400;
    category4.categoryLink = @"http://fcollection.by/archives/category/beauty_box";
    category4.categoryMeta = nil;
=======
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"self",@"http://fcollection.by/test1", nil];
    FCCategory *category1 = [[FCCategory alloc] initCategoryWithId:1 andName:@"НОВОСТИ" andCount:100 andLink:@"http://fcollection.by/archives/category/news" andMeta:dict1];
    
    NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"self",@"http://fcollection.by/test2", nil];
    FCCategory *category2 = [[FCCategory alloc] initCategoryWithId:2 andName:@"МОДА" andCount:200 andLink:@"http://fcollection.by/archives/category/fashion" andMeta:dict2];
    
    NSMutableDictionary *dict3 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"self",@"http://fcollection.by/test3", nil];
    FCCategory *category3 = [[FCCategory alloc] initCategoryWithId:3 andName:@"КОЛЛЕКЦИИ" andCount:300 andLink:@"http://fcollection.by/archives/category/collections" andMeta:dict3];
    
    NSMutableDictionary *dict4 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"self",@"http://fcollection.by/test4", nil];
    FCCategory *category4 = [[FCCategory alloc] initCategoryWithId:4 andName:@"ЛИЦА" andCount:400 andLink:@"http://fcollection.by/archives/category/face" andMeta:dict4];
>>>>>>> origin/master
    
    NSMutableArray *categories = [NSMutableArray arrayWithObjects: category1, category2, category3, nil];
    [categories addObject:category4];
    
    return categories;
}

@end
