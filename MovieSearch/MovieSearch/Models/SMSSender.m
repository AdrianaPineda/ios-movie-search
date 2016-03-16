//
//  SMSSender.m
//  MovieSearch
//
//  Created by Adriana Pineda on 3/15/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

#import "SMSSender.h"

#import <AFNetworking/AFNetworking.h>

#define TWILIO_SMS_URL @"https://api.twilio.com/2010-04-01/Accounts/%@/Messages.json"
#define TWILIO_ACCOUNT_SID @"AC2bb2afd3df3290ba3354e96e8334e437"
#define TWILIO_AUTH_TOKEN @"787cbcd2a34fa11896e3c64c779210e6"
#define FROM_NUMBER @"+19253266669"
#define DEFAULT_TO_NUMBER @"+573007888618"

@implementation SMSSender

+ (void)sendSMSWithMessage:(NSString *)message {

    NSString *urlAsString = [NSString stringWithFormat:TWILIO_SMS_URL, TWILIO_ACCOUNT_SID];
    NSDictionary *paramsAsDict = @{@"To": DEFAULT_TO_NUMBER, @"From": FROM_NUMBER, @"Body": message};

    NSURL *URL = [NSURL URLWithString:urlAsString];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:TWILIO_ACCOUNT_SID password:TWILIO_AUTH_TOKEN];

    [manager POST:URL.absoluteString parameters:paramsAsDict progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        NSString *messageContent = [json objectForKey:@"body"];
        NSLog(@"%@",messageContent);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}

@end
