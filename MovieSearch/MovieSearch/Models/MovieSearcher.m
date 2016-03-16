//
//  MovieSearch.m
//  MovieSearch
//
//  Created by Adriana Pineda on 3/14/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

#import "MovieSearcher.h"
#import "Movie.h"
#import <AFNetworking/AFNetworking.h>

#define MOVIES_RESULT_KEY @"Search"
#define OMDB_URL @"https://www.omdbapi.com?s=%@"
#define DEFAULT_SEARCH_TITLE @"harry"

@implementation MovieSearcher

+ (void)searchMoviesWithTitle:(NSString *)title completionHandler:(void (^)(NSArray *movies))completionHandler {

    if ([title length] <= 0) {
        title = DEFAULT_SEARCH_TITLE;
    }

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSString *urlAsString = [NSString stringWithFormat:OMDB_URL, title];
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id  responseObject, NSError * error) {

        if (error) {
            NSLog(@"ERROR");
            completionHandler(nil);
        } else {

            NSMutableArray *movies = [[NSMutableArray alloc] init];
            NSDictionary *moviesDictionary = [responseObject objectForKey:MOVIES_RESULT_KEY];
            for (NSDictionary *movieDic in moviesDictionary) {
                Movie *currentMovie = [[Movie alloc] initWithDictionary:movieDic];
                [movies addObject:currentMovie];
            }

            completionHandler(movies);

        }
    }];

    [dataTask resume];

}

@end