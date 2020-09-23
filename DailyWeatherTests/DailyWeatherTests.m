//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "LSILog.h"
#import "LSICurrentForecast.h"
#import "LSIDailyWeather.h"
#import "LSIHourlyForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testCurrentWeatherParsing {

    NSData *weatherData = loadFile(@"CurrentWeather.json", [DailyWeatherTests class]);
    
    NSError *jsonError = nil;
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&jsonError]; // NSError **
    if (!weatherDictionary) {
        NSLog(@"Error: %@", jsonError);
    }
    
    if (![weatherDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"weatherDictionary is not a dictionary!");
        return;
    }
    
    LSICurrentForecast *currentForecast = [[LSICurrentForecast alloc] initWithDictionary:weatherDictionary];
    
    NSLog(@"weather: %@", currentForecast);

    XCTAssertEqualObjects([NSDate dateWithTimeIntervalSince1970:1581003354], currentForecast.time);
    XCTAssertEqualObjects(@"Clear", currentForecast.summary);
    XCTAssertEqualObjects(@"clear-day", currentForecast.icon);
    XCTAssertEqualWithAccuracy(0, currentForecast.precipIntensity, 0.0001);
    XCTAssertEqualWithAccuracy(0, currentForecast.precipProbability, 0.0001);
    XCTAssertEqualWithAccuracy(48.35, currentForecast.temperature, 0.0001);
    XCTAssertEqualWithAccuracy(47.4, currentForecast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.77, currentForecast.humidity, 0.0001);
    XCTAssertEqualWithAccuracy(1023.2, currentForecast.pressure, 0.0001);
    XCTAssertEqualWithAccuracy(3.45, currentForecast.windSpeed, 0.0001);
    XCTAssertEqualWithAccuracy(24, currentForecast.windBearing, 0.0001);
    XCTAssertEqualWithAccuracy(0, currentForecast.uvIndex, 0.0001);
}

- (void)testDailyWeatherParsing {

    NSData *weatherData = loadFile(@"DailyWeather.json", [DailyWeatherTests class]);
    
    NSError *jsonError = nil;
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&jsonError]; // NSError **
    if (!weatherDictionary) {
        NSLog(@"Error: %@", jsonError);
    }
    
    if (![weatherDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"weatherDictionary is not a dictionary!");
        return;
    }
    
    LSIDailyWeather *dailyForecast = [[LSIDailyWeather alloc] initWithDictionary:weatherDictionary];
    
    NSLog(@"weather: %@", dailyForecast);

    XCTAssertEqualObjects([NSDate dateWithTimeIntervalSince1970:1580976000], dailyForecast.time);
    XCTAssertEqualObjects(@"Clear throughout the day.", dailyForecast.summary);
    XCTAssertEqualObjects(@"clear-day", dailyForecast.icon);
    XCTAssertEqualObjects([NSDate dateWithTimeIntervalSince1970:1581001860], dailyForecast.sunriseTime);
    XCTAssertEqualObjects([NSDate dateWithTimeIntervalSince1970:1581039540], dailyForecast.sunsetTime);
    XCTAssertEqualWithAccuracy(0.0006, dailyForecast.precipIntensity, 0.0001);
    XCTAssertEqualWithAccuracy(0.13, dailyForecast.precipProbability, 0.0001);
    XCTAssertEqualObjects(@"rain", dailyForecast.precipType);
    XCTAssertEqualWithAccuracy(47.02, dailyForecast.temperatureLow, 0.0001);
    XCTAssertEqualWithAccuracy(61.22, dailyForecast.temperatureHigh, 0.0001);
    XCTAssertEqualWithAccuracy(60.72, dailyForecast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.78, dailyForecast.humidity, 0.0001);
    XCTAssertEqualWithAccuracy(1021.8, dailyForecast.pressure, 0.0001);
    XCTAssertEqualWithAccuracy(3.82, dailyForecast.windSpeed, 0.0001);
    XCTAssertEqualWithAccuracy(320, dailyForecast.windBearing, 0.0001);
    XCTAssertEqualWithAccuracy(4, dailyForecast.uvIndex, 0.0001);
}

- (void)testHourlyWeatherParsing {

    NSData *weatherData = loadFile(@"HourlyWeather.json", [DailyWeatherTests class]);
    
    NSError *jsonError = nil;
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&jsonError]; // NSError **
    if (!weatherDictionary) {
        NSLog(@"Error: %@", jsonError);
    }
    
    if (![weatherDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"weatherDictionary is not a dictionary!");
        return;
    }
    
    LSIHourlyForecast *hourlyForecast = [[LSIHourlyForecast alloc] initWithDictionary:weatherDictionary];
    
    NSLog(@"weather: %@", hourlyForecast);

    XCTAssertEqual([NSDate dateWithTimeIntervalSince1970:1581001200], hourlyForecast.time);
    XCTAssertEqual(@"Clear", hourlyForecast.summary);
    XCTAssertEqual(@"clear-night", hourlyForecast.icon);
    XCTAssertEqual(0.0, hourlyForecast.precipIntensity);
    XCTAssertEqualWithAccuracy(0.0, hourlyForecast.precipProbability, 0.0001);
    XCTAssertEqualObjects(nil, hourlyForecast.precipType);
    XCTAssertEqual(47.68, hourlyForecast.temperature);
    XCTAssertEqual(46.54, hourlyForecast.apparentTemperature);
    XCTAssertEqual(0.78, hourlyForecast.humidity);
    XCTAssertEqual(1022.8, hourlyForecast.pressure);
    XCTAssertEqual(3.57, hourlyForecast.windSpeed);
    XCTAssertEqual(36, hourlyForecast.windBearing);
    XCTAssertEqualWithAccuracy(0, hourlyForecast.uvIndex, 0.0001);
}


@end
