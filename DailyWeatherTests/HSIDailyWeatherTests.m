//
//  HSIDailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Kenny on 6/11/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HSIDailyForecast.h"
#import "LSIFileHelper.h"
#import "LSILog.h"

@interface HSIDailyWeatherTests : XCTestCase

@end

@implementation HSIDailyWeatherTests

- (void)testDailyWeatherParses {

    NSData *dailyWeatherData = loadFile(@"DailyWeather.json", [HSIDailyWeatherTests class]);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dailyWeatherData options:0 error:&error];
    if (error) {
        XCTFail(@"Error decoding JSON: %@", error);
    }

    XCTAssertNotNil(json);

    HSIDailyForecast *forecast = [[HSIDailyForecast alloc] initWithDictionary:json];
    XCTAssertNotNil(forecast);

    NSDate *time = [[NSDate alloc] initWithTimeIntervalSince1970:1580976000];
    NSDate *sunriseTime = [[NSDate alloc] initWithTimeIntervalSince1970:1581001860];
    NSDate *sunsetTime = [[NSDate alloc] initWithTimeIntervalSince1970:1581039540];

    XCTAssertEqual(time, forecast.time);
    XCTAssertTrue([forecast.summary isEqualToString:@"Clear throughout the day."]);
    XCTAssertTrue([forecast.icon isEqualToString:@"clear-day"]);
    XCTAssertEqual(sunriseTime, forecast.sunriseTime);
    XCTAssertEqual(sunsetTime, forecast.sunsetTime);
    XCTAssertEqualWithAccuracy(forecast.precipIntensity, 0.0006, 0.001);
    XCTAssertEqualWithAccuracy(forecast.precipProbability, 0.13, 0.001);
    XCTAssertEqualWithAccuracy(forecast.temperatureLow, 47.02, 0.001);
    XCTAssertEqualWithAccuracy(forecast.temperatureHigh, 61.22, 0.001);
    //TODO: Refactor/re-examine requirements for apparentTemperature

    XCTAssertEqualWithAccuracy(forecast.humidity, 0.78, 0.001);
    XCTAssertEqualWithAccuracy(forecast.pressure, 1021.8, 0.001);
    XCTAssertEqualWithAccuracy(forecast.windSpeed, 3.82, 0.001);
    XCTAssertEqualWithAccuracy(forecast.windBearing, 320, 0.001);
    XCTAssertEqualWithAccuracy(forecast.uvIndex, 4, 0.001);

}

@end
