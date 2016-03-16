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
#import "SMSSender.h"

@interface MovieDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieYear;
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
    [self configureMovieYear];
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

- (void)configureMovieYear {

    if (self.movie) {
        self.movieYear.text = [NSString stringWithFormat:@"%d", self.movie.year];
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

    NSString *message = [NSString stringWithFormat:@"I'm watching %@", self.movie.title];

    [SMSSender sendSMSWithMessage:message];
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
