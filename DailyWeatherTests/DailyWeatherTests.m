//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIWeatherForcast.h"
#import "LSIFileHelper.h"
#import "LSIDailyForecast.h"


@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testExample {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    
    // TODO: Create Unit Tests for each separate JSON file

}

- (void)testLoadingDailyWeather {

    NSData *data = loadFile(@"DailyWeather.json", [LSIDailyForecast class]);
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"Error with JSON,error: %@", jsonError);
    }
    NSLog(@"JSON: %@", json);
    
}
- (void)testLoadingCurrentWeather {

    NSData *data = loadFile(@"CurrentWeather.json", [LSIWeatherForcast class]);
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"Theres an error parssing: %@", jsonError);
    }
    NSLog(@"THE JSON: %@", json);
    
}

@end
