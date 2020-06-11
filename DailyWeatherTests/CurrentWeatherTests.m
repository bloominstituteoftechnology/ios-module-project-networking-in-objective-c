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

- (void)testCurrentWeather {

    NSData *currentWeatherData = loadFile(@"CurrentWeather.json", [CurrentWeatherTests class]);
    NSLog(@"NSData: %@", currentWeatherData);

    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:0 error:&error];
    if (error) {
        XCTFail(@"Error decoding JSON: %@", error);
    }
    NSLog(@"JSON: %@", json);
    XCTAssertNotNil(json);

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];

    HSICurrentForecast *forecast = [[HSICurrentForecast alloc] initWithDictionary:json];
    XCTAssertNotNil(forecast);

    XCTAssertEqual(time, forecast.time);
    XCTAssertTrue([forecast.summary isEqualToString: @"Clear"]);
    XCTAssertTrue([forecast.icon isEqualToString: @"clear-day"]);
    XCTAssertEqualWithAccuracy(forecast.precipIntensity, 0.0, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.precipProbability, 0.0, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.temperature, 48.35, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.apparentTemperature, 47.4, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.humidity, 0.77, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.pressure, 1023.2, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.windSpeed, 3.45, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.windBearing, 24, 0.0001);
}


@end
