//
//  MovieSearchViewModel.h
//  MovieSearch
//
//  Created by Kory Chen on 2019/4/24.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieModel.h"
@class MovieSearchViewModel;

NS_ASSUME_NONNULL_BEGIN

@protocol MovieSearchViewModelDelegate <NSObject>

- (void)viewModelDidChangeModels:(MovieSearchViewModel *)viewModel;

- (void)viewModelDidFailToFetchData:(MovieSearchViewModel *)viewModel;

@end

@interface MovieSearchViewModel : NSObject

@property (nonatomic, weak, nullable) id<MovieSearchViewModelDelegate> delegate;

- (void)cleanupSearch;
- (void)searchMovieWithInput:(NSString *)input;

- (NSArray *)handleResposneDataWithDictionary:(NSDictionary *)dictionary;
- (MovieModel *)convertModelFromDictionary:(NSDictionary *)dictionary;

- (NSInteger)numberOfModels;
- (MovieModel *)modelAtRow:(NSInteger)row;

@end

NS_ASSUME_NONNULL_END
