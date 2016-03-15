//
//  MovieTests.m
//  MovieSearch
//
//  Created by Adriana Pineda on 3/14/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Movie.h"

#define YEAR_KEY @"Year"
#define TITLE_KEY @"Title"
#define POSTER_URL_KEY @"Poster"
#define IMDB_ID_KEY @"imdbId"

@interface MovieTests : XCTestCase

@end

@implementation MovieTests

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

- (void)testInitWithDictionary_1 {

    NSDictionary *movieDictionary = @{};

    Movie *movie = [[Movie alloc] initWithDictionary:movieDictionary];
    XCTAssertTrue(movie.year == 0);
    XCTAssertNil(movie.title);
    XCTAssertNil(movie.posterUrl);
    XCTAssertNil(movie.imdbID);
    
}

- (void)testInitWithDictionary_2 {

    NSInteger year = 2015;
    NSString *title = @"Harry Potter";
    NSString *posterUrl = @"http://xyx.com";
    NSString *imdbId = @"abc123";

    NSDictionary *movieDictionary = @{YEAR_KEY: [NSNumber numberWithInteger:year], TITLE_KEY: title, POSTER_URL_KEY: posterUrl, IMDB_ID_KEY: imdbId};

    Movie *movie = [[Movie alloc] initWithDictionary:movieDictionary];
    XCTAssertTrue(movie.year == year);
    XCTAssertTrue([movie.title isEqualToString:title]);
    XCTAssertTrue([movie.posterUrl isEqualToString:posterUrl]);
    XCTAssertTrue([movie.imdbID isEqualToString:imdbId]);
    
}

- (void)testInitWithDictionary_3 {

    NSString *year = @"2015";
    NSString *title = @"Harry Potter";
    NSString *posterUrl = @"http://xyx.com";
    NSString *imdbId = @"abc123";

    NSDictionary *movieDictionary = @{YEAR_KEY: year, TITLE_KEY: title, POSTER_URL_KEY: posterUrl, IMDB_ID_KEY: imdbId};

    Movie *movie = [[Movie alloc] initWithDictionary:movieDictionary];
    XCTAssertTrue(movie.year == [year intValue]);
    XCTAssertTrue([movie.title isEqualToString:title]);
    XCTAssertTrue([movie.posterUrl isEqualToString:posterUrl]);
    XCTAssertTrue([movie.imdbID isEqualToString:imdbId]);
    
}

- (void)testGetPosterImageData_1 {

    NSInteger year = 2015;
    NSString *title = @"Harry Potter";
    NSString *posterUrl = @"http://xyx.com";
    NSString *imdbId = @"abc123";

    NSDictionary *movieDictionary = @{YEAR_KEY: [NSNumber numberWithInteger:year], TITLE_KEY: title, POSTER_URL_KEY: posterUrl, IMDB_ID_KEY: imdbId};

    Movie *movie = [[Movie alloc] initWithDictionary:movieDictionary];

    NSData *posterImageData = [movie getPosterImageData];

    NSData *expectedData = [NSData dataWithContentsOfURL: [NSURL URLWithString:posterUrl]];

    XCTAssertEqual(posterImageData, expectedData);
}

- (void)testGetPosterImageData_2 {

    NSInteger year = 2015;
    NSString *title = @"Harry Potter";
    NSString *posterUrl = @"";
    NSString *imdbId = @"abc123";

    NSDictionary *movieDictionary = @{YEAR_KEY: [NSNumber numberWithInteger:year], TITLE_KEY: title, POSTER_URL_KEY: posterUrl, IMDB_ID_KEY: imdbId};

    Movie *movie = [[Movie alloc] initWithDictionary:movieDictionary];

    NSData *posterImageData = [movie getPosterImageData];

    NSData *expectedData = [NSData dataWithContentsOfURL: [NSURL URLWithString:posterUrl]];

    XCTAssertEqual(posterImageData, expectedData);
}

- (void)testGetPosterImageData_3 {

    NSInteger year = 2015;
    NSString *title = @"Harry Potter";
    NSString *imdbId = @"abc123";

    NSDictionary *movieDictionary = @{YEAR_KEY: [NSNumber numberWithInteger:year], TITLE_KEY: title, IMDB_ID_KEY: imdbId};

    Movie *movie = [[Movie alloc] initWithDictionary:movieDictionary];

    NSData *posterImageData = [movie getPosterImageData];

    XCTAssertNil(posterImageData);
}

@end
