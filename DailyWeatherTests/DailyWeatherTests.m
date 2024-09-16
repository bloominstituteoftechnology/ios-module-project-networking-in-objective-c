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
#import "LSIHourlyWeather.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests


- (void)testCurrentWeatherParsing {
    NSData *currentWeatherData = loadFile(@"CurrentWeather.json", [DailyWeatherTests class]);
    NSLog(@"currentWeather: %@", currentWeatherData);
    
    NSError *jsonError = nil;
    NSDictionary *currentWeatherDictionary = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:0 error:&jsonError];
    
    if (jsonError) {
        NSLog(@"JSON parsing error %@", jsonError);
    }
    
    // Parse the dictionary and turn it inot a CurrentWeather object
    NSLog(@"JSON: %@", currentWeatherDictionary);
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970: 1581003354 / 1000.0];
    
    
    LSICurrentForecast *currentForecast = [[LSICurrentForecast alloc] initWithDictionary:currentWeatherDictionary];
    
    NSLog(@"currentWeather: %@", currentForecast);
    
    XCTAssertEqualObjects(time, currentForecast.time);
    NSLog(@"👍🏻 TIME: %@", currentForecast.time);
    
    XCTAssertEqualObjects(@"clear-day", currentForecast.icon);
    
    XCTAssertNil(currentForecast.windBearing);
}

- (void)testDailyWeatherParsing {
    NSData *dailyWeatherData = loadFile(@"DailyWeather.json", [DailyWeatherTests class]);
    NSLog(@"currentWeather: %@", dailyWeatherData);
    
    NSError *jsonError = nil;
    NSDictionary *dailyWeatherDictionary = [NSJSONSerialization JSONObjectWithData:dailyWeatherData options:0 error:&jsonError];
    
    if (jsonError) {
        NSLog(@"JSON parsing error %@", jsonError);
    }
    
    NSDate *timeRegular = [NSDate dateWithTimeIntervalSince1970: 1580976000 / 1000.0];
    NSDate *timeSunset = [NSDate dateWithTimeIntervalSince1970: 1581039540 / 1000.0];
//    NSDate *timeSunrise = [NSDate dateWithTimeIntervalSince1970: 1581001860 / 1000.0];
    
    LSIDailyWeather *dailyForecast = [[LSIDailyWeather alloc] initWithDictionary:dailyWeatherDictionary];
    
    XCTAssertEqualObjects(timeRegular, dailyForecast.time);
    XCTAssertEqualObjects(timeSunset, dailyForecast.sunsetTime);
    XCTAssertEqualObjects(@"clear-day", dailyForecast.icon);
    XCTAssertEqualObjects(@"rain", dailyForecast.precipitationType);
    NSLog(@"👍🏻 PREP TYPE: %@", dailyForecast.precipitationType);

    
}

- (void)testHourlyWeatherParsing {
    NSData *hourlyWeatherData = loadFile(@"HourlyWeather.json", [DailyWeatherTests class]);
    NSLog(@"hourlyWeather: %@", hourlyWeatherData);
    
    NSError *jsonError = nil;
    NSDictionary *hourlyWeatherDictionary = [NSJSONSerialization JSONObjectWithData:hourlyWeatherData options:0 error:&jsonError];
    
    if (jsonError) {
        NSLog(@"JSON parsing error %@", jsonError);
    }
    
    NSDate *timeRegular = [NSDate dateWithTimeIntervalSince1970: 1581001200 / 1000.0];
    
    LSIDailyWeather *hourlyForecast = [[LSIDailyWeather alloc] initWithDictionary:hourlyWeatherDictionary];
    
    XCTAssertEqualObjects(timeRegular, hourlyForecast.time);
    XCTAssertEqualObjects(@"clear-night", hourlyForecast.icon);
    XCTAssertNil(hourlyForecast.precipitationType);
}





@end
