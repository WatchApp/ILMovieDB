// ILMovieDBClient.m
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

#import "AFJSONRequestOperation.h"
#import "ILMovieDBClient.h"

static NSString * const kILTMDbAPIBaseURLString = @"http://api.themoviedb.org/3/";

NSString * const kILTMDbAPIConfigurationPathString = @"configuration";
NSString * const kILTMDbAPIGenreListPathString = @"genre/list";
NSString * const kILTMDbAPIGenreMoviesPathString = @"genre/:id/movies";
NSString * const kILTMDbAPIMovieSearchPathString = @"search/movie";
NSString * const kILTMDbAPIMoviePathString = @"movie/:id";
NSString * const kILTMDbAPIMovieCastsPathString = @"movie/:id/casts";
NSString * const kILTMDbAPIMovieImagesPathString = @"movie/:id/images";
NSString * const kILTMDbAPIMovieTrailersPathString = @"movie/:id/trailers";
NSString * const kILTMDbAPIMovieSimilarPathString = @"movie/:id/similar_movies";
NSString * const kILTMDbAPIMovieUpcomingPathString = @"movie/upcoming";
NSString * const kILTMDbAPIMovieTheatresPathString = @"movie/now_playing";
NSString * const kILTMDbAPIMovieTopRatedPathString = @"movie/top_rated";
NSString * const kILTMDbAPIPersonPathString = @"person/:id";
NSString * const kILTMDbAPIPersonSearchPathString = @"search/person";

@implementation ILMovieDBClient

+ (ILMovieDBClient *)sharedClient {
    static ILMovieDBClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kILTMDbAPIBaseURLString]];
    });

    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }

    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];

    return self;
}

#pragma mark - HTTP Requests

- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters block:(ILTMDbAPIClientResponseBlock)block {
    NSParameterAssert(self.apiKey);
    NSMutableDictionary *params = parameters ? [parameters mutableCopy] : [@{} mutableCopy];
    params[@"api_key"] = self.apiKey;

    if ([path rangeOfString:@":id"].location != NSNotFound) {
        NSParameterAssert(parameters[@"id"]);
        path = [path stringByReplacingOccurrencesOfString:@":id" withString:parameters[@"id"]];
    }

    [super getPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

@end