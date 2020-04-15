//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIWeatherForecast.h"
#import "LSILog.h"
#import "LSIFileHelper.h"
#import "LSIDailyForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testParseWeatherForcast {
    NSData *data = loadFile(@"CurrentWeather.json", [LSIWeatherForecast class]);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) {
        XCTFail(@"Error parsing JSON: %@", error);
    }

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354 / 1000.0];
    LSIWeatherForecast *weatherForcast = [[LSIWeatherForecast alloc] initWithDictionary:json];
    
    NSLog(@"weatherForcast = %@", weatherForcast);
    
    XCTAssertEqualObjects(time, weatherForcast.time);
    XCTAssertEqualObjects(@"Clear", weatherForcast.summary);
    XCTAssertEqualObjects(@"clear-day", weatherForcast.icon);
    XCTAssertEqualWithAccuracy(0.0, weatherForcast.precipProbablity.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(0.0, weatherForcast.precipIntensity.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(48.35, weatherForcast.temperature.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(47.4, weatherForcast.apparentTemperature.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(0.77, weatherForcast.humidity.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(1023.2, weatherForcast.pressure.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(3.45, weatherForcast.windSpeed.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(24.0, weatherForcast.windBearing.doubleValue, 0.0001);
    XCTAssertEqual(0, weatherForcast.uvIndex.intValue);

}

- (void)testParseDailyWeather {
    
    NSData *data = loadFile(@"DailyWeather.json", [LSIDailyForecast class]);
    NSError *error = nil;

    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

    if (error) {
        XCTFail(@"Error parsing JSON: %@", error);
    }
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1580976000 / 1000.0];
    NSDate *sunriseTime = [NSDate dateWithTimeIntervalSince1970:1581001860 / 1000.0];
    NSDate *sunsetTime = [NSDate dateWithTimeIntervalSince1970:1581039540 / 1000.0];

    NSMutableArray *dailyArray = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsonArray) {
        LSIDailyForecast *dailyForecast = [[LSIDailyForecast alloc] initWithDictionary:json];
        XCTAssertNotNil(dailyForecast);
        [dailyArray addObject:dailyForecast];
    }
    
    LSIDailyForecast *dailyForecast = dailyArray[0];
    XCTAssertEqualObjects(time, dailyForecast.time);
    XCTAssertEqualObjects(@"Clear throughout the day.", dailyForecast.summary);
    XCTAssertEqualObjects(@"clear-day", dailyForecast.icon);
    XCTAssertEqualObjects(sunriseTime, dailyForecast.sunriseTime);
    XCTAssertEqualObjects(sunsetTime, dailyForecast.sunsetTime);
    XCTAssertEqualWithAccuracy(0.13, dailyForecast.precipProbablity.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(0.0006, dailyForecast.precipIntensity.doubleValue, 0.0001);
    XCTAssertEqualObjects(@"rain", dailyForecast.precipType);
    XCTAssertEqualWithAccuracy(47.02, dailyForecast.temperatureLow.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(61.22, dailyForecast.temperatureHigh.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(60.72, dailyForecast.apparentTemperature.doubleValue, 0.0001); // apptemphigh?
    XCTAssertEqualWithAccuracy(0.78, dailyForecast.humidity.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(1021.8, dailyForecast.pressure.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(3.82, dailyForecast.windSpeed.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(320, dailyForecast.windBearing.doubleValue, 0.0001);
    XCTAssertEqual(4, dailyForecast.uvIndex.intValue);
}

@end
