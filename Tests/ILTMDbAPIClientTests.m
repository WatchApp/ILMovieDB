//
// ILTMDbAPIClientTests.m
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

#import "ILTMDbAPIClient.h"
#import "ILTMDbTests.h"

@interface ILTMDbAPIClientTests : SenTestCase
@property (nonatomic, strong) ILTMDbAPIClient *client;
@end

@implementation ILTMDbAPIClientTests

- (void)setUp {
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"ILTMDb-Api" ofType:@"plist"];
    self.client = [ILTMDbAPIClient sharedClient];
    self.client.apiKey = [NSDictionary dictionaryWithContentsOfFile:path][@"TMDbApiKey"];
}

#pragma mark -

- (void)testGetPath {
    [Expecta setAsynchronousTestTimeout:2.0];

    __block id callbackData = nil;

    [self.client getPath:kILTMDbAPIConfigurationPathString parameters:nil block:^(id responseData, NSError *error) {
        callbackData = responseData;
    }];

    expect(callbackData).willNot.beNil();
    expect(callbackData).will.beKindOf([NSDictionary class]);
}

- (void)testGetPathWithParams {
    [Expecta setAsynchronousTestTimeout:2.0];

    NSDictionary *params;
    __block id firstCallbackData = nil;
    __block id secondCallbackData = nil;

    params = @{@"id": @"500"};
    [self.client getPath:kILTMDbAPIMoviePathString parameters:params block:^(id responseData, NSError *error) {
        firstCallbackData = responseData;
    }];

    params = @{@"query": @"The Godfather"};
    [self.client getPath:kILTMDbAPIMovieSearchPathString parameters:params block:^(id responseData, NSError *error) {
        secondCallbackData = responseData;
    }];

    expect(firstCallbackData).willNot.beNil();
    expect(firstCallbackData).will.beKindOf([NSDictionary class]);
    expect(secondCallbackData).willNot.beNil();
    expect(secondCallbackData).will.beKindOf([NSDictionary class]);
    expect(secondCallbackData[@"results"]).will.beKindOf([NSArray class]);
}

- (void)testGetPathFail {
    __block id callbackError = nil;

    [self.client getPath:@"path" parameters:nil block:^(id responseData, NSError *error) {
        callbackError = error;
    }];

    expect(callbackError).willNot.beNil();
    expect(callbackError).will.beKindOf([NSError class]);
}

@end