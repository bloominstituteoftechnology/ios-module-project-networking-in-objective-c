//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "LSIWeatherForcast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testCurrentWeather {

    // Load test object from file.
    NSData *currentWeatherData = loadFile(@"CurrentWeather.json", [LSIWeatherForcast class]);
    NSLog(@"CurrentWeather: %@", currentWeatherData);

    // Pass through JSON Serializer
    NSError *jsonError = nil;
    NSDictionary *currentWeatherDictionary = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }

    // Parse the dictionary and turn it into a CurrentWeather object
    NSLog(@"JSON: %@", currentWeatherDictionary);


    // Pass it through LSIWeatherForcast initializer
    LSIWeatherForcast *currentWeather = [[LSIWeatherForcast alloc] initWithDictionary:currentWeatherDictionary];

    NSLog(@"currentWeather: %@", currentWeather);

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];
    XCTAssertEqualObjects(time, currentWeather.time);

    XCTAssertEqualObjects(@"Clear", currentWeather.summary);
    XCTAssertEqualObjects(@"clear-day", currentWeather.icon);
    XCTAssertEqualWithAccuracy(0.0, currentWeather.precipProbability.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(0.0, currentWeather.precipIntensity.doubleValue, 0.0001);
    XCTAssertEqual(48.35, currentWeather.temperature);
    XCTAssertEqual(47.4, currentWeather.apparentTemperature);
    XCTAssertEqual(0.77, currentWeather.humidity.doubleValue);
    XCTAssertEqual(1023.2, currentWeather.pressure.doubleValue);
    XCTAssertEqual(3.45, currentWeather.windSpeed.doubleValue);
    XCTAssertEqual(24, currentWeather.windBearing.doubleValue);
    XCTAssertEqual(0, currentWeather.uvIndex.doubleValue);
}

@end
