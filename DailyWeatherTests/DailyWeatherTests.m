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

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

//- (void)testExample {
//
//    // TODO: Use LSIFileHelper to load JSON from your test bundle
//
//
//    // TODO: Create Unit Tests for each separate JSON file
//
//}

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

//- (void)testDailyWeatherParsing {
//    
//    
//    
//    
//    
//}







@end
