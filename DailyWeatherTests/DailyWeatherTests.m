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
#import "../DailyWeather/CurrentForecast.h"
#import "../DailyWeather/DailyForecast.h"
#import "../DailyWeather/HourlyForecast.h"
#import "../DailyWeather/LSIWeatherForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testCurrentWeatherParsing
{
    NSData *weatherData = loadFile(@"CurrentWeather.json", DailyWeatherTests.class);
    
    NSError *jsonError = nil;
    NSDictionary *aDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
    
    XCTAssertNotNil(aDictionary);
    if (!aDictionary) {
        NSLog(@"Error: %@", jsonError);
        return;
    }
    
    XCTAssertTrue([aDictionary isKindOfClass:NSDictionary.class]);
    if (![aDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"aDictionary is not a dictionary!!");
        return;
    }
    
    NSLog(@"Current weather (as dictionary): %@", aDictionary);
    
    CurrentForecast *currentForecast = [[CurrentForecast alloc] initWithDictionary:aDictionary];
    NSLog(@"Current forecast (as CurrentForecast): %@", currentForecast);
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];
    
    XCTAssertEqualObjects(time, currentForecast.time);
    XCTAssertEqualObjects(@"Clear", currentForecast.summary);
    XCTAssertEqualObjects(@"clear-day", currentForecast.icon);
    XCTAssertEqualWithAccuracy(48.35, currentForecast.temperature, 0.0001);
    XCTAssertEqualWithAccuracy(10, currentForecast.visibility, 0.0001);
}

- (void)testDailyWeatherParsing
{
    NSData *weatherData = loadFile(@"DailyWeather.json", DailyWeatherTests.class);
    
    NSError *jsonError = nil;
    NSDictionary *aDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
    
    XCTAssertNotNil(aDictionary);
    if (!aDictionary) {
        NSLog(@"Error: %@", jsonError);
        return;
    }
    
    XCTAssertTrue([aDictionary isKindOfClass:NSDictionary.class]);
    if (![aDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"aDictionary is not a dictionary!!");
        return;
    }
    
    NSLog(@"Daily weather (as dictionary): %@", aDictionary);
    
    DailyForecast *dailyForecast = [[DailyForecast alloc] initWithDictionary:aDictionary];
    NSLog(@"Daily forecast (as DailyForecast): %@", dailyForecast);
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1580976000];
    
    XCTAssertEqualObjects(time, dailyForecast.time);
    XCTAssertEqualObjects(@"Clear throughout the day.", dailyForecast.summary);
    XCTAssertEqualObjects(@"clear-day", dailyForecast.icon);
    XCTAssertEqualWithAccuracy(47.02, dailyForecast.temperatureLow, 0.0001);
    XCTAssertEqualWithAccuracy(4, dailyForecast.uvIndex, 0.0001);
}

- (void)testHourlyWeatherParsing
{
    NSData *weatherData = loadFile(@"HourlyWeather.json", DailyWeatherTests.class);
    
    NSError *jsonError = nil;
    NSDictionary *aDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
    
    XCTAssertNotNil(aDictionary);
    if (!aDictionary) {
        NSLog(@"Error: %@", jsonError);
        return;
    }
    
    XCTAssertTrue([aDictionary isKindOfClass:NSDictionary.class]);
    if (![aDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"aDictionary is not a dictionary!!");
        return;
    }
    
    NSLog(@"Hourly weather (as dictionary): %@", aDictionary);
    
    HourlyForecast *hourlyForecast = [[HourlyForecast alloc] initWithDictionary:aDictionary];
    NSLog(@"Hourly forecast (as HourlyForecast): %@", hourlyForecast);
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581001200];
    
    XCTAssertEqualObjects(time, hourlyForecast.time);
    XCTAssertEqualObjects(@"Clear", hourlyForecast.summary);
    XCTAssertEqualObjects(@"clear-night", hourlyForecast.icon);
    XCTAssertEqualWithAccuracy(47.68, hourlyForecast.temperature, 0.0001);
    XCTAssertEqualWithAccuracy(0, hourlyForecast.uvIndex, 0.0001);
}

- (void)testWeatherParsing
{
    NSData *weatherData = loadFile(@"Weather.json", DailyWeatherTests.class);
    
    NSError *jsonError = nil;
    NSDictionary *aDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
    
    XCTAssertNotNil(aDictionary);
    if (!aDictionary) {
        NSLog(@"Error: %@", jsonError);
        return;
    }
    
    XCTAssertTrue([aDictionary isKindOfClass:NSDictionary.class]);
    if (![aDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"aDictionary is not a dictionary!!");
        return;
    }
    
    NSLog(@"Weather (as dictionary): %@", aDictionary);
    
    LSIWeatherForecast *weatherForecast = [[LSIWeatherForecast alloc] initWithDictionary:aDictionary];
    NSLog(@"Weather forecast (as LSIWeatherForecast): %@", weatherForecast);
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];
    
    XCTAssertEqualObjects(time, weatherForecast.currentWeather.time);
    XCTAssertEqualObjects(@"clear-day", weatherForecast.currentWeather.icon);
    XCTAssertEqualWithAccuracy(48.35, weatherForecast.currentWeather.temperature, 0.0001);
    XCTAssertEqualWithAccuracy(10, weatherForecast.currentWeather.visibility, 0.0001);
    
    XCTAssertEqual(8, weatherForecast.dailyWeather.count);
    XCTAssertEqual(49, weatherForecast.hourlyWeather.count);
}

@end
