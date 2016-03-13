//
//  MoviesTableViewController.m
//  MovieSearch
//
//  Created by Adriana Pineda on 3/13/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

#import "MoviesTableViewController.h"
#import "Movie.h"
#import "MovieDetailViewController.h"
#import <AFNetworking/AFNetworking.h>

#define MOVIES_RESULT_KEY @"Search"

@interface MoviesTableViewController ()

@property (nonatomic, strong) NSArray *movies;
@end

@implementation MoviesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self downloadMovies];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Download movies
- (void)downloadMovies {

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *url = [NSURL URLWithString:@"https://www.omdbapi.com?s=harry"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id  responseObject, NSError * error) {

        if (error) {
            NSLog(@"ERROR");
        } else {

            NSMutableArray *movies = [[NSMutableArray alloc] init];
            NSDictionary *moviesDictionary = [responseObject objectForKey:MOVIES_RESULT_KEY];
            for (NSDictionary *movieDic in moviesDictionary) {
                Movie *currentMovie = [[Movie alloc] initWithDictionary:movieDic];
                [movies addObject:currentMovie];
            }

            self.movies = movies;

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });

        }
    }];
    [dataTask resume];
}

- (NSUInteger)numberOfMovies {
    return self.movies.count;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSUInteger numberOfMovies = [self numberOfMovies];
    if (numberOfMovies > 0) {
        return numberOfMovies;
    }

    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movie" forIndexPath:indexPath];

    if ([self numberOfMovies] > 0) {
        Movie *currentMovie = [self.movies objectAtIndex:indexPath.row];
        if (currentMovie) {
            cell.textLabel.text = currentMovie.title;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%li", currentMovie.year];
        }
    } else {
        cell.textLabel.text = @"No movies found";
    }


    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showMovie"]) {

        NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
        Movie *selectedMovie = [self.movies objectAtIndex:selectedRowIndexPath.row];

        if (selectedMovie) {
            MovieDetailViewController *nextViewController = [segue destinationViewController];
            [nextViewController setSelectedMovie:selectedMovie];
        }
    }

}


@end
