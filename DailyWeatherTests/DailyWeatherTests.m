//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "SAHCurrentForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testExample {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    
    // TODO: Create Unit Tests for each separate JSON file

}

- (void)testParseCurrentWeather {
    NSData *data = loadFile(@"CurrentWeather.json", [SAHCurrentForecast class]);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];  // & = address of
    if (error) {  // if (error != nil) {
        XCTFail(@"Error parsing JSON: %@", error);
    }
    NSLog(@"JSON: %@", json);
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];
    SAHCurrentForecast *currentForecast = [[SAHCurrentForecast alloc] initWithDictionary:json];
    NSLog(@"forecst: %@", currentForecast);
    
    XCTAssertEqualWithAccuracy(48.35, currentForecast.temperature, 0.0001);
    XCTAssertEqualObjects(@"clear-day", currentForecast.icon);
    XCTAssertEqualObjects(time, currentForecast.time);
    
    // For now we'll just set the alert to nil, you may want to use @"" instead
    XCTAssertEqualWithAccuracy(47.4, currentForecast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.77, currentForecast.humidity, 0.0001);
    
}

@end
