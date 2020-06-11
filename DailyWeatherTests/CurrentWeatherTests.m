//
//  DailyWeatherTests.m
//  CurrentWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HSIWeatherForecast.h"
#import "LSIFileHelper.h"
#import "LSILog.h"

@interface CurrentWeatherTests : XCTestCase

@end

@implementation CurrentWeatherTests
///test Lambda API
- (void)testCurrentWeatherParses {
    NSData *dailyWeatherData = loadFile(@"Weather.json", [CurrentWeatherTests class]);
    NSLog(@"NSData: %@", dailyWeatherData);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dailyWeatherData options:0 error:&error];
    if (error) {
        XCTFail(@"Error decoding JSON: %@", error);
    }
    NSLog(@"JSON: %@", json);
    XCTAssertNotNil(json);
    NSDictionary *currentWeather = json[@"currently"];
    XCTAssertNotNil(currentWeather);
}

- (void)testCurrentWeather {

    NSData *dailyWeatherData = loadFile(@"Weather.json", [CurrentWeatherTests class]);
    NSLog(@"NSData: %@", dailyWeatherData);

    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dailyWeatherData options:0 error:&error];
    if (error) {
        XCTFail(@"Error decoding JSON: %@", error);
    }
    NSLog(@"JSON: %@", json);
    XCTAssertNotNil(json);

    NSDictionary *currentWeather = json[@"currently"];
    XCTAssertNotNil(currentWeather);

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];

    HSICurrentForecast *forecast = [[HSICurrentForecast alloc] initWithDictionary:currentWeather];
    XCTAssertNotNil(forecast);

    XCTAssertEqual(time, forecast.time);
    XCTAssertTrue([forecast.summary isEqualToString: @"Clear"]);
    XCTAssertTrue([forecast.icon isEqualToString: @"clear-day"]);
    XCTAssertEqual(forecast.precipIntensity, 0.0);
    XCTAssertEqual(forecast.precipProbability, 0.0);
    XCTAssertEqual(forecast.temperature, 48.35);
    XCTAssertEqual(forecast.apparentTemperature, 47.4);
    XCTAssertEqual(forecast.humidity, 0.77);
    XCTAssertEqual(forecast.pressure, 1023.2);
    XCTAssertEqual(forecast.windSpeed, 3.45);
    XCTAssertEqual(forecast.windBearing, 24);
}


@end
