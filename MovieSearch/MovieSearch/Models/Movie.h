//
//  Movie.h
//  MovieSearch
//
//  Created by Adriana Pineda on 3/13/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic) NSInteger year;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *posterUrl;
@property (nonatomic) NSString *imdbID;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
@end
