//
//  WeatherTest.m
//  DailyWeatherTests
//
//  Created by Nick Nguyen on 4/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIErrors.h"
#import "LSIFileHelper.h"
#import "LSICurrentWeather.h"
#import "LSILog.h"
@interface WeatherTest : XCTestCase

@end

@implementation WeatherTest

- (void)testParseCurrentWeather {
    NSData *currentWeatherData = loadFile(@"CurrentWeather.json", [WeatherTest class]);
    
    NSError *error = nil;
//    NSString * message = @"Wrong Data";
//    NSInteger *errorCode = LSIJSONDecodeError
    
    NSDictionary *currentWeatherJSON = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:0 error: &error ];
    
    if (error) {
        XCTFail(@"Error parsing JSON: %@", error);
    }
    
    LSICurrentWeather * currentWeather = [[LSICurrentWeather alloc] initWithDictionary:currentWeatherJSON];
    
    NSLog(@"JSON: %@",currentWeatherJSON);
    NSLog(@"current weather %@",currentWeather);
    
    XCTAssertEqualObjects(@"clear-day", currentWeather.icon);
    XCTAssertEqualWithAccuracy(47.4, currentWeather.apparentTemperature, 0.0001);
    XCTAssertEqual(3.45, currentWeather.windSpeed);
    
}


@end
