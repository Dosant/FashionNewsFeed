//
//  FCHttpClientTests.m
//  FashionNewsFeed
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FCHTTPClient.h"

@interface FCHTTPClientTests : XCTestCase

@end

@implementation FCHTTPClientTests : XCTestCase

- (FCHTTPClient *)getsharedClient
{
    return [FCHTTPClient sharedClient];
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetPostWithId
{
    FCHTTPClient *client = [FCHTTPClient sharedClient];
    
    [client getPostById:1000
                success:^(NSURLSessionDataTask *task, id responseObject){
                    XCTAssert(YES, @"Pass");
                }
                failure:^(NSURLSessionDataTask *task, NSError *error){
                    XCTAssert(NO, @"Failed");
                }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

