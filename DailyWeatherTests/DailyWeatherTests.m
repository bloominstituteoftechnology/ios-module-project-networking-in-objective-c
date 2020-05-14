//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "LSIWeatherConditions.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testCurrentWeatherParsing {
    
    NSData *weatherData = loadFile(@"CurrentWeather.json", [DailyWeatherTests class]);
    
    NSError *jsonError = nil;
    NSDictionary *weatherDict = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
    
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }
    
    LSIWeatherConditions *weatherConditions = [[LSIWeatherConditions alloc] initWithDictionary:weatherDict];

    XCTAssertEqual(weatherConditions.time.timeIntervalSince1970, 1581003354);
    XCTAssertEqualObjects(weatherConditions.summary, @"Clear");
    XCTAssertEqualObjects(weatherConditions.iconString, @"clear-day");
    XCTAssertEqual(weatherConditions.precipProbability.doubleValue, 0);
    XCTAssertEqual(weatherConditions.precipIntensity.doubleValue, 0);
    XCTAssertEqual(weatherConditions.temperature.doubleValue, 48.35);
    XCTAssertEqual(weatherConditions.apparentTemperature.doubleValue, 47.4);
    XCTAssertEqual(weatherConditions.humidity.doubleValue, 0.77);
    XCTAssertEqual(weatherConditions.pressure.doubleValue, 1023.2);
    XCTAssertEqual(weatherConditions.windSpeed.doubleValue, 3.45);
    XCTAssertEqual(weatherConditions.windBearing.intValue, 24);
    XCTAssertEqual(weatherConditions.uvIndex.intValue, 0);
}

- (void)testDailyWeatherParsing {

    NSData *weatherData = loadFile(@"DailyWeather.json", [DailyWeatherTests class]);
    
    NSError *jsonError = nil;
    NSDictionary *weatherDict = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
    
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }
    
    LSIWeatherConditions *weatherConditions = [[LSIWeatherConditions alloc] initWithDictionary:weatherDict];

    XCTAssertEqual(weatherConditions.time.timeIntervalSince1970, 1580976000);
    XCTAssertEqualObjects(weatherConditions.summary, @"Clear throughout the day.");
    XCTAssertEqualObjects(weatherConditions.iconString, @"clear-day");
    XCTAssertEqual(weatherConditions.sunriseTime.timeIntervalSince1970, 1581001860);
    XCTAssertEqual(weatherConditions.sunsetTime.timeIntervalSince1970, 1581039540);
    XCTAssertEqual(weatherConditions.precipProbability.doubleValue, 0.13);
    XCTAssertEqual(weatherConditions.precipIntensity.doubleValue, 0.0006);
    XCTAssertEqualObjects(weatherConditions.precipType, @"rain");
    XCTAssertEqual(weatherConditions.temperatureLow.doubleValue, 47.02);
    XCTAssertEqual(weatherConditions.temperatureHigh.doubleValue, 61.22);
    XCTAssertEqual(weatherConditions.apparentTemperatureHigh.doubleValue, 60.72);
    XCTAssertEqual(weatherConditions.humidity.doubleValue, 0.78);
    XCTAssertEqual(weatherConditions.pressure.doubleValue, 1021.8);
    XCTAssertEqual(weatherConditions.windSpeed.doubleValue, 3.82);
    XCTAssertEqual(weatherConditions.windBearing.intValue, 320);
    XCTAssertEqual(weatherConditions.uvIndex.intValue, 4);
}

- (void)testHourlyWeatherParsing {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    NSData *weatherData = loadFile(@"HourlyWeather.json", [DailyWeatherTests class]);

    NSError *jsonError = nil;
    NSDictionary *weatherDict = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];

    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }

    LSIWeatherConditions *weatherConditions = [[LSIWeatherConditions alloc] initWithDictionary:weatherDict];

    XCTAssertEqual(weatherConditions.time.timeIntervalSince1970, 1581001200);
    XCTAssertEqualObjects(weatherConditions.summary, @"Clear");
    XCTAssertEqualObjects(weatherConditions.iconString, @"clear-night");
    XCTAssertEqual(weatherConditions.precipProbability.doubleValue, 0.0);
    XCTAssertNil(weatherConditions.precipIntensity);
    XCTAssertNil(weatherConditions.precipType);
    XCTAssertEqual(weatherConditions.temperature.doubleValue, 47.68);
    XCTAssertEqual(weatherConditions.apparentTemperature.doubleValue, 46.54);
    XCTAssertEqual(weatherConditions.humidity.doubleValue, 0.78);
    XCTAssertEqual(weatherConditions.pressure.doubleValue, 1022.8);
    XCTAssertEqual(weatherConditions.windSpeed.doubleValue, 3.57);
    XCTAssertEqual(weatherConditions.windBearing.intValue, 36);
    XCTAssertEqual(weatherConditions.uvIndex.intValue, 0);
    
    XCTAssertNil(weatherConditions.sunriseTime);
}

@end
