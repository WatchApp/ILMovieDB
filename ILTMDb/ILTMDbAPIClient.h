//
// ILTMDbAPIClient.h
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

#import "AFHTTPClient.h"

typedef void (^ILTMDbAPIClientResponseBlock)(id responseData, NSError *error);

@interface ILTMDbAPIClient : AFHTTPClient

@property (nonatomic, copy) NSString *apiKey;

+ (ILTMDbAPIClient *)sharedClient;
- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters block:(ILTMDbAPIClientResponseBlock)block;

///-------------------------
/// @name API Resources Path
///-------------------------

extern NSString * const kILTMDbAPIConfigurationPathString;
extern NSString * const kILTMDbAPIPersonPathString;
extern NSString * const kILTMDbAPIPersonSearchPathString;
extern NSString * const kILTMDbAPIMovieSearchPathString;
extern NSString * const kILTMDbAPIMoviePathString;
extern NSString * const kILTMDbAPIMovieSimilarPathString;
extern NSString * const kILTMDbAPIMovieCastsPathString;
extern NSString * const kILTMDbAPIMovieImagesPathString;
extern NSString * const kILTMDbAPIMovieTrailersPathString;
extern NSString * const kILTMDbAPIMovieUpcomingPathString;
extern NSString * const kILTMDbAPIMovieTheatresPathString;
extern NSString * const kILTMDbAPIMovieTopRatedPathString;
extern NSString * const kILTMDbAPIGenreListPathString;
extern NSString * const kILTMDbAPIGenreMoviesPathString;

@end