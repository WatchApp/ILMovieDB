// MoviesViewController.m
//
// Copyright (c) 2013 Gustavo Leguizamon (http://goopi.me)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIImageView+AFNetworking.h"

#import "MoviesViewController.h"
#import "ILMovieDBClient.h"

@interface MoviesViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, copy) NSString *imagesBaseUrlString;

@end

@implementation MoviesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (!self) {
        return nil;
    }

    __weak MoviesViewController *weakSelf = self;
    [[ILMovieDBClient sharedClient] GET:kILMovieDBConfiguration parameters:nil block:^(id responseObject, NSError *error) {
        if (!error) {
            weakSelf.imagesBaseUrlString = [responseObject[@"images"][@"base_url"] stringByAppendingString:@"w185"];
        }
    }];

    return self;
}

- (void)reload:(id)sender {
    [self.activityIndicatorView startAnimating];
    self.navigationItem.rightBarButtonItem.enabled = NO;

    __weak MoviesViewController *weakSelf = self;
    [[ILMovieDBClient sharedClient] GET:kILMovieDBMovieTheatres parameters:nil block:^(id responseObject, NSError *error) {
        if (!error) {
            weakSelf.movies = responseObject[@"results"];
            [weakSelf.tableView reloadData];
        }

        weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
        [weakSelf.activityIndicatorView stopAnimating];
    }];
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];

    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityIndicatorView.hidesWhenStopped = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Movies", nil);

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicatorView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];

    self.tableView.rowHeight = 140.f;

    [self reload:nil];
}

- (void)viewDidUnload {
    self.activityIndicatorView = nil;

    [super viewDidUnload];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.userInteractionEnabled = NO;

    NSDictionary *movie = self.movies[indexPath.row];

    cell.textLabel.text = movie[@"original_title"];
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    if (movie[@"poster_path"] != [NSNull null]) {
        NSString *posterUrlString = [self.imagesBaseUrlString stringByAppendingString:movie[@"poster_path"]];
        [cell.imageView setImageWithURL:[NSURL URLWithString:posterUrlString] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end