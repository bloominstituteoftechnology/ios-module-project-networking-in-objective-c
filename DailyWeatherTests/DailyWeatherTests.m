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
#import "LSIWeatherForcast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testCurrentWeatherParsing {
    
    NSData *weatherData = loadFile(@"CurrentWeather.json", [DailyWeatherTests class]);
    
    NSError *jsonError = nil;
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&jsonError];
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
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&jsonError];
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
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&jsonError];
    if (!weatherDictionary) {
        NSLog(@"Error: %@", jsonError);
    }
    
    if (![weatherDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"weatherDictionary is not a dictionary!");
        return;
    }
    
//    LSIHourlyForecast *hourlyForecast = [[LSIHourlyForecast alloc] initWithDictionary:weatherDictionary];
    LSIHourlyForecast *hourlyForecast = [[LSIHourlyForecast alloc] initWithDictionary:weatherDictionary];
    
    NSLog(@"weather: %@", hourlyForecast);
    
    XCTAssertEqualObjects([NSDate dateWithTimeIntervalSince1970:1581001200], hourlyForecast.time);
    XCTAssertEqualObjects(@"Clear", hourlyForecast.summary);
    XCTAssertEqualObjects(@"clear-night", hourlyForecast.icon);
    XCTAssertEqualWithAccuracy(0.0, hourlyForecast.precipIntensity, 0.0001);
    XCTAssertEqualWithAccuracy(0.0, hourlyForecast.precipProbability, 0.0001);
    XCTAssertEqualObjects(nil, hourlyForecast.precipType);
    XCTAssertEqualWithAccuracy(47.68, hourlyForecast.temperature, 0.0001);
    XCTAssertEqualWithAccuracy(46.54, hourlyForecast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.78, hourlyForecast.humidity, 0.0001);
    XCTAssertEqualWithAccuracy(1022.8, hourlyForecast.pressure, 0.0001);
    XCTAssertEqualWithAccuracy(3.57, hourlyForecast.windSpeed, 0.0001);
    XCTAssertEqualWithAccuracy(36, hourlyForecast.windBearing, 0.0001);
    XCTAssertEqualWithAccuracy(0, hourlyForecast.uvIndex, 0.0001);
}

- (void)testWeatherParsing {
    
    NSData *weatherData = loadFile(@"Weather.json", [DailyWeatherTests class]);
    
    NSError *jsonError = nil;
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&jsonError]; // NSError **
    if (!weatherDictionary) {
        NSLog(@"Error: %@", jsonError);
    }
    
    if (![weatherDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"weatherDictionary is not a dictionary!");
        return;
    }
    
    LSIWeatherForcast *weatherForecast = [[LSIWeatherForcast alloc] initWithDictionary:weatherDictionary];
    
    NSLog(@"weather: %@", weatherForecast);
    
    XCTAssertEqualWithAccuracy(37.8267, weatherForecast.latitude, 0.0001);
    XCTAssertEqualWithAccuracy(-122.4233, weatherForecast.longitude, 0.0001);
    XCTAssertEqualObjects(@"America/Los_Angeles", weatherForecast.timezone);
    
    XCTAssertEqualObjects([NSDate dateWithTimeIntervalSince1970:1581003354], weatherForecast.currently.time);
    XCTAssertEqualObjects(@"Clear", weatherForecast.currently.summary);
    XCTAssertEqualObjects(@"clear-day", weatherForecast.currently.icon);
    XCTAssertEqualWithAccuracy(0, weatherForecast.currently.precipIntensity, 0.0001);
    XCTAssertEqualWithAccuracy(0, weatherForecast.currently.precipProbability, 0.0001);
    XCTAssertEqualWithAccuracy(48.35, weatherForecast.currently.temperature, 0.0001);
    XCTAssertEqualWithAccuracy(47.4, weatherForecast.currently.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.77, weatherForecast.currently.humidity, 0.0001);
    XCTAssertEqualWithAccuracy(1023.2, weatherForecast.currently.pressure, 0.0001);
    XCTAssertEqualWithAccuracy(3.45, weatherForecast.currently.windSpeed, 0.0001);
    XCTAssertEqualWithAccuracy(24, weatherForecast.currently.windBearing, 0.0001);
    XCTAssertEqualWithAccuracy(0, weatherForecast.currently.uvIndex, 0.0001);
    
    XCTAssertEqualObjects([NSDate dateWithTimeIntervalSince1970:1580976000], weatherForecast.daily[0].time);
    XCTAssertEqualObjects(@"Clear throughout the day.", weatherForecast.daily[0].summary);
    XCTAssertEqualObjects(@"clear-day", weatherForecast.daily[0].icon);
    XCTAssertEqualObjects([NSDate dateWithTimeIntervalSince1970:1581001860], weatherForecast.daily[0].sunriseTime);
    XCTAssertEqualObjects([NSDate dateWithTimeIntervalSince1970:1581039540], weatherForecast.daily[0].sunsetTime);
    XCTAssertEqualWithAccuracy(0.0006, weatherForecast.daily[0].precipIntensity, 0.0001);
    XCTAssertEqualWithAccuracy(0.13, weatherForecast.daily[0].precipProbability, 0.0001);
    XCTAssertEqualObjects(@"rain", weatherForecast.daily[0].precipType);
    XCTAssertEqualWithAccuracy(47.02, weatherForecast.daily[0].temperatureLow, 0.0001);
    XCTAssertEqualWithAccuracy(61.22, weatherForecast.daily[0].temperatureHigh, 0.0001);
    XCTAssertEqualWithAccuracy(60.72, weatherForecast.daily[0].apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.78, weatherForecast.daily[0].humidity, 0.0001);
    XCTAssertEqualWithAccuracy(1021.8, weatherForecast.daily[0].pressure, 0.0001);
    XCTAssertEqualWithAccuracy(3.82, weatherForecast.daily[0].windSpeed, 0.0001);
    XCTAssertEqualWithAccuracy(320, weatherForecast.daily[0].windBearing, 0.0001);
    XCTAssertEqualWithAccuracy(4, weatherForecast.daily[0].uvIndex, 0.0001);
    
    XCTAssertEqualObjects([NSDate dateWithTimeIntervalSince1970:1581001200], weatherForecast.hourly[0].time);
    XCTAssertEqualObjects(@"Clear", weatherForecast.hourly[0].summary);
    XCTAssertEqualObjects(@"clear-night", weatherForecast.hourly[0].icon);
    XCTAssertEqualWithAccuracy(0.001, weatherForecast.hourly[0].precipIntensity, 0.0001);
    XCTAssertEqualWithAccuracy(0.01, weatherForecast.hourly[0].precipProbability, 0.0001);
    XCTAssertEqualObjects(@"rain", weatherForecast.hourly[0].precipType);
    XCTAssertEqualWithAccuracy(47.68, weatherForecast.hourly[0].temperature, 0.0001);
    XCTAssertEqualWithAccuracy(46.54, weatherForecast.hourly[0].apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.78, weatherForecast.hourly[0].humidity, 0.0001);
    XCTAssertEqualWithAccuracy(1022.8, weatherForecast.hourly[0].pressure, 0.0001);
    XCTAssertEqualWithAccuracy(3.57, weatherForecast.hourly[0].windSpeed, 0.0001);
    XCTAssertEqualWithAccuracy(36, weatherForecast.hourly[0].windBearing, 0.0001);
    XCTAssertEqualWithAccuracy(0, weatherForecast.hourly[0].uvIndex, 0.0001);
}


@end
