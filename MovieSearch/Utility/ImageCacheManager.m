//
//  ImageCacheManager.m
//  MovieSearch
//
//  Created by Kory Chen on 2019/4/25.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import "ImageCacheManager.h"
@interface ImageCacheManager ()
@property (nonatomic, strong) NSMutableDictionary <NSString *, UIImage *> *imageCache;
@property (nonatomic, strong) dispatch_queue_t concurrentQueue;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableArray <NSString *> *processURLs;
@end

@implementation ImageCacheManager

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static ImageCacheManager *shared;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init {
    if (self = [super init]) {
        _imageCache = [[NSMutableDictionary alloc] init];
        // create a custom queue with concurrent for read and write data.
        _concurrentQueue = dispatch_queue_create("com.chihyen.moviesearch.imagedownload", DISPATCH_QUEUE_CONCURRENT);
        _processURLs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)downloadImageWithURL:(NSString *)urlString completion:(void (^)(UIImage * _Nullable, NSError * _Nullable))completion {
    if (urlString.length == 0) {
        NSError *error = [NSError errorWithDomain:@"com.chihyen.download.error" code:0 userInfo:nil];
        completion(nil, error);
        return;
    }
    
        if ([self.processURLs containsObject:urlString]) {
            return;
        }
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            [self.processURLs removeObject:urlString];
            if (error) {
                completion(nil, error);
                return;
            }
            
            UIImage *downloadImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            //create a barrier to make sure the data is correct.
            dispatch_barrier_async(self.concurrentQueue, ^{
                self.imageCache[urlString] = downloadImage;
            });
            completion(downloadImage, nil);
        }];
        [downloadTask resume];
        [self.processURLs addObject:urlString];
    
}

#pragma mark - Public Methods

- (UIImage *)cacheImageWithURLString:(NSString *)urlString {
    __block UIImage *cacheImage;
    //using concurrent queue to read the data.
    dispatch_sync(self.concurrentQueue, ^{
        cacheImage = self.imageCache[urlString];
    });
    return cacheImage;
}

#pragma mark - Properties

- (NSURLSession *)session {
    if (!_session) {
        _session = [NSURLSession sharedSession];
    }
    return _session;
}

@end
