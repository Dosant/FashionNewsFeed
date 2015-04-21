//
//  FCHttpClientTests.m
//  FashionNewsFeed
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FCHTTPClient.h"

@interface FCHTTPClientTests : XCTestCase
@end

@implementation FCHTTPClientTests

- (FCHTTPClient *)getsharedClient {
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

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        XCTAssert(YES, @"Pass");
        // Put the code you want to measure the time of here.
    }];
}

- (void)testGetAllCategories {

    XCTestExpectation *getAllCategoriesExpectation = [self expectationWithDescription:@"Data downloaded"];
    FCHTTPClient *client = [self getsharedClient];

    [client getCategories:^(NSURLSessionDataTask *task, id responseObject) {
                XCTAssert(YES, @"Pass");
                [getAllCategoriesExpectation fulfill];
            }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                      XCTAssertFalse(@"Failed");
                  }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, "Error");
    }];
}

- (void)testGetPostById {

    XCTestExpectation *getPostByIdExpectation = [self expectationWithDescription:@"Data downloaded"];
    FCHTTPClient *client = [self getsharedClient];

    [client getPostById:1000
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    XCTAssert(YES, @"Pass");
                    [getPostByIdExpectation fulfill];
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    XCTAssertFalse(@"Failed");
                }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, "Error");
    }];
}

- (void)testGetPostsByCategory {

    XCTestExpectation *getPostsByCategoryExpectation = [self expectationWithDescription:@"Data downloaded"];
    FCHTTPClient *client = [self getsharedClient];

    [client getPostsByCategory:@"beauty_box"
                 andPageNumber:5
               andPostsPerPage:12
                       success:^(NSURLSessionDataTask *task, id responseObject) {
                           XCTAssert(YES, @"Pass");
                           [getPostsByCategoryExpectation fulfill];
                       }
                       failure:^(NSURLSessionDataTask *task, NSError *error) {
                           XCTAssertFalse(@"Failed");
                       }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, "Error");
    }];
}

@end