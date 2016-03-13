//
//  MovieDetailViewController.m
//  MovieSearch
//
//  Created by Adriana Pineda on 3/13/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "Social/Social.h"

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

    }];

    UIAlertAction *smsAction = [UIAlertAction actionWithTitle:@"SMS" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];

    [alertController addAction:twitterAction];
    [alertController addAction:smsAction];

    [self presentViewController:alertController animated:YES completion:nil];
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
