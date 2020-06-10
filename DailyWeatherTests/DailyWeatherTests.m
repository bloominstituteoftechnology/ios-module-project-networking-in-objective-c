//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HSIDailyWeather.h"
#import "HSIDailyWeatherResults.h"
#import "LSIFileHelper.h"
#import "LSILog.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testDailyWeatherParses {
    NSData *dailyWeatherData = loadFile(@"Weather.json", [DailyWeatherTests class]);
    NSLog(@"NSData: %@", dailyWeatherData);
    // Swift: do/catch (try)
    // Objc: NSError -> pass in a variable to update if it fails
    NSError *error = nil; // nil means no error
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dailyWeatherData options:0 error:&error]; // & = address of operator (shift + 7)
    if (error) { // (error != nil) {
        XCTFail(@"Error decoding JSON: %@", error);
    }
    NSLog(@"JSON: %@", json);
    HSIDailyWeatherResults *dailyWeatherResult = [[HSIDailyWeatherResults alloc] initWithDictionary:json];
    XCTAssertNotNil(dailyWeatherResult);
    XCTAssertEqual(dailyWeatherResult.days.count, 8);
    XCTAssertEqual(dailyWeatherResult.days[0].highTemperature, 61.22);
    XCTAssertEqual(dailyWeatherResult.days[0].lowTemperature, 47.02);
    XCTAssertTrue([dailyWeatherResult.days[0].icon isEqualToString:@"clear-day"]);
}

@end
