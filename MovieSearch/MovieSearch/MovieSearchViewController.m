//
//  MovieSearchViewController.m
//  MovieSearch
//
//  Created by Adriana Pineda on 3/14/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

#import "MovieSearchViewController.h"
#import "MoviesTableViewController.h"

#define moviesListSegueIdentifier @"moviesList"

@interface MovieSearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *movieTitleTextField;
@property (weak, nonatomic) IBOutlet UIButton *search;

@end

@implementation MovieSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchMovie:(id)sender {

    if ([self isMovieTitleTextValid]) {

        [self performSegueWithIdentifier:moviesListSegueIdentifier sender:self];
    }

}

- (BOOL)isMovieTitleTextValid {
    if ([[self getCurrentMovieTitleText] length] > 0) {
        return YES;
    }

    return NO;
}

- (NSString *)getCurrentMovieTitleText {
    return self.movieTitleTextField.text;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if ([[segue identifier] isEqualToString:moviesListSegueIdentifier]) {
        MoviesTableViewController *moviesTableViewController = [segue destinationViewController];
        moviesTableViewController.movieTitleSearch = [self getCurrentMovieTitleText];
    }
}


@end
