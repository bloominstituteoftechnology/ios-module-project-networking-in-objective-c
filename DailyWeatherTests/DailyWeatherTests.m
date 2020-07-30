//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../DailyWeather/LambdaSDK/LSIFileHelper.h"
#import "../DailyWeather/LambdaSDK/LSILog.h"
#import "../DailyWeather/Models/LSICurrentForecast.h"
#import "../DailyWeather/Models/LSIWeatherForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testCurrectWeatherParsing {
    NSData *weatherData = loadFile(@"CurrentWeather.json", [DailyWeatherTests class]);

    NSError *jsonError = nil;
    NSDictionary *currentDictionary = [NSJSONSerialization JSONObjectWithData:weatherData
                                                                      options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&jsonError]; 
    if (!currentDictionary) {
        NSLog(@"We've got an error: %@", jsonError);
    }

    if (![currentDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"currentDictionary is not a dictionary!");
        return;
    }

    LSICurrentForecast *current = [[LSICurrentForecast alloc] initWithDictionary:currentDictionary];

    NSLog(@"current forecast: %@", current);

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354 / 1000.0];

    XCTAssertEqual(48.35, current.temperature);
    XCTAssertEqualObjects(@"Clear", current.summary);
    XCTAssertEqualObjects(time, current.time);
    XCTAssertEqualObjects(@"clear-day", current.icon);
    XCTAssertEqualWithAccuracy(0, current.precipIntensity, 0.0001);
    XCTAssertEqualWithAccuracy(0, current.precipProbability, 0.0001);
    XCTAssertEqualWithAccuracy(0.77, current.humidity, 0.0001);
    XCTAssertEqualWithAccuracy(1023.2, current.pressure, 0.0001);
    XCTAssertEqualWithAccuracy(3.45, current.windSpeed, 0.0001);
    XCTAssertEqualWithAccuracy(24., current.windBearing, 0.0001);
    XCTAssertEqualWithAccuracy(0., current.uvIndex, 0.0001);

}

@end
