//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "LSIWeatherForcast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testLoadingCurrentWeather {

    NSData *data = loadFile(@"CurrentWeather.json", [LSIWeatherForcast class]);
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }
    NSLog(@"JSON: %@", json);
    
}

- (void)testLoadingDailyWeather {

    NSData *data = loadFile(@"DailyWeather.json", [LSIDailyForecast class]);
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }
    NSLog(@"JSON: %@", json);
    
}

- (void)testLoadingHourlyWeather {

    NSData *data = loadFile(@"HourlyWeather.json", [LSIHourlyForecast class]);
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }
    NSLog(@"JSON: %@", json);
    
}

// TODO: Create Unit Tests for each separate JSON file

@end
