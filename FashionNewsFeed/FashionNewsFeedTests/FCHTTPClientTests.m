//
//  FCHttpClientTests.m
//  FashionNewsFeed
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FCHTTPClient.h"

@interface FCHTTPClientTests : XCTestCase
@end

@implementation FCHTTPClientTests : XCTestCase {
    NSObject *temp;
}

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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)debug:(id)response {
    NSLog([response description]);
}

- (void)testGetAllCategories {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method"];
    FCHTTPClient *client = [self getsharedClient];
    __block NSData *receivedData = nil;

    [client getCategories:@"news"
                  success:^(NSURLSessionDataTask *task, id responseObject) {
                      XCTAssert([responseObject description] > 0);
                      [expectation fulfill];
                      temp = responseObject;
                      ([responseObject description]);
                      [self debug:responseObject];
                      NSString *str = [responseObject description];
                      XCTAssert(YES, @"%@", str);
                  }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                      XCTAssertFalse(@"Failed");
                  }];
}

- (void)testGetPostById {

    XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    FCHTTPClient *client = [FCHTTPClient sharedClient];

    [client getPostById:1000
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    XCTAssert([responseObject description] > 0);
                    [expectation fulfill];
                    temp = responseObject;
                    ([responseObject description]);
                    [self debug:responseObject];
                    NSString *str = [responseObject description];
                    XCTAssert(YES, @"%@", str);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    XCTAssertFalse(@"Failed");
                }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)getPostsByCategory {

    XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    FCHTTPClient *client = [FCHTTPClient sharedClient];

    [client getPostsByCategory:@"NEWS"
                 andPageNumber:5
               andPostsPerPage:12
                       success:^(NSURLSessionDataTask *task, id responseObject) {
                           XCTAssert([responseObject description] > 0);
                           [expectation fulfill];
                           temp = responseObject;
                           ([responseObject description]);
                           [self debug:responseObject];
                           NSString *str = [responseObject description];
                           XCTAssert(YES, @"%@", str);
                       }
                       failure:^(NSURLSessionDataTask *task, NSError *error) {
                           XCTAssertFalse(@"Failed");
                       }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

@end