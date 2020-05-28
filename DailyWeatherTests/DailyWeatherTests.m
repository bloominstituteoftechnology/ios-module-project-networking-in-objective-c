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
#import "../DailyWeather/Model/LSIWeatherForcast.h"
#import "../DailyWeather/Model/LSICurrentForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testWeatherParsing {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    NSData *weatherData = loadFile(@"CurrentWeather.json", [DailyWeatherTests class]);
    
    NSError *jsonError = nil;
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&jsonError]; // NSError **
    if (!weatherDictionary) {
        NSLog(@"We've got an error: %@", jsonError);
    }
    
    if (![weatherDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"weatherDictionary is not a dictionary!");
        return;
    }
    
    LSICurrentForecast *currentForecast = [[LSICurrentForecast alloc] initWithDictionary:weatherDictionary];
    
    NSLog(@"weather: %@", currentForecast);
    
    // TODO: Create Unit Tests for each separate JSON file
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];
    NSString *summary = @"Clear";
    NSString *icon = @"clear-day";
    double precipIntensity = 0;
    double precipProbability = 0;
    double temperature = 48.35;
    double apparentTemperature = 47.4;
    double humidity = 0.77;
    double pressure = 1023.2;
    double windSpeed = 3.45;
    double windBearing = 24;
    double uvIndex = 0;

    XCTAssertEqualObjects(time, currentForecast.time);
    XCTAssertEqualObjects(summary, currentForecast.summary);
    XCTAssertEqualObjects(icon, currentForecast.icon);
    XCTAssertEqualWithAccuracy(precipIntensity, currentForecast.precipIntensity, 0.0001);
    XCTAssertEqualWithAccuracy(precipProbability, currentForecast.precipProbability, 0.0001);
    XCTAssertEqualWithAccuracy(temperature, currentForecast.temperature, 0.0001);
    XCTAssertEqualWithAccuracy(apparentTemperature, currentForecast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(humidity, currentForecast.humidity, 0.0001);
    XCTAssertEqualWithAccuracy(pressure, currentForecast.pressure, 0.0001);
    XCTAssertEqualWithAccuracy(windSpeed, currentForecast.windSpeed, 0.0001);
    XCTAssertEqualWithAccuracy(windBearing, currentForecast.windBearing, 0.0001);
    XCTAssertEqualWithAccuracy(uvIndex, currentForecast.uvIndex, 0.0001);
}

@end
