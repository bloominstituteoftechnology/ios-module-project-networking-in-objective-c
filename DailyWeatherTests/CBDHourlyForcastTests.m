//
//  CBDHourlyForcastTests.m
//  DailyWeatherTests
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CBDHourlyForcast.h"
#import "LSIFileHelper.h"
#import "LSILog.h"

@interface CBDHourlyForcastTests : XCTestCase

@end

@implementation CBDHourlyForcastTests

- (void)testhourlyForcastParsing {

NSData *hourlyForcastData = loadFile(@"HourlyWeather.json", [CBDHourlyForcastTests class]);
NSLog(@"Hourly Weather: %@", hourlyForcastData);
NSError *jsonError = nil;
NSDictionary *hourlyWeatherDictionary = [NSJSONSerialization JSONObjectWithData:hourlyForcastData options:0 error:&jsonError];
if (jsonError) {
    NSLog(@"JSON Parsing error: %@", jsonError);
}
NSLog(@"JSON: %@", hourlyWeatherDictionary);
NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581001200 / 1000.0];
CBDHourlyForcast *hourlyForcast = [[CBDHourlyForcast alloc] initWithDictionary:hourlyWeatherDictionary];
NSNumber *temperature = [NSNumber numberWithDouble:47.68];
NSLog(@"Hourly Weather: %@", hourlyForcast);
XCTAssertEqualObjects(time, hourlyForcast.time);
XCTAssertEqualObjects(@"Clear", hourlyForcast.summary);
XCTAssertEqualObjects(@"clear-night", hourlyForcast.icon);
XCTAssertNil(hourlyForcast.precipIntensity);
XCTAssertEqualWithAccuracy(0.0, hourlyForcast.precipProbability, 0.001);
XCTAssertNil(hourlyForcast.precipType);
XCTAssertNil(hourlyForcast.temperatureLow);
XCTAssertNil(hourlyForcast.temperatureHigh);
XCTAssertEqualWithAccuracy(46.54, hourlyForcast.apparentTemperature, 0.001);
XCTAssertEqualObjects(temperature, hourlyForcast.temperature);
XCTAssertEqualWithAccuracy(0.78, hourlyForcast.humidity, 0.001);
XCTAssertEqualWithAccuracy(1022.8, hourlyForcast.pressure, 0.001);
XCTAssertEqualWithAccuracy(3.57, hourlyForcast.windSpeed, 0.001);
XCTAssertEqualWithAccuracy(36, hourlyForcast.windBearing, 0.001);
XCTAssertEqualWithAccuracy(0, hourlyForcast.uvIndex, 0.1);
    
}

@end
