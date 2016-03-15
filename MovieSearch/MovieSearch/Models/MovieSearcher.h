//
//  MovieSearch.h
//  MovieSearch
//
//  Created by Adriana Pineda on 3/14/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieSearcher : NSObject

+ (void)searchMoviesWithTitle:(NSString *)title completionHandler:(void (^)(NSArray *movies))completionHandler;
@end
