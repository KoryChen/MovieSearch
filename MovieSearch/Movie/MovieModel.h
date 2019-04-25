//
//  MovieModel.h
//  MovieSearch
//
//  Created by Kory Chen on 2019/4/25.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieModel : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, strong, nullable, readonly) NSString *imageURLString;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
