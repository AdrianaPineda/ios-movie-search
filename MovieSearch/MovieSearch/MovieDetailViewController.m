//
//  MovieDetailViewController.m
//  MovieSearch
//
//  Created by Adriana Pineda on 3/13/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "Social/Social.h"
#import <AFNetworking/AFNetworking.h>

#define TWILIO_SMS_URL @"https://api.twilio.com/2010-04-01/Accounts/%@/Messages.json"
#define TWILIO_ACCOUNT_SID @"AC2bb2afd3df3290ba3354e96e8334e437"
#define TWILIO_AUTH_TOKEN @"787cbcd2a34fa11896e3c64c779210e6"
#define FROM_NUMBER @"+19253266669"
#define DEFAULT_TO_NUMBER @"+573007888618"

@interface MovieDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (nonatomic, strong) Movie *movie;
@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureMovieDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedMovie:(Movie *)movie {
    self.movie = movie;
}

- (void)configureMovieDetails {

    [self configureMoviePoster];
    [self configureMovieTitle];
}

- (void)configureMoviePoster {

    if (self.movie) {

        NSData *imageData = [self.movie getPosterImageData];
        UIImage *posterImage = [UIImage imageWithData:imageData];
        self.moviePoster.image = posterImage;
    }

}

- (void)configureMovieTitle {

    if (self.movie) {
        self.movieTitle.text = self.movie.title;
    }

}

- (IBAction)share:(id)sender {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Share" message:@"How do you want to share?" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *twitterAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [self shareWithTwitter];
    }];

    UIAlertAction *smsAction = [UIAlertAction actionWithTitle:@"SMS" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [self sendSMS];
    }];

    [alertController addAction:twitterAction];
    [alertController addAction:smsAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)shareWithTwitter {

    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {

        SLComposeViewController *twitterController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];

        [twitterController setInitialText: [NSString stringWithFormat:@"Im watching %@", self.movie.title]];

        [self presentViewController:twitterController animated:YES completion:nil];
    }
}

- (void)sendSMS {

    NSString *mesage = [NSString stringWithFormat:@"I'm watching %@", self.movie.title];
    NSString *urlAsString = [NSString stringWithFormat:TWILIO_SMS_URL, TWILIO_ACCOUNT_SID];
    NSDictionary *paramsAsDict = @{@"To": DEFAULT_TO_NUMBER, @"From": FROM_NUMBER, @"Body": mesage};

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
