//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "SAHCurrentForecast.h"
#import "SAHDailyForecast.h"
#import "SAHHourlyForecast.h"
#import "LSIWeatherForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testExample {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    
    // TODO: Create Unit Tests for each separate JSON file

}

- (void)testParseCurrentWeather {
    NSData *data = loadFile(@"CurrentWeather.json", [SAHCurrentForecast class]);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];  // & = address of
    if (error) {  // if (error != nil) {
        XCTFail(@"Error parsing JSON: %@", error);
    }
    NSLog(@"JSON: %@", json);
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];
    SAHCurrentForecast *currentForecast = [[SAHCurrentForecast alloc] initWithDictionary:json];
    NSLog(@"forecst: %@", currentForecast);
    
    XCTAssertEqualWithAccuracy(48.35, currentForecast.temperature, 0.0001);
    XCTAssertEqualObjects(@"clear-day", currentForecast.icon);
    XCTAssertEqualObjects(time, currentForecast.time);
    
    // For now we'll just set the alert to nil, you may want to use @"" instead
    XCTAssertEqualWithAccuracy(47.4, currentForecast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.77, currentForecast.humidity, 0.0001);
    
}

- (void)testParseDailyWeather {
    NSData *data = loadFile(@"DailyWeather.json", [SAHDailyForecast class]);
    NSError *error = nil;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];  // & = address of
    if (error) {  // if (error != nil) {
        XCTFail(@"Error parsing JSON: %@", error);
    }
    NSLog(@"JSON: %@", json);
    
    NSMutableArray<SAHDailyForecast *> *dailies = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in json) {
        SAHDailyForecast *forecast = [[SAHDailyForecast alloc] initWithDictionary:dictionary];
        [dailies addObject:forecast];
    }
    
    SAHDailyForecast *firstForecast = dailies.firstObject;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1580976000];
    
    
    XCTAssertEqualWithAccuracy(61.22, firstForecast.temperatureHigh, 0.0001);
     XCTAssertEqualWithAccuracy(47.02, firstForecast.temperatureLow, 0.0001);
    XCTAssertEqualObjects(@"clear-day", firstForecast.icon);
    XCTAssertEqualObjects(time, firstForecast.time);
    
    // For now we'll just set the alert to nil, you may want to use @"" instead
    XCTAssertEqualWithAccuracy(60.72, firstForecast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.78, firstForecast.humidity, 0.0001);
    
}

- (void)testParseHourlyWeather {
    NSData *data = loadFile(@"HourlyWeather.json", [SAHHourlyForecast class]);
    NSError *error = nil;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];  // & = address of
    if (error) {  // if (error != nil) {
        XCTFail(@"Error parsing JSON: %@", error);
    }
    NSLog(@"JSON: %@", json);
    
    NSMutableArray<SAHHourlyForecast *> *hourlys = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in json) {
        SAHHourlyForecast *forecast = [[SAHHourlyForecast alloc] initWithDictionary:dictionary];
        [hourlys addObject:forecast];
    }
    
    SAHHourlyForecast *firstForecast = hourlys.firstObject;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581001200];
    
    
    XCTAssertEqualWithAccuracy(47.68, firstForecast.temperature, 0.0001);
    XCTAssertEqualObjects(@"clear-night", firstForecast.icon);
    XCTAssertEqualObjects(time, firstForecast.time);
    
    // For now we'll just set the alert to nil, you may want to use @"" instead
    XCTAssertEqualWithAccuracy(46.54, firstForecast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.78, firstForecast.humidity, 0.0001);
    
}

- (void)testParseWeather {
    NSData *data = loadFile(@"Weather.json", [LSIWeatherForecast class]);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];  // & = address of
    if (error) {  // if (error != nil) {
        XCTFail(@"Error parsing JSON: %@", error);
    }
    NSLog(@"JSON: %@", json);
    
    LSIWeatherForecast *forecast = [[LSIWeatherForecast alloc] initWithDictionary:json];

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581001200];
    
    XCTAssertEqualWithAccuracy(48.35, forecast.currentForecast.temperature, 0.0001);
    XCTAssertEqualObjects(@"clear-day", forecast.currentForecast.icon);
    
    // For now we'll just set the alert to nil, you may want to use @"" instead
    XCTAssertEqualWithAccuracy(47.4, forecast.currentForecast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.77, forecast.currentForecast.humidity, 0.0001);
    
    SAHHourlyForecast *firstHourly = forecast.hourlyForecast.firstObject;
    
    
    XCTAssertEqualWithAccuracy(47.68, firstHourly.temperature, 0.0001);
    XCTAssertEqualObjects(@"clear-night", firstHourly.icon);
    XCTAssertEqualObjects(time, firstHourly.time);
    
    // For now we'll just set the alert to nil, you may want to use @"" instead
    XCTAssertEqualWithAccuracy(46.54, firstHourly.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.78, firstHourly.humidity, 0.0001);
    
    SAHDailyForecast *firstDaily = forecast.dailyForecast.firstObject;
    
    XCTAssertEqualWithAccuracy(61.22, firstDaily.temperatureHigh, 0.0001);
    XCTAssertEqualWithAccuracy(47.02, firstDaily.temperatureLow, 0.0001);
    XCTAssertEqualObjects(@"clear-day", firstDaily.icon);    
    // For now we'll just set the alert to nil, you may want to use @"" instead
    XCTAssertEqualWithAccuracy(60.72, firstDaily.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.78, firstDaily.humidity, 0.0001);
    
}

@end
