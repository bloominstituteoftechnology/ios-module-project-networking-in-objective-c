//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "EPWCurrentForecast.h"
#import "EPWDailyWeather.h"
#import "EPWHourlyWeather.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testParseCurrentWeather {
//    NSData *data = loadFile(@"CurrentWeather.json", DailyWeatherTests.class);
//    
//    NSError *error = nil;
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//
//    if (error) { XCTFail(@"Parsing error: %@", error); }
//    
//     NSLog(@"JSON: %@", json);
////     NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];
//    EPWCurrentForecast *currentForecast = [[EPWCurrentForecast alloc] initWithDictionary:json];
//     NSLog(@"forecst: %@", currentForecast);
//    
//     NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];
//     XCTAssertEqualObjects(@"Clear", forecast.summary);
//     XCTAssertEqualObjects(time, forecast.time);
}

- (void)testParseDailyWeather {
    
}

- (void)testParseHourlyWeather {
}

@end
