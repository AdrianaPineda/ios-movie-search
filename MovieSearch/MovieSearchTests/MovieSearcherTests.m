//
//  MovieSearcherTests.m
//  MovieSearch
//
//  Created by Adriana Pineda on 3/14/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MovieSearcher.h"
#import <OCMock/OCMock.h>
#import <AFNetworking/AFNetworking.h>

@interface MovieSearcherTests : XCTestCase

@end

@implementation MovieSearcherTests

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
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testSearchMovies {
    NSString *searchTitle = @"harry";

    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Long method"];
    [MovieSearcher searchMoviesWithTitle:searchTitle completionHandler:^(NSArray *movies) {

        XCTAssertTrue(movies.count > 0);
        [completionExpectation fulfill];

    }];

    [self waitForExpectationsWithTimeout:5.0 handler:nil];

}
@end
