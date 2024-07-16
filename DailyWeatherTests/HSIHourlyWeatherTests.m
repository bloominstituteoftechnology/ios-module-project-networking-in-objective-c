//
//  HSIHourlyWeatherTests.m
//  CurrentWeatherTests
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HSIHourlyForecast.h"
#import "LSIFileHelper.h"
#import "LSILog.h"

@interface HSIHourlyWeatherTests : XCTestCase

@end

@implementation HSIHourlyWeatherTests

- (void)testHourlyWeatherParses {
    NSData *hourlyWeatherData = loadFile(@"HourlyWeather.json", [HSIHourlyWeatherTests class]);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:hourlyWeatherData options:0 error:&error];
    if (error) {
        XCTFail(@"Error decoding JSON: %@", error);
    }

    XCTAssertNotNil(json);

    HSIHourlyForecast *forecast = [[HSIHourlyForecast alloc] initWithDictionary:json];
    XCTAssertNotNil(forecast);

    NSDate *time = [[NSDate alloc] initWithTimeIntervalSince1970:1581001200];

    XCTAssertEqual(time, forecast.time);
    XCTAssertTrue([forecast.summary isEqualToString:@"Clear"]);
    XCTAssertTrue([forecast.icon isEqualToString:@"clear-night"]);
    XCTAssertEqualWithAccuracy(forecast.precipProbability, 0.0, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.precipIntensity, 0, 0.0001);
    XCTAssertNil(forecast.precipType);
    XCTAssertEqualWithAccuracy(forecast.temperatureLow, 0, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.temperatureHigh, 0, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.apparentTemperature, 46.54, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.humidity, 0.78, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.pressure, 1022.8, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.windSpeed, 3.57, 0.0001);
    XCTAssertEqualWithAccuracy(forecast.windBearing, 36, 0.0001);
    XCTAssertEqual(forecast.uvIndex, 0);

}

@end
