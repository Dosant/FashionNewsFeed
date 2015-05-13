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

    [client getPostById:100
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

- (void)testGetPostByIdWithSpecialHtmlCharacters {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getPostById:34021
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

- (void)testGetLatestPosts {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getLatestsPosts:1
               postsPerPage:12
                    success:^(NSURLSessionDataTask *task, id responseObject, FCResponseHeaders *headers) {
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
                      success:^(NSURLSessionDataTask *task, id responseObject, FCResponseHeaders *headers) {
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

- (void)testGetLifestylePosts {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getLifestylePosts:1
                 postsPerPage:5
                      success:^(NSURLSessionDataTask *task, id responseObject, FCResponseHeaders *headers) {
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

- (void)testGetBreakfastPosts {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getBreakfastPosts:1
                 postsPerPage:5
                      success:^(NSURLSessionDataTask *task, id responseObject, FCResponseHeaders *headers) {
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

- (void)testGetKonkursPosts {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getKonkursPosts:1
               postsPerPage:5
                    success:^(NSURLSessionDataTask *task, id responseObject, FCResponseHeaders *headers) {
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

- (void)testGetBeautyPosts {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getBeautyPosts:1
              postsPerPage:5
                   success:^(NSURLSessionDataTask *task, id responseObject, FCResponseHeaders *headers) {
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

- (void)testGetFacePosts {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getFacePosts:1
            postsPerPage:5
                 success:^(NSURLSessionDataTask *task, id responseObject, FCResponseHeaders *headers) {
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

- (void)testGetBestPosts {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getBestPosts:1
            postsPerPage:5
                 success:^(NSURLSessionDataTask *task, id responseObject, FCResponseHeaders *headers) {
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

- (void)testGetFashionPosts {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getFashionPosts:1
               postsPerPage:5
                    success:^(NSURLSessionDataTask *task, id responseObject, FCResponseHeaders *headers) {
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

- (void)testGetNewsPosts {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getNewsPosts:1
            postsPerPage:5
                 success:^(NSURLSessionDataTask *task, id responseObject, FCResponseHeaders *headers) {
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

- (void)testGetEventsPosts {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectation"];
    FashionCollectionAPI *client = [self getsharedInstance];

    [client getEventsPosts:1
              postsPerPage:5
                   success:^(NSURLSessionDataTask *task, id responseObject, FCResponseHeaders *headers) {
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