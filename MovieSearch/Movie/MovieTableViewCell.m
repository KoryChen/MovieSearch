//
//  MovieTableViewCell.m
//  MovieSearch
//
//  Created by Kory Chen on 2019/4/24.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.movieCover];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.des];
        [self setupAutoLayout];
    }
    return self;
}

- (void)setupAutoLayout {
    self.movieCover.translatesAutoresizingMaskIntoConstraints = NO;
    self.title.translatesAutoresizingMaskIntoConstraints = NO;
    self.des.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *bottomConstraint = [self.contentView.bottomAnchor constraintEqualToAnchor:self.movieCover.bottomAnchor];
    bottomConstraint.priority = 900.0;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.movieCover.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [self.movieCover.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        bottomConstraint,
        [self.movieCover.heightAnchor constraintEqualToConstant:200],
        [self.movieCover.widthAnchor constraintEqualToConstant:100]
    ]];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.title.leadingAnchor constraintEqualToAnchor:self.movieCover.trailingAnchor constant:20],
        [self.title.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:50],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.title.trailingAnchor constant:20],
        [self.title.heightAnchor constraintEqualToConstant:20]
    ]];

    [NSLayoutConstraint activateConstraints:@[
        [self.des.leadingAnchor constraintEqualToAnchor:self.title.leadingAnchor],
        [self.des.trailingAnchor constraintEqualToAnchor:self.title.trailingAnchor],
        [self.des.topAnchor constraintEqualToAnchor:self.title.bottomAnchor constant:10],
        [self.des.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-30]
    ]];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.imageView.image = nil;
    self.title.text = @"";
    self.des.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Properties

- (UIImageView *)movieCover {
    if (!_movieCover) {
        _movieCover = [[UIImageView alloc] initWithFrame:CGRectZero];
        _movieCover.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _movieCover;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        _title.textColor = [UIColor blackColor];
    }
    return _title;
}

- (UILabel *)des {
    if (!_des) {
        _des = [[UILabel alloc] initWithFrame:CGRectZero];
        _des.textColor = [UIColor blackColor];
        _des.numberOfLines = 0;
        _des.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _des;
}

@end
