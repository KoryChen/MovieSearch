//
//  APIManager.m
//  MovieSearch
//
//  Created by Kory Chen on 2019/4/25.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import "APIManager.h"

@interface APIManager ()

@property (nonatomic, strong) NSURLSessionTask *currentTask;

@end

@implementation APIManager


- (void)httpGetRequestWithURLString:(NSString *)urlString completion:(void (^)(NSDictionary *, BOOL))competion {
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    self.currentTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error || !data) {
            competion(nil, NO);
            return;
        }
        
        // to convert the response data to JSON structure.
        NSError *jsonError;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        if(jsonDictionary) {
            competion(jsonDictionary, YES);
        } else {
            competion(nil, NO);
        }
    }];
    [self.currentTask resume];
}

/**
 Cancel the previous task if it is ongoing.
 */
- (void)cancelCurrentTask {
    [self.currentTask cancel];
}

@end
