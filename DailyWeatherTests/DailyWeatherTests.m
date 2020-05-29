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
#import "../DailyWeather/Model/LSIWeatherForecast.h"
#import "../DailyWeather/Model/LSICurrentForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testWeatherParsing {

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

@end
