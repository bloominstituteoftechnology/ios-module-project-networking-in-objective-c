//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "LSIWeatherForecast.h"
#import "LSIDailyForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testCurrentWeatherMock {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    NSData *data = loadFile(@"CurrentWeather.json", [LSIWeatherForecast class]);

    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]; // & = addres of
    // Ooooh so we still use referencing pointers in obj-c. Lit

    if (error) {
        XCTFail(@"Error parsing JSON: %@", json);
    }
    NSLog(@"JSON: %@", json);
    // TODO: Create Unit Tests for each separate JSON file

}

- (void)testDailyWeatherMock {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    NSData *data = loadFile(@"DailyWeather.json", [LSIDailyForecast class]);

    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]; // & = addres of
    // Ooooh so we still use referencing pointers in obj-c. Lit

    if (error) {
        XCTFail(@"Error parsing JSON: %@", json);
    }
    NSLog(@"JSON: %@", json);
    // TODO: Create Unit Tests for each separate JSON file

}

- (void)testHourlyWeatherMock {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    NSData *data = loadFile(@"HourlyWeather.json", [LSIDailyForecast class]);

    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]; // & = addres of
    // Ooooh so we still use referencing pointers in obj-c. Lit

    if (error) {
        XCTFail(@"Error parsing JSON: %@", json);
    }
    NSLog(@"JSON: %@", json);
    // TODO: Create Unit Tests for each separate JSON file

}

@end
