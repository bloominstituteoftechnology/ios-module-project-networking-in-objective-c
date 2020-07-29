//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../DailyWeather/LambdaSDK/LSIFileHelper.h"
#import "../DailyWeather/LambdaSDK/LSILog.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testWeatherParsing {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    NSData *weatherData = loadFile(@"CurrentWeather.json", [DailyWeatherTests class]);
    
    NSError *JSONError = nil;
    
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&JSONError];
    
    XCTAssertNotNil(weatherData);
    
    if (!weatherDictionary) {
        NSLog(@"🐖 We've got an error: &@", JSONError);
    }
    
    XCTAssertTrue([weatherDictionary isKindOfClass:NSDictionary.class]);
    if (![weatherDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"🐖 weatherDictionary is not a dictionary");
        return;
    }
        
        
    // TODO: Create Unit Tests for each separate JSON file

}

@end
