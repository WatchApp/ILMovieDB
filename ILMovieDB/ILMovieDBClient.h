// ILMovieDBClient.h
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

#import "AFHTTPRequestOperationManager.h"

typedef void (^ILMovieDBClientResponseBlock)(id responseObject, NSError *error);

@interface ILMovieDBClient : AFHTTPRequestOperationManager

@property (nonatomic, copy) NSString *apiKey;

/**
 Creates and returns an `ILMovieDBClient` object.
 */
+ (instancetype)sharedClient;

#pragma mark - Requests

/**
 Creates and runs an `AFHTTPRequestOperation` with a `GET` request.

 @param path The resource path used to create the request URL.
 @param parameters The parameters to be encoded by `AFJSONRequestSerializer`.
 @param success A block object to be executed when the request operation finishes successfully or unsuccessfully.
 */
- (AFHTTPRequestOperation *)GET:(NSString *)path parameters:(NSDictionary *)parameters block:(ILMovieDBClientResponseBlock)block;

///-------------------------
/// @name API Resources Path
///-------------------------

extern NSString * const kILMovieDBConfiguration;
extern NSString * const kILMovieDBPerson;
extern NSString * const kILMovieDBPersonSearch;
extern NSString * const kILMovieDBMovieSearch;
extern NSString * const kILMovieDBMovie;
extern NSString * const kILMovieDBMovieSimilar;
extern NSString * const kILMovieDBMovieCasts;
extern NSString * const kILMovieDBMovieImages;
extern NSString * const kILMovieDBMovieTrailers;
extern NSString * const kILMovieDBMovieUpcoming;
extern NSString * const kILMovieDBMovieTheatres;
extern NSString * const kILMovieDBMovieTopRated;
extern NSString * const kILMovieDBGenreList;
extern NSString * const kILMovieDBGenreMovies;

@end