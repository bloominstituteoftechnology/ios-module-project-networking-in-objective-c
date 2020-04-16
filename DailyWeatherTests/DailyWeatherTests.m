//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIWeatherForecast.h"
#import "LSILog.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testParseWeatherForcast {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    NSData *data = loadFile(@"CurrentWeather.json", [LSIWeatherForecast class]);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) {
        XCTFail(@"Error parsing JSON: %@", error);
    }
    //NSLog(@"JSON: %@", json);

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354 / 1000.0];
    LSIWeatherForecast *weatherForecast = [[LSIWeatherForecast alloc] initWithDictionary:json];
    
    NSLog(@"weatherForcast = %@", weatherForecast);
    
    XCTAssertEqualObjects(time, weatherForecast.time);
    XCTAssertEqualObjects(@"Clear", weatherForecast.summary);
    XCTAssertEqualObjects(@"clear-day", weatherForecast.icon);
    XCTAssertEqualWithAccuracy(0.0, weatherForecast.precipProbablity.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(0.0, weatherForecast.precipIntensity.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(48.35, weatherForecast.temperature.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(47.4, weatherForecast.apparentTemperature.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(0.77, weatherForecast.humidity.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(1023.2, weatherForecast.pressure.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(3.45, weatherForecast.windSpeed.doubleValue, 0.0001);
    XCTAssertEqualWithAccuracy(24.0, weatherForecast.windBearing.doubleValue, 0.0001);
    XCTAssertEqual(0, weatherForecast.uvIndex.intValue);

}

@end
