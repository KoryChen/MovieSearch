//
//  MovieModel.m
//  MovieSearch
//
//  Created by Kory Chen on 2019/4/25.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import "MovieModel.h"

@interface MovieModel ()
@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSString *overview;
@property (nonatomic, strong, nullable, readwrite) NSString *imageURLString;
@end

@implementation MovieModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _title = [dictionary[@"title"] copy];
        _overview = [dictionary[@"overview"] copy];
        // if "poster_path" is nil, make the imageURLString as nil also. prevent to create an invalid urlString.
        if (dictionary[@"poster_path"]) {
            _imageURLString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w600_and_h900_bestv2%@", dictionary[@"poster_path"]];
        }
    }
    return self;
}

@end
