//
//  MovieTableViewCell.h
//  MovieSearch
//
//  Created by Kory Chen on 2019/4/24.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *movieCover;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *des;

@end

NS_ASSUME_NONNULL_END
