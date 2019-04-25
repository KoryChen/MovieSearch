//
//  MovieSearchViewModel.m
//  MovieSearch
//
//  Created by Kory Chen on 2019/4/24.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import "MovieSearchViewModel.h"
#import "APIManager.h"

static NSString * const kMovieAPI = @"https://api.themoviedb.org/3/search/movie";
static NSString * const kAPIKey = @"2a61185ef6a27f400fd92820ad9e8537";

@interface MovieSearchViewModel ()

@property (nonatomic, strong) APIManager *apiManager;
@property (nonatomic, strong) NSMutableArray *models;

@end

@implementation MovieSearchViewModel

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)cleanupSearch {
    self.models = [NSMutableArray new];
    if ([self.delegate respondsToSelector:@selector(viewModelDidChangeModels:)]) {
        [self.delegate viewModelDidChangeModels:self];
    }
}

- (void)searchMovieWithInput:(NSString *)input {
    NSString *url = [NSString stringWithFormat:@"%@?api_key=%@&query=%@", kMovieAPI, kAPIKey, input];
    //convert the request url as pasre-able for api.
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    __weak typeof(self) weakSelf = self;
    [self.apiManager cancelCurrentTask];
    [self.apiManager httpGetRequestWithURLString:url completion:^(NSDictionary * _Nullable dictionary, BOOL success) {
        __strong typeof(weakSelf) self = weakSelf;
        if (success) {
            self.models = [[self handleResposneDataWithDictionary:dictionary] mutableCopy];
            if ([self.delegate respondsToSelector:@selector(viewModelDidChangeModels:)]) {
                //switch to main thread when invokde delegate method.
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate viewModelDidChangeModels:self];
                });
            }
            
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(viewModelDidFailToFetchData:)]) {
                [self.delegate viewModelDidFailToFetchData:self];
            }
        });
    }];
}

- (NSInteger)numberOfModels {
    return self.models.count;
}

- (MovieModel *)modelAtRow:(NSInteger)row {
    return self.models[row];
}

#pragma mark - Private Method

- (NSArray <MovieModel *> *)handleResposneDataWithDictionary:(NSDictionary *)dictionary {
    NSArray *results = dictionary[@"results"];
    if (results && [results isKindOfClass:[NSArray class]]) {
        NSMutableArray *newModels = [[NSMutableArray alloc] initWithCapacity:results.count];
        for (NSDictionary *content in results) {
            [newModels addObject:[self convertModelFromDictionary:content]];
        }
        
        return [newModels copy];
    }
    return @[];
}

- (MovieModel *)convertModelFromDictionary:(NSDictionary *)dictionary {
    return [[MovieModel alloc] initWithDictionary:dictionary];
}

#pragma mark - Properties

- (NSArray<MovieModel *> *)models {
    if (!_models) {
        _models = [[NSMutableArray alloc] init];
    }
    return [_models copy];
}

- (APIManager *)apiManager {
    if (!_apiManager) {
        _apiManager = [[APIManager alloc] init];
    }
    return _apiManager;
}

@end
