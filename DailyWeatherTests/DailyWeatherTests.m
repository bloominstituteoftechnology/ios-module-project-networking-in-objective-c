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
#import "../DailyWeather/LSICurrentForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testExample {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    
    // TODO: Create Unit Tests for each separate JSON file

}

- (void)testCurrentWeatherParsing
{
    NSData *currentWeatherData = loadFile(@"CurrentWeather.json", DailyWeatherTests.class);
    
    NSError *jsonError = nil;
    NSDictionary *currentWeatherDictionary = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:0 error:&jsonError];
    
    if (!currentWeatherDictionary) {
        NSLog(@"Error with json: %@", jsonError);
    }
    
    if (![currentWeatherDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"current weather dictionary isn't a dictionary");
    }
    
    XCTAssertTrue([currentWeatherDictionary isKindOfClass:NSDictionary.class]);
    
    LSICurrentForecast *currentForecast = [[LSICurrentForecast alloc] initWithDictionary:currentWeatherDictionary];
    
    XCTAssertEqualObjects(@"Clear", currentForecast.summary);
    XCTAssertEqualObjects(@"clear-day", currentForecast.icon);
    XCTAssertEqualWithAccuracy(0, currentForecast.precipProbability, 0.0001);
    XCTAssertEqualWithAccuracy(0, currentForecast.precipIntensity, 0.0001);
    XCTAssertEqualWithAccuracy(48.35, currentForecast.temperature, 0.0001);
    XCTAssertEqualWithAccuracy(47.4, currentForecast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.77, currentForecast.humidity, 0.0001);
    XCTAssertEqualWithAccuracy(1023.2, currentForecast.pressure, 0.0001);
    XCTAssertEqualWithAccuracy(3.45, currentForecast.windSpeed, 0.0001);
    XCTAssertEqualWithAccuracy(24., currentForecast.windBearing, 0.0001);
    XCTAssertEqualWithAccuracy(0, currentForecast.uvIndex, 0.0001);

}

@end
