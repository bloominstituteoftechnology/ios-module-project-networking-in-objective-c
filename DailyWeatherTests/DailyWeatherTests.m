//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../DailyWeather/LambdaSDK/LSILog.h"
#import "../DailyWeather/LambdaSDK/LSIFileHelper.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testExample {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    
    // TODO: Create Unit Tests for each separate JSON file

}

- (void)testCurrentWeatherParsing
{
    NSData *currentWeatherData = loadFile(@"CurrentWeather.json", DailyWeatherTests.class);
    
    NSError *jsonError = nil;
    NSDictionary *currentWeatherDictionary = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:0 error:&jsonError];
    
    if (!currentWeatherDictionary) {
        NSLog(@"Error with json: %@", jsonError);
    }
    
    if (![currentWeatherDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"current weather dictionary isn't a dictionary");
    }
    
    XCTAssertTrue([currentWeatherDictionary isKindOfClass:NSDictionary.class]);
}

@end
