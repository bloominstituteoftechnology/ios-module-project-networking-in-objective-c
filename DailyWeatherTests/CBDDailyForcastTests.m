//
//  CBDDailyForcastTests.m
//  DailyWeatherTests
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CBDDailyForcast.h"
#import "LSIFileHelper.h"
#import "LSILog.h"

@interface CBDDailyForcastTests : XCTestCase

@end

@implementation CBDDailyForcastTests

- (void)testDailyForcastParsing {
    
    NSData *dailyForcastData = loadFile(@"DailyWeather.json", [CBDDailyForcastTests class]);
    NSLog(@"Daily Weather: %@", dailyForcastData);
    NSError *jsonError = nil;
    NSDictionary *dailyWeatherDictionary = [NSJSONSerialization JSONObjectWithData:dailyForcastData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }
    NSLog(@"JSON: %@", dailyWeatherDictionary);
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1580976000 / 1000.0];
    NSDate *sunriseTime = [NSDate dateWithTimeIntervalSince1970:1581001860 / 1000.0];
    NSDate *sunsetTime = [NSDate dateWithTimeIntervalSince1970:1581039540 / 1000.0];
    CBDDailyForcast *dailyForcast = [[CBDDailyForcast alloc] initWithDictionary:dailyWeatherDictionary];
    NSNumber *precipIntensity = [NSNumber numberWithDouble:0.0006];
    NSLog(@"Daily Weather: %@", dailyForcast);
    XCTAssertEqualObjects(time, dailyForcast.time);
    XCTAssertEqualObjects(@"Clear throughout the day.", dailyForcast.summary);
    XCTAssertEqualObjects(@"clear-day", dailyForcast.icon);
    XCTAssertEqualObjects(sunriseTime, dailyForcast.sunriseTime);
    XCTAssertEqualObjects(sunsetTime, dailyForcast.sunsetTime);
    XCTAssertEqualObjects(precipIntensity, dailyForcast.precipIntensity);
    XCTAssertEqualWithAccuracy(0.13, [dailyForcast.precipProbability doubleValue], 0.001);
    XCTAssertEqualObjects(@"rain", dailyForcast.precipType);
    XCTAssertEqualWithAccuracy(47.02, [dailyForcast.temperatureLow doubleValue ], 0.001);
    XCTAssertEqualWithAccuracy(61.22, [dailyForcast.temperatureHigh doubleValue], 0.001);
    XCTAssertEqualWithAccuracy(0.78, [dailyForcast.humidity doubleValue], 0.001);
    XCTAssertEqualWithAccuracy(1021.8, [dailyForcast.pressure doubleValue], 0.001);
    XCTAssertEqualWithAccuracy(3.82, [dailyForcast.windSpeed doubleValue], 0.001);
    XCTAssertEqualWithAccuracy(320, [dailyForcast.windBearing doubleValue], 0.001);
    XCTAssertEqualWithAccuracy(4, [dailyForcast.uvIndex doubleValue], 0.1);
    
}

@end
