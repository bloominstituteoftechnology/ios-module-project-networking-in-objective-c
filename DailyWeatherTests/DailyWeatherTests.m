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

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testParsingCurrentWeather {

    NSData *weatherData = loadFile(@"CurrentWeather.json", [DailyWeatherTests class]);
    
    NSError *JSONError = nil;
    
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&JSONError];
    
    XCTAssertNotNil(weatherData);
    
    if (!weatherDictionary) {
        NSLog(@"🐖 We've got an error: &@", JSONError);
    }
    
    XCTAssertTrue([weatherDictionary isKindOfClass:NSDictionary.class]);
    if (![weatherDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"🐖 weatherDictionary is not a dictionary");
        return;
    }
}

- (void)testParsingDailyWeather {
    NSData *weatherData = loadFile(@"DailyWeather.json", [DailyWeatherTests class]);
    
    NSError *JSONError = nil;
    
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&JSONError];
    
    XCTAssertNotNil(weatherData);
    
    if (!weatherDictionary) {
        NSLog(@"🐖 We've got an error: &@", JSONError);
    }
    
    XCTAssertTrue([weatherDictionary isKindOfClass:NSDictionary.class]);
    if (![weatherDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"🐖 weatherDictionary is not a dictionary");
        return;
    }
}


- (void)testParsingHourlyWeather {
    NSData *weatherData = loadFile(@"HourlyWeather.json", [DailyWeatherTests class]);
    
    NSError *JSONError = nil;
    
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&JSONError];
    
    XCTAssertNotNil(weatherData);
    
    if (!weatherDictionary) {
        NSLog(@"🐖 We've got an error: &@", JSONError);
    }
    
    XCTAssertTrue([weatherDictionary isKindOfClass:NSDictionary.class]);
    if (![weatherDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"🐖 weatherDictionary is not a dictionary");
        return;
    }
}
@end
