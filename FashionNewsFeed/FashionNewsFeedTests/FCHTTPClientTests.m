//
//  FCHttpClientTests.m
//  FashionNewsFeed
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FCHTTPClient.h"

@interface FCHTTPClientTests : XCTestCase
{
    
}
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
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method"];
    
    FCHTTPClient *client = [FCHTTPClient sharedClient];
    
    __block NSData* receivedData = nil;
    
    [client getPostById:1000
                success:^(NSURLSessionDataTask *task, id responseObject){
                    receivedData = responseObject;
                    [expectation fulfill];
                }
                failure:^(NSURLSessionDataTask *task, NSError *error){
                }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        else
        {
            XCTAssertNotNil(receivedData, @"Received data should not be nil");
        }
    }];
    
}

- (void)testGetCategories
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method"];
    
    FCHTTPClient *client = [FCHTTPClient sharedClient];
    
    __block NSData* receivedData = nil;
    
    [client getCategories:^(NSURLSessionDataTask *task, id responseObject){
        receivedData = responseObject;
        [expectation fulfill];
    }
                  failure:^(NSURLSessionDataTask *task, NSError *error){
                  }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        else
        {
            XCTAssertNotNil(receivedData, @"Received data should not be nil");
        }
    }];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end