//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "MSKWeatherForecast.h"
#import "LSILog.h"



@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testForecastParsing {
    NSData *currentWeather = loadFile(@"weather.json", [DailyWeatherTests class]);
    NSError *jsonError = nil;
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:currentWeather options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }
    MSKWeatherForecast *forecast = [[MSKWeatherForecast alloc] initFromDict:weatherDictionary];
    LSILog(forecast.currentForecast.summary);
    
}

/*- (void)testDailyParsing {
    NSData *dailyWeather = loadFile(@"DailyWeather.json", [DailyWeatherTests class]);
    NSError *jsonError = nil;
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:dailyWeather options:0 error:&jsonError];
    MSKCurrentWeather *current = [[MSKCurrentWeather alloc] initWithDict:weatherDictionary];
    LSILog(current);
}
 */

@end
