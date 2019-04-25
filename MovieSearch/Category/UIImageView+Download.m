//
//  UIImageView+Download.m
//  MovieSearch
//
//  Created by Kory Chen on 2019/4/25.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import "UIImageView+Download.h"
#import "ImageCacheManager.h"
#import <objc/runtime.h>

@implementation UIImageView (Download)

- (void)p_setImageWithURL:(NSString *)urlString placeholder:(UIImage *)placeholder {
    UIImage *cacheImage = [[ImageCacheManager shared] cacheImageWithURLString:urlString];
    if (cacheImage) {
        self.image = cacheImage;
        return;
    }
    self.downloadKey = urlString;
    
    self.image = placeholder;
    [[ImageCacheManager shared] downloadImageWithURL:urlString completion:^(UIImage * _Nullable downloadedImage, NSError * _Nullable error) {
        // Try to prevent the reusable imageview to be set incorrect image.
        if (![self.downloadKey isEqualToString:urlString]) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                return;
            }
            self.image = downloadedImage;
        });
    }];
}

- (NSString *)downloadKey {
    return (NSString *)objc_getAssociatedObject(self, @selector(downloadKey));
}

- (void)setDownloadKey:(NSString *)downloadKey {
    objc_setAssociatedObject(self, @selector(downloadKey), downloadKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
