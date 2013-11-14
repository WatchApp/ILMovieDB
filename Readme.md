# ILMovieDB

ILMovieDB is a iOS library for interact with themoviedb.org API v3.

## Usage

```objective-c
[ILMovieDBClient sharedClient].apiKey = @"YOUR_API_KEY";
[[ILMovieDBClient sharedClient] getPath:kILTMDbAPIMovieTheatresPathString parameters:nil block:^(id responseData, NSError *error) {
    if (!error) {
        NSLog(@"%@", responseData);
    }
}];
```

### With Parameters

```objective-c
NSDictionary *params = @{@"id": @"500"};
[[ILMovieDBClient sharedClient] getPath:kILTMDbAPIMoviePathString parameters:params block:^(id responseData, NSError *error) {
    if (!error) {
        NSLog(@"%@", responseData);
    }
}];
```

## Available methods

For now, only the `GET` methods are included. See the [Method list](https://github.com/WatchApp/ILMovieDB/blob/master/ILMovieDB/ILMovieDBConstants.h).

## Requirements

ILMovieDB requires [iOS 7.0](https://developer.apple.com/library/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS7.html) and above.

### Dependencies

[AFNetworking](https://github.com/AFNetworking/AFNetworking) 2.0.0 or superior.

### ARC

ILMovieDB uses ARC.

## Unit Tests

To run the unit tests, you must install the testing dependencies via CocoaPods. To do so:

    $ gem install cocoapods # If necessary
    $ cd Tests
    $ pod install

Once CocoaPods has finished the installation, you have to set the `MovieDBApiKey` key in the "ILMovieDB.plist" (for the Example app, use "Info.plist").

Now you can execute the test suite via the 'Tests' scheme within Xcode.

### Using xctool

To execute the tests from the command line, you will need to install [xctool](https://github.com/facebook/xctool).

To install the commandline testing support via Homebrew:

    $ brew install xctool

Once xctool is installed, you can execute the suite via `rake test`.

## Contact

- If you want to get in touch, [send an email](mailto:gustavo@irbislab.com)
- Follow [Me](https://twitter.com/leguizamongus) on Twitter
- [http://goopi.me/](http://goopi.me/)

## License

MIT. See the LICENSE file for more info.
