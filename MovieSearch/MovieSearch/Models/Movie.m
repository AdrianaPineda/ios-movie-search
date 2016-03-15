//
//  Movie.m
//  MovieSearch
//
//  Created by Adriana Pineda on 3/13/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

#import "Movie.h"

#define YEAR_KEY @"Year"
#define TITLE_KEY @"Title"
#define POSTER_URL_KEY @"Poster"
#define IMDB_ID_KEY @"imdbId"

@implementation Movie

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {

        self.year = [[dictionary objectForKey:YEAR_KEY] integerValue];
        self.title = [dictionary objectForKey:TITLE_KEY];
        self.posterUrl = [dictionary objectForKey:POSTER_URL_KEY];
        self.imdbID = [dictionary objectForKey:IMDB_ID_KEY];
    }

    return self;
}

- (NSData *)getPosterImageData {

    NSString *posterUrlAsString = self.posterUrl;
    NSURL *posterUrl = [NSURL URLWithString:posterUrlAsString];
    NSData *imageData = [NSData dataWithContentsOfURL:posterUrl];
    return imageData;
}
@end
