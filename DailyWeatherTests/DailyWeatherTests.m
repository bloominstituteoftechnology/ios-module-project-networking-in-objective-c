//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "LSICurrentWeather.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"
#import "LSIWeatherForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testCurrentWeather {

    // Load test object from file.
    NSData *currentWeatherData = loadFile(@"CurrentWeather.json", [LSICurrentWeather class]);
    NSLog(@"CurrentWeather: %@", currentWeatherData);

    // Pass through JSON Serializer
    NSError *jsonError = nil;
    NSDictionary *currentWeatherDictionary = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }

    // Parse the dictionary and turn it into a CurrentWeather object
    NSLog(@"JSON: %@", currentWeatherDictionary);

    // Pass it through LSICurrentWeather initializer
    LSICurrentWeather *currentWeather = [[LSICurrentWeather alloc] initWithDictionary:currentWeatherDictionary];

    NSLog(@"currentWeather: %@", currentWeather);

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];
    XCTAssertEqualObjects(time, currentWeather.time);

    XCTAssertEqualObjects(@"Clear", currentWeather.summary);
    XCTAssertEqualObjects(@"clear-day", currentWeather.icon);
    XCTAssertEqualWithAccuracy(0.0, currentWeather.precipProbability.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(0.0, currentWeather.precipIntensity.doubleValue, 0.0001);
    XCTAssertEqual(48.35, currentWeather.temperature);
    XCTAssertEqual(47.4, currentWeather.apparentTemperature);
    XCTAssertEqual(0.77, currentWeather.humidity.doubleValue);
    XCTAssertEqual(1023.2, currentWeather.pressure.doubleValue);
    XCTAssertEqual(3.45, currentWeather.windSpeed.doubleValue);
    XCTAssertEqual(24, currentWeather.windBearing.doubleValue);
    XCTAssertEqual(0, currentWeather.uvIndex.doubleValue);
}

- (void)testDailyForecast {

    // Load test object from file.
    NSData *dailyForecastData = loadFile(@"DailyWeather.json", [LSIDailyForecast class]);
    NSLog(@"DailyWeather: %@", dailyForecastData);

    // Pass through JSON Serializer
    NSError *jsonError = nil;
    NSDictionary *dailyForecastDictionary = [NSJSONSerialization JSONObjectWithData:dailyForecastData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }

    // Parse the dictionary and turn it into a CurrentWeather object
    NSLog(@"JSON: %@", dailyForecastDictionary);


    // Pass it through LSIDailyForecast initializer
    LSIDailyForecast *dailyForecast = [[LSIDailyForecast alloc] initWithDictionary:dailyForecastDictionary];

    NSLog(@"dailyForecast: %@", dailyForecast);

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1580976000];
    XCTAssertEqualObjects(time, dailyForecast.time);

    XCTAssertEqualObjects(@"Clear throughout the day.", dailyForecast.summary);
    XCTAssertEqualObjects(@"clear-day", dailyForecast.icon);

    time = [NSDate dateWithTimeIntervalSince1970:1581001860];
    XCTAssertEqualObjects(time, dailyForecast.sunriseTime);

    time = [NSDate dateWithTimeIntervalSince1970:1581039540];
    XCTAssertEqualObjects(time, dailyForecast.sunsetTime);

    XCTAssertEqualWithAccuracy(0.0, dailyForecast.precipProbability.doubleValue, 0.13);
    XCTAssertEqualWithAccuracy(0.0, dailyForecast.precipIntensity.doubleValue, 0.0006);
    XCTAssertEqual(  47.02, dailyForecast.temperatureLow.doubleValue);
    XCTAssertEqual(  61.22, dailyForecast.temperatureHigh.doubleValue);
    XCTAssertEqual(  60.72, dailyForecast.apparentTemperatureHigh.doubleValue);
    XCTAssertEqual(   0.78, dailyForecast.humidity.doubleValue);
    XCTAssertEqual(1021.8,  dailyForecast.pressure.doubleValue);
    XCTAssertEqual(   3.82, dailyForecast.windSpeed.doubleValue);
    XCTAssertEqual( 320,    dailyForecast.windBearing.doubleValue);
    XCTAssertEqual(   4,    dailyForecast.uvIndex.doubleValue);
}

- (void)testHourlyForecast {

    // Load test object from file.
    NSData *hourlyForecastData = loadFile(@"HourlyWeather.json", [LSIHourlyForecast class]);
    NSLog(@"hourlyForecast: %@", hourlyForecastData);

    // Pass through JSON Serializer
    NSError *jsonError = nil;
    NSDictionary *hourlyForecastDictionary = [NSJSONSerialization JSONObjectWithData:hourlyForecastData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }

    // Parse the dictionary and turn it into a CurrentWeather object
    NSLog(@"JSON: %@", hourlyForecastDictionary);

    // Pass it through LSIHourlyForecast initializer
    LSIHourlyForecast *hourlyForecast = [[LSIHourlyForecast alloc] initWithDictionary:hourlyForecastDictionary];

    NSLog(@"hourlyForecast: %@", hourlyForecast);

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581001200];
    XCTAssertEqualObjects(time, hourlyForecast.time);

    XCTAssertEqualObjects(@"Clear", hourlyForecast.summary);
    XCTAssertEqualObjects(@"clear-night", hourlyForecast.icon);

    XCTAssertEqualWithAccuracy(0.0, hourlyForecast.precipProbability.doubleValue, 0.0);
    XCTAssertEqual(  47.68, hourlyForecast.temperature.doubleValue);
    XCTAssertEqual(  46.54, hourlyForecast.apparentTemperature.doubleValue);
    XCTAssertEqual(   0.78, hourlyForecast.humidity.doubleValue);
    XCTAssertEqual(1022.8,  hourlyForecast.pressure.doubleValue);
    XCTAssertEqual(   3.57, hourlyForecast.windSpeed.doubleValue);
    XCTAssertEqual(  36,    hourlyForecast.windBearing.doubleValue);
    XCTAssertEqual(   0,    hourlyForecast.uvIndex.doubleValue);
}

- (void)testWeatherForecast {

    // Load test object from file.
    NSData *weatherData = loadFile(@"Weather.json", [LSIWeatherForecast class]);
    NSLog(@"weather: %@", weatherData);

    // Pass through JSON Serializer
    NSError *jsonError = nil;
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }

    // Parse the dictionary and turn it into a CurrentWeather object
    NSLog(@"JSON: %@", weatherDictionary);

    // Pass it through LSIWeatherForecast initializer
    LSIWeatherForecast *weather = [[LSIWeatherForecast alloc] initWithDictionary:weatherDictionary];

    NSLog(@"weather: %@", weather);
}

@end
