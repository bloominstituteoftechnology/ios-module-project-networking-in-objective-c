//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../DailyWeather/LambdaSDK/LSILog.h"
#import "../DailyWeather/LambdaSDK/LSIFileHelper.h"
#import "../DailyWeather/LSICurrentForecast.h"
#import "../DailyWeather/LSIDailyForecast.h"
#import "../DailyWeather/LSIHourlyForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testExample {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    
    // TODO: Create Unit Tests for each separate JSON file

}

- (void)testCurrentWeatherParsing
{
    NSData *currentWeatherData = loadFile(@"CurrentWeather.json", DailyWeatherTests.class);
    
    NSError *jsonError = nil;
    NSDictionary *currentWeatherDictionary = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:0 error:&jsonError];
    
    if (!currentWeatherDictionary) {
        NSLog(@"Error with json: %@", jsonError);
    }
    
    if (![currentWeatherDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"current weather dictionary isn't a dictionary");
    }
    
    XCTAssertTrue([currentWeatherDictionary isKindOfClass:NSDictionary.class]);
    
    LSICurrentForecast *currentForecast = [[LSICurrentForecast alloc] initWithDictionary:currentWeatherDictionary];
    
    XCTAssertEqualObjects(@"Clear", currentForecast.summary);
    XCTAssertEqualObjects(@"clear-day", currentForecast.icon);
    XCTAssertEqualWithAccuracy(0, currentForecast.precipProbability, 0.0001);
    XCTAssertEqualWithAccuracy(0, currentForecast.precipIntensity, 0.0001);
    XCTAssertEqualWithAccuracy(48.35, currentForecast.temperature, 0.0001);
    XCTAssertEqualWithAccuracy(47.4, currentForecast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.77, currentForecast.humidity, 0.0001);
    XCTAssertEqualWithAccuracy(1023.2, currentForecast.pressure, 0.0001);
    XCTAssertEqualWithAccuracy(3.45, currentForecast.windSpeed, 0.0001);
    XCTAssertEqualWithAccuracy(24., currentForecast.windBearing, 0.0001);
    XCTAssertEqualWithAccuracy(0, currentForecast.uvIndex, 0.0001);

}

- (void)testDailyWeatherParsing
{
    NSData *dailyWeatherData = loadFile(@"DailyWeather.json", DailyWeatherTests.class);
    
    NSError *jsonError = nil;
    NSDictionary *dailyWeatherDictionary = [NSJSONSerialization JSONObjectWithData:dailyWeatherData options:0 error:&jsonError];
    
    if (!dailyWeatherDictionary) {
        NSLog(@"Error with json: %@", jsonError);
    }
    
    if (![dailyWeatherDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"daily weather dictionary isn't a dictionary");
    }
    
    XCTAssertTrue([dailyWeatherDictionary isKindOfClass:NSDictionary.class]);
    
    LSIDailyForecast *dailyForecast = [[LSIDailyForecast alloc] initWithDictionary:dailyWeatherDictionary];
    
    XCTAssertEqualObjects(@"Clear throughout the day.", dailyForecast.summary);
    XCTAssertEqualObjects(@"clear-day", dailyForecast.icon);
    XCTAssertEqualWithAccuracy(0.13, dailyForecast.precipProbability, 0.0001);
    XCTAssertEqualWithAccuracy(0.0006, dailyForecast.precipIntensity, 0.0001);
    XCTAssertEqualWithAccuracy(47.02, dailyForecast.temperatureLow, 0.0001);
    XCTAssertEqualWithAccuracy(61.22, dailyForecast.temperatureHigh, 0.0001);
    XCTAssertEqualWithAccuracy(46.05, dailyForecast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.78, dailyForecast.humidity, 0.0001);
    XCTAssertEqualWithAccuracy(1021.8, dailyForecast.pressure, 0.0001);
    XCTAssertEqualWithAccuracy(3.82, dailyForecast.windSpeed, 0.0001);
    XCTAssertEqualWithAccuracy(320., dailyForecast.windBearing, 0.0001);
    XCTAssertEqualWithAccuracy(4, dailyForecast.uvIndex, 0.0001);
    XCTAssertEqualObjects(@"rain", dailyForecast.precipType);
}

- (void)testHourlyWeatherParsing
{
    NSData *hourlyWeatherData = loadFile(@"HourlyWeather.json", DailyWeatherTests.class);
    
    NSError *jsonError = nil;
    NSDictionary *hourlyWeatherDictionary = [NSJSONSerialization JSONObjectWithData:hourlyWeatherData options:0 error:&jsonError];
    
    if (!hourlyWeatherDictionary) {
        NSLog(@"Error with json: %@", jsonError);
    }
    
    if (![hourlyWeatherDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"hourlyWeatherDictionary isn't a dictionary");
    }
    
    XCTAssertTrue([hourlyWeatherDictionary isKindOfClass:NSDictionary.class]);
    
    LSIHourlyForecast *hourlyForecast = [[LSIHourlyForecast alloc] initWithDictionary:hourlyWeatherDictionary];

    XCTAssertEqualObjects(@"Clear", hourlyForecast.summary);
    XCTAssertEqualObjects(@"clear-night", hourlyForecast.icon);
    XCTAssertEqualWithAccuracy(0.0, hourlyForecast.precipProbability, 0.0001);
    XCTAssertEqualWithAccuracy(47.68, hourlyForecast.temperature, 0.0001);
    XCTAssertEqualWithAccuracy(46.54, hourlyForecast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.78, hourlyForecast.humidity, 0.0001);
    XCTAssertEqualWithAccuracy(1022.8, hourlyForecast.pressure, 0.0001);
    XCTAssertEqualWithAccuracy(3.57, hourlyForecast.windSpeed, 0.0001);
    XCTAssertEqualWithAccuracy(36., hourlyForecast.windBearing, 0.0001);
    XCTAssertEqualWithAccuracy(0, hourlyForecast.uvIndex, 0.0001);
    XCTAssertNil(hourlyForecast.precipType);
}



@end
