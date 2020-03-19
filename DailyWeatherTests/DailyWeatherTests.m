//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIWeatherForcast.h"
#import "LSILog.h"
#import "LSIFileHelper.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testParseWeatherForcast {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    NSData *data = loadFile(@"CurrentWeather.json", [LSIWeatherForcast class]);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) {  // if (error != nil) {
        XCTFail(@"Error parsing JSON: %@", error);
    }
    //NSLog(@"JSON: %@", json);

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354 / 1000.0];
    LSIWeatherForcast *weatherForcast = [[LSIWeatherForcast alloc] initWithDictionary:json];
    
    NSLog(@"weatherForcast = %@", weatherForcast);
    
    XCTAssertEqualObjects(time, weatherForcast.time);
    XCTAssertEqualObjects(@"Clear", weatherForcast.summary);
    XCTAssertEqualObjects(@"clear-day", weatherForcast.icon);
    XCTAssertEqualWithAccuracy(0.0, weatherForcast.precipProbablity, 0.0001);
    XCTAssertEqualWithAccuracy(0.0, weatherForcast.precipIntensity, 0.0001);
    XCTAssertEqualWithAccuracy(48.35, weatherForcast.temperature, 0.0001);
    XCTAssertEqualWithAccuracy(47.4, weatherForcast.apparentTemperature, 0.0001);
    XCTAssertEqualWithAccuracy(0.77, weatherForcast.humidity, 0.0001);
    XCTAssertEqualWithAccuracy(1023.2, weatherForcast.pressure, 0.0001);
    XCTAssertEqualWithAccuracy(3.45, weatherForcast.windSpeed, 0.0001);
    XCTAssertEqualWithAccuracy(24.0, weatherForcast.windBearing, 0.0001);
    XCTAssertEqual(0, weatherForcast.uvIndex);

}

// TODO: Create Unit Tests for each separate JSON file

@end
