//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSILog.h"
#import "LSIFileHelper.h"
#import "LSICurrentForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testCurentForcastParsing {

    NSData *forecastData = loadFile(@"CurrentWeather.json", DailyWeatherTests.class);
    //NSString *forecastJSONString = [[NSString alloc] initWithData:forecastData encoding:NSUTF8StringEncoding];
    //NSLog(@"🤖forecast (as string): %@", forecastJSONString);

    NSError *jsonError = nil;
    NSDictionary *forecastDictionary = [NSJSONSerialization JSONObjectWithData:forecastData options:0 error:&jsonError];

    XCTAssertNotNil(forecastDictionary);
    if (!forecastDictionary) {
        NSLog(@"🤖 We've got an error: %@", jsonError);
    }

    XCTAssert([forecastDictionary isKindOfClass:NSDictionary.class]);
    if (![forecastDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"forecastDictionary is not a dictionary!!");
        return;
    }

    //NSLog(@"🤖 forecast (as a dictionary): %@", forecastDictionary);

    LSICurrentForecast *forecast = [[LSICurrentForecast alloc] initWithDictionary:forecastDictionary];
    NSLog(@"Forecast: %@", forecast);
}


// TODO: Create Unit Tests for each separate JSON file

@end
