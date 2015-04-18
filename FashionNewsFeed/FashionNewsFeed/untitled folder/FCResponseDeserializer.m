//
//  FCResponseDeserializer.m
//  FashionNewsFeed
//
//  Created by anch on 4/14/15.
//  Copyright (c) 2015 Anton Dosov. All rights reserved.
//

#import "FCResponseDeserializer.h"
#import "FCPost.h"

@implementation FCResponseDeserializer

//-(id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
//{
    //NSString * strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
 //   NSMutableArray * posts = [NSMutableArray new];
    
    //[strData enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
   //     NSArray * components = [self parseLine:line];
    //    FCPost * stockValue = [[FCPost alloc] initWithArray:components];
    //    [posts addObject:stockValue];
    //}];
    
   // return posts;
//}

//-(NSArray*)parseLine:(NSString*)line
//{
//    NSMutableArray * allComponents = [NSMutableArray new];
//    NSMutableString * currentComponent = [NSMutableString new];
//    
//    BOOL inQuotes = NO;
//    BOOL lastWasBackslash = NO;
//    
//    for (NSInteger i = 0; i < line.length; i++)
//    {
//        unichar chr = [line characterAtIndex:i];
//        if (chr == '"' && !lastWasBackslash) inQuotes = !inQuotes;
//        else if (chr == '\\') lastWasBackslash = YES;
//        else if (!inQuotes && chr == ',')
//        {
//            [allComponents addObject:currentComponent];
//            currentComponent = [NSMutableString new];
//        }
//        else
//        {
//            lastWasBackslash = NO;
//            [currentComponent appendFormat:@"%c", chr];
//        }
//    }
//    
//    if (currentComponent.length > 0) [allComponents addObject:currentComponent];
//    
//    return allComponents;
//}

@end