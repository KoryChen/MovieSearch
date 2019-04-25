//
//  MovieSearchViewController.m
//  MovieSearch
//
//  Created by Kory Chen on 2019/4/24.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import "MovieSearchViewController.h"
#import "MovieSearchViewModel.h"
#import "MovieTableViewCell.h"
#import "UIImageView+Download.h"

static NSString * const kCellIdentifier = @"movieCell";

@interface MovieSearchViewController () <MovieSearchViewModelDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) MovieSearchViewModel *viewModel;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MovieSearchViewController

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.logo];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    
    [self setupAutoLayout];
}

- (void)setupAutoLayout {
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    self.logo.translatesAutoresizingMaskIntoConstraints = NO;
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.topView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.topView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.topView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.topView.heightAnchor constraintEqualToConstant:60]
    ]];
    [NSLayoutConstraint activateConstraints:@[
        [self.logo.centerXAnchor constraintEqualToAnchor:self.topView.centerXAnchor],
        [self.logo.centerYAnchor constraintEqualToAnchor:self.topView.centerYAnchor],
        [self.logo.heightAnchor constraintEqualToConstant:40],
        [self.logo.widthAnchor constraintEqualToConstant:50]
    ]];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.searchBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.searchBar.topAnchor constraintEqualToAnchor:self.topView.bottomAnchor],
        [self.searchBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.searchBar.heightAnchor constraintEqualToConstant:50]
    ]];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.searchBar.bottomAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfModels;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieModel *model = [self.viewModel modelAtRow:indexPath.row];
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    cell.title.text = model.title;
    cell.des.text = model.overview;
    [cell.movieCover p_setImageWithURL:model.imageURLString placeholder:[UIImage imageNamed:@"placeholder"]];
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        [self.viewModel cleanupSearch];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
     [self.viewModel searchMovieWithInput:[searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

#pragma mark - MovieSearchViewModelDelegate

- (void)viewModelDidChangeModels:(MovieSearchViewModel *)viewModel {
    [self.tableView reloadData];
}

- (void)viewModelDidFailToFetchData:(MovieSearchViewModel *)viewModel {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Fetching failure." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Propertise

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor colorWithRed:29/255.0 green:202/255.0 blue:255/255.0 alpha:1];
    }
    return _topView;
}

- (UIImageView *)logo {
    if (!_logo) {
        _logo = [[UIImageView alloc] initWithFrame:CGRectZero];
        _logo.image = [[UIImage imageNamed:@"logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _logo.contentMode = UIViewContentModeScaleAspectFit;
        _logo.tintColor = [UIColor colorWithRed:192/255.0 green:222/255.0 blue:237/255.0 alpha:1];
    }
    return _logo;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"search for moives";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[MovieTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

- (MovieSearchViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MovieSearchViewModel alloc] init];
        _viewModel.delegate = self;
    }
    return _viewModel;
}

@end
