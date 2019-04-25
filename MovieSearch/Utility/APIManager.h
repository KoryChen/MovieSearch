//
//  APIManager.h
//  MovieSearch
//
//  Created by Kory Chen on 2019/4/25.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

- (void)httpGetRequestWithURLString:(NSString *)urlString completion:(void(^)(NSDictionary * _Nullable , BOOL))competion;

- (void)cancelCurrentTask;

@end

NS_ASSUME_NONNULL_END
