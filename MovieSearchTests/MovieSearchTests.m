//
//  MovieSearchTests.m
//  MovieSearchTests
//
//  Created by Kory Chen on 2019/4/24.
//  Copyright © 2019 Kory Chen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MovieModel.h"
#import "MovieSearchViewModel.h"
@interface MovieSearchTests : XCTestCase
@property (nonatomic, strong) MovieSearchViewModel *viewModel;

@end

@implementation MovieSearchTests

- (void)setUp {
    self.viewModel = [[MovieSearchViewModel alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testCompletedResponseData {
    NSString *completedResponse = @"{\
    \"page\": 1,\
    \"total_results\": 20964,\
    \"total_pages\": 1049,\
    \"results\": [\
                {\
                    \"vote_count\": 581,\
                    \"id\": 460885,\
                    \"video\": false,\
                    \"vote_average\": 6.2,\
                    \"title\": \"Mandy\",\
                    \"popularity\": 44.6,\
                    \"poster_path\": \"/m0yf7J7HsKeK6E81SMRcX8vx6mH.jpg\",\
                    \"original_language\": \"en\",\
                    \"original_title\": \"Mandy\",\
                    \"genre_ids\": [28,53,27,14,9648],\
                    \"backdrop_path\": \"/tNa19CK0CQZl5rxZ35QRdKAT2s0.jpg\",\
                    \"adult\": false,\
                    \"overview\": \"The Shadow Mountains, 1983. Red and Mandy lead a loving and peaceful existence; but when their pine-scented haven is savagely destroyed, Red is catapulted into a phantasmagoric journey filled with bloody vengeance and laced with fire.\",\
                    \"release_date\": \"2018-09-13\"\
                }\
                ]\
    }";
    NSData *data = [completedResponse dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSArray *array = [self.viewModel handleResposneDataWithDictionary:response];
    
    XCTAssertTrue(array.count > 0, @"");
}

- (void)testIncorrectResponseData {
    NSString *completedResponse = @"{\
    \"page\": 1,\
    \"total_results\": 20964,\
    \"total_pages\": 1049,\
    }";
    NSData *data = [completedResponse dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSArray *array = [self.viewModel handleResposneDataWithDictionary:response];
    
    XCTAssertTrue(array.count == 0, @"");
    
    NSString *completedResponse2 = @"{\
    \"page\": 1,\
    \"total_results\": 20964,\
    \"total_pages\": 1049,\
    \"resultssss\": []\
    }";
    
    NSData *data2 = [completedResponse2 dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *response2 = [NSJSONSerialization JSONObjectWithData:data2 options:0 error:NULL];
    NSArray *array = [self.viewModel handleResposneDataWithDictionary:response2];
    
    XCTAssertTrue(array.count == 0, @"");
}

- (void)testMovieModel {
    NSString *completedResponse = @"\
    {\
    \"vote_count\": 581,\
    \"id\": 460885,\
    \"video\": false,\
    \"vote_average\": 6.2,\
    \"title\": \"Mandy\",\
    \"popularity\": 44.6,\
    \"poster_path\": \"/m0yf7J7HsKeK6E81SMRcX8vx6mH.jpg\",\
    \"original_language\": \"en\",\
    \"original_title\": \"Mandy\",\
    \"genre_ids\": [28,53,27,14,9648],\
    \"backdrop_path\": \"/tNa19CK0CQZl5rxZ35QRdKAT2s0.jpg\",\
    \"adult\": false,\
    \"overview\": \"The Shadow Mountains, 1983. Red and Mandy lead a loving and peaceful existence; but when their pine-scented haven is savagely destroyed, Red is catapulted into a phantasmagoric journey filled with bloody vengeance and laced with fire.\",\
    \"release_date\": \"2018-09-13\"\
    }";
    NSData *data = [completedResponse dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];

    MovieModel *model = [[MovieModel alloc] initWithDictionary:response];
    
    XCTAssertNotNil(model);
    XCTAssertNotNil(model.imageURLString);
    XCTAssertNotNil(model.title);
    XCTAssertNotNil(model.overview);
    
    response[@"poster_path"] = nil;
    model = [[MovieModel alloc] initWithDictionary:response];
    XCTAssertNil(model.imageURLString);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
