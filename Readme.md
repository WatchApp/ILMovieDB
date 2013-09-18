# ILTMDb

ILTMDb is a iOS library for interact with themoviedb.org API v3.

## Usage

```objective-c
[ILTMDbAPIClient sharedClient].apiKey = @"YOUR_API_KEY";
[[ILTMDbAPIClient sharedClient] getPath:kILTMDbAPIMovieTheatresPathString parameters:nil block:^(id responseData, NSError *error) {
    if (!error) {
        NSLog(@"%@", responseData);
    }
}];
```

### With Parameters

```objective-c
NSDictionary *params = @{@"id": @"500"};
[[ILTMDbAPIClient sharedClient] getPath:kILTMDbAPIMoviePathString parameters:params block:^(id responseData, NSError *error) {
    if (!error) {
        NSLog(@"%@", responseData);
    }
}];
```

## Available methods

| Resource | API url |
|:-----------:|:------------:|
| kILTMDbAPIConfigurationPathString | configuration |
| kILTMDbAPIGenreListPathString | genre/list |
| kILTMDbAPIGenreMoviesPathString | genre/:id/movies |
| kILTMDbAPIMovieSearchPathString | search/movie |
| kILTMDbAPIMoviePathString | movie/:id |
| kILTMDbAPIMovieCastsPathString | movie/:id/casts |
| kILTMDbAPIMovieImagesPathString | movie/:id/images |
| kILTMDbAPIMovieTrailersPathString | movie/:id/trailers |
| kILTMDbAPIMovieSimilarPathString | movie/:id/similar_movies |
| kILTMDbAPIMovieUpcomingPathString | movie/upcoming |
| kILTMDbAPIMovieTheatresPathString | movie/now_playing |
| kILTMDbAPIMovieTopRatedPathString | movie/top_rated |
| kILTMDbAPIPersonPathString | person/:id |
| kILTMDbAPIPersonSearchPathString | search/person |

## Requirements

ILTMDb requires [iOS 6.0](https://developer.apple.com/library/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS6.html) and above.

### ARC

ILTMDb uses ARC.

## Unit Tests

To run the unit tests, you must install the testing dependencies via CocoaPods. To do so:

    $ gem install cocoapods # If necessary
    $ cd Tests
    $ pod install

Once CocoaPods has finished the installation, you have to set the `TMDbApiKey` key in the "ILTMDb-Api.plist" (for the Example app, use "Info.plist").

Now you can execute the test suite via the 'Tests' scheme within Xcode.

### Using xctool

To execute the tests from the command line, you will need to install [xctool](https://github.com/facebook/xctool).

To install the commandline testing support via Homebrew:

    $ brew install xctool

Once xctool is installed, you can execute the suite via `rake test`.

## License

MIT. See the LICENSE file for more info.
