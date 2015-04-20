//
//  FCHttpClientTests.m
//  FashionNewsFeed
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FashionCollectionAPI.h"

@interface FashionCollectionAPITests : XCTestCase
@end

@implementation FashionCollectionAPITests

- (FashionCollectionAPI *)getsharedInstance {
    return [FashionCollectionAPI sharedInstance];
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
        // Put the code you want to measure the time of here.
    }];
}

- (void)testGetCategories {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getCategories:^(NSURLSessionDataTask *task, id responseObject) {
                XCTAssert(YES, @"Pass");
                [expectation fulfill];
            }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                      XCTAssertFalse(@"Failed");
                  }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, "Error");
    }];
}

- (void)testGetPostById {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getPostById:1000
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    XCTAssert(YES, @"Pass");
                    [expectation fulfill];
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    XCTAssertFalse(@"Failed");
                }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, "Error");
    }];
}

- (void)testGetBeautyBoxPosts {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getBeautyBoxPosts:1
                 postsPerPage:5
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          XCTAssert(YES, @"Pass");
                          [expectation fulfill];
                      }
                      failure:^(NSURLSessionDataTask *task, NSError *error) {
                          XCTAssertFalse(@"Failed");
                      }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, "Error");
    }];
}

@end