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

#import "ILMovieDBClient.h"

@implementation ILMovieDBClient

+ (instancetype)sharedClient {
    static ILMovieDBClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if DEBUG
        NSString *baseUrl = kILMovieDBBaseURL;
#else
        NSString *baseUrl = kILMovieDBBaseURLSSL;
#endif
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer new];
    });
    return _sharedClient;
}

#pragma mark - Requests

- (AFHTTPRequestOperation *)GET:(NSString *)path parameters:(NSDictionary *)parameters block:(ILMovieDBClientResponseBlock)block {
    NSParameterAssert(self.apiKey);
    NSParameterAssert(block);

    AFHTTPRequestOperation *requestOperation;
    NSMutableDictionary *params = parameters ? [parameters mutableCopy] : [NSMutableDictionary new];
    params[@"api_key"] = self.apiKey;

    if ([path rangeOfString:@":id"].location != NSNotFound) {
        NSParameterAssert(parameters[@"id"]);
        path = [path stringByReplacingOccurrencesOfString:@":id" withString:parameters[@"id"]];
    }

    requestOperation = [self GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];

    return requestOperation;
}

@end