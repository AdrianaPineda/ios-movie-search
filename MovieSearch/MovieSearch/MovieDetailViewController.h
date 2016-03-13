//
//  MovieDetailViewController.h
//  MovieSearch
//
//  Created by Adriana Pineda on 3/13/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;

- (void)setSelectedMovie:(Movie *)movie;
@end
