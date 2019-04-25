//
//  UIImageView+Download.h
//  MovieSearch
//
//  Created by Kory Chen on 2019/4/25.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Download)

/**
 A key for imageView to remember the callback key.
 */
@property (nonatomic, copy) NSString *downloadKey;

/**
 A project method for set image with URL. The image will be set wiht placeholder if the image didn't downloaded yet and it is not nil.
 */
- (void)p_setImageWithURL:(NSString *)urlString placeholder:(nullable UIImage *)placeholder;

@end

NS_ASSUME_NONNULL_END
