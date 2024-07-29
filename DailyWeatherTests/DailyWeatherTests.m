//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSILog.h"
#import "LSIFileHelper.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"
#import "LSIWeatherForecast.h"
#import "LSICurrentForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testParseCurrentForecast {
    
    NSData *data = loadFile(@"Weather.json", [self class]);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Error parsing JSON: %@", jsonString);
    }
    NSDate *firstDayTime = [NSDate dateWithTimeIntervalSince1970:1580976000];
    NSDate *firstHourTime = [NSDate dateWithTimeIntervalSince1970:1581001200];
    
    LSIWeatherForecast *forcast= [[LSIWeatherForecast alloc] initWithDictionary:json];
    
    XCTAssertNotNil(forcast);
    XCTAssertNotNil(forcast.current);
    
    XCTAssertGreaterThan(forcast.daily.count, 0);
    LSIDailyForecast *firstDay = forcast.daily[0];
    XCTAssertEqualObjects(firstDayTime, firstDay.time);
    
    XCTAssertGreaterThan(forcast.hourly.count, 0);
    LSIHourlyForecast *firstHour = forcast.hourly[0];
    XCTAssertEqualObjects(firstHourTime, firstHour.time);
}



- (void)testParseDailyWeather {
    NSData *data = loadFile(@"DailyWeather.json", [self class]);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1580976000];
    
    // NOTE: Sunrise/sunset might not exist at high latitudes
    NSDate *sunrise = [NSDate dateWithTimeIntervalSince1970:1581001860];
    NSDate *sunset = [NSDate dateWithTimeIntervalSince1970:1581039540];
    
    LSIDailyForecast *dailyForecast = [[LSIDailyForecast alloc] initWithDictionary:json];
    
    XCTAssertNotNil(dailyForecast);
    
//    XCTAssertEqualObjects(time, dailyForecast.time);
//    XCTAssertEqualObjects(@"clear-day", dailyForecast.icon);
//    XCTAssertEqualWithAccuracy(61.22, dailyForecast.temperatureHigh.doubleValue, 0.00001);
//    XCTAssertEqualWithAccuracy(47.02, dailyForecast.temperatureLow.doubleValue, 0.00001);
//    XCTAssertEqualObjects(@"Clear throughout the day.", dailyForecast.summary);
//    XCTAssertEqualObjects(sunrise, dailyForecast.sunriseTime);
//    XCTAssertEqualObjects(sunset, dailyForecast.sunsetTime);
//    
//    XCTAssertEqualWithAccuracy(0.0006, dailyForecast.precipIntensity.doubleValue, 0.00001);
//    XCTAssertEqualWithAccuracy(0.13, dailyForecast.precipProbability.doubleValue, 0.00001);
//    XCTAssertEqualObjects(@"rain", dailyForecast.precipType);
//    
//    XCTAssertEqualWithAccuracy(0.78, dailyForecast.humidity.doubleValue, 0.00001);
//    XCTAssertEqualWithAccuracy(3.82, dailyForecast.windSpeed.doubleValue, 0.00001);
//    XCTAssertEqualWithAccuracy(320, dailyForecast.windBearing.doubleValue, 0.00001);
//    XCTAssertEqualWithAccuracy(4, dailyForecast.uvIndex.doubleValue, 0.00001);
}

@end
