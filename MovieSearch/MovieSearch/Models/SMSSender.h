//
//  SMSSender.h
//  MovieSearch
//
//  Created by Adriana Pineda on 3/15/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMSSender : NSObject

+ (void)sendSMSWithMessage:(NSString *)message;

@end
