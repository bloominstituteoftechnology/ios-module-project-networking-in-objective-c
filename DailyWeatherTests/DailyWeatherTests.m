//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "AMSCurrentForecast.h"
#import "AMSDailyWeather.h"
#import "AMSHourlyWeather.h"
#import "AMSWeather.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests


- (void)testParseCurrentWeather {
    NSData *data = loadFile(@"CurrentWeather.json", DailyWeatherTests.class);
    
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) { XCTFail(@"Parsing error: %@", error); }
    
    AMSCurrentForecast *forecast = [[AMSCurrentForecast alloc] initWithDictionary:json];
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];
    XCTAssertEqualObjects(@"Clear", forecast.summary);
    XCTAssertEqualObjects(time, forecast.time);
}

- (void)testParseDailyWeather {
    NSData *data = loadFile(@"DailyWeather.json", DailyWeatherTests.class);
    
    NSError *error = nil;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) { XCTFail(@"Parsing error: %@", error); }
    
    NSDictionary *element = json[0];
    
    AMSCurrentForecast *forecast = [[AMSCurrentForecast alloc] initWithDictionary:element];
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1580976000];
    XCTAssertEqualObjects(@"Clear throughout the day.", forecast.summary);
    XCTAssertEqualObjects(time, forecast.time);
}

- (void)testParseHourlyWeather {
    NSData *data = loadFile(@"HourlyWeather.json", DailyWeatherTests.class);
    
    NSError *error = nil;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) { XCTFail(@"Parsing error: %@", error); }
    
    NSDictionary *element = json[0];
    
    AMSCurrentForecast *forecast = [[AMSCurrentForecast alloc] initWithDictionary:element];
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581001200];
    XCTAssertEqualObjects(@"clear-night", forecast.icon);
    XCTAssertEqualObjects(time, forecast.time);
}

- (void)testParseWeather {
    NSData *data = loadFile(@"Weather.json", DailyWeatherTests.class);
    
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) { XCTFail(@"Parsing error: %@", error); }
    
    AMSWeather *forecast = [[AMSWeather alloc] initWithDictionary:json];
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];
    XCTAssertEqualObjects(time, forecast.currently.time);
    XCTAssertEqualObjects(@"Clear throughout the day.", forecast.daily[0].summary);
    XCTAssertEqualObjects(@"clear-night", forecast.hourly[0].icon);
}

@end
