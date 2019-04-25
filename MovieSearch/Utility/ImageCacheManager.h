//
//  ImageCacheManager.h
//  MovieSearch
//
//  Created by Kory Chen on 2019/4/25.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import  <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageCacheManager : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)shared;

- (nullable UIImage *)cacheImageWithURLString:(NSString *)urlString;

- (void)downloadImageWithURL:(NSString *)urlString completion:(void(^)(UIImage * _Nullable, NSError * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
