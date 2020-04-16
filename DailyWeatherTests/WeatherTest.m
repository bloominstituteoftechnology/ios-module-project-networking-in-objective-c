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
#import "LSIDailyForecast.h"
#import "LSIDailyForecastResult.h"

@interface WeatherTest : XCTestCase

@end

@implementation WeatherTest

- (void)testParseCurrentWeather {
    NSData *currentWeatherData = loadFile(@"CurrentWeather.json", [WeatherTest class]);
    NSError *error = nil;

    NSDictionary *currentWeatherJSON = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:0 error: &error ];
    
    if (error) {    XCTFail(@"Error parsing JSON: %@", error);   }
     
    LSICurrentWeather * currentWeather = [[LSICurrentWeather alloc] initWithDictionary:currentWeatherJSON];
    
    NSLog(@"JSON: %@",currentWeatherJSON);
    NSLog(@"current weather %@",currentWeather);
    
    XCTAssertEqualObjects(@"clear-day", currentWeather.icon);
    XCTAssertEqualWithAccuracy(47.4, currentWeather.apparentTemperature, 0.0001);
    XCTAssertEqual(3.45, currentWeather.windSpeed);
    
}

- (void)testParseDailyForecastArray {
    NSData *dailyForecastData = loadFile(@"DailyWeather.json", [WeatherTest class]);
    NSError *error = nil;
    
    NSArray *json = [NSJSONSerialization JSONObjectWithData:dailyForecastData options:0 error:&error]; // JSON is array
    if (error) {  NSLog(@"JSON Parsing error: %@",error); }
       
    LSIDailyForecastResult *dailyForecastArray = [[LSIDailyForecastResult alloc] initWithResult:json];
    LSIDailyForecast *firstItem = [dailyForecastArray.result objectAtIndex:0];
    XCTAssertTrue(dailyForecastArray.result.count == 8 );
    XCTAssertNotNil(firstItem);
//    XCTAssertEqual(4, firstItem.uvIndex);
    
    
}
@end
