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
        NSLog(@"Theres an error parssing: %@", jsonError);
    }
    NSLog(@"THE JSON: %@", json);
    
}

- (void)testLoadingDailyWeather {

    NSData *data = loadFile(@"DailyWeather.json", [LSIDailyForecast class]);
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"Didn't find any JSON, error: %@", jsonError);
    }
    NSLog(@"THE JSON: %@", json);
    
}

- (void)testLoadingHourlyWeather {

    NSData *data = loadFile(@"HourlyWeather.json", [LSIHourlyForecast class]);
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"No JSON parsed, error: %@", jsonError);
    }
    NSLog(@"THE JSON: %@", json);
    
}

@end
