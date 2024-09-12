//
//  CBDWeatherForecastTests.m
//  DailyWeatherTests
//
//  Created by Christopher Devito on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CBDWeatherForecast.h"
#import "CBDCurrentForcast.h"
#import "LSIFileHelper.h"
#import "LSILog.h"

@interface CBDWeatherForecastTests : XCTestCase

@end

@implementation CBDWeatherForecastTests

- (void)testWeatherForecastParsing {

NSData *weatherForecastData = loadFile(@"Weather.json", [CBDWeatherForecastTests class]);
NSLog(@"Weather: %@", weatherForecastData);
NSError *jsonError = nil;
NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherForecastData options:0 error:&jsonError];
if (jsonError) {
    NSLog(@"JSON Parsing error: %@", jsonError);
}
NSLog(@"JSON: %@", weatherDictionary);
CBDWeatherForecast *weatherForecast = [[CBDWeatherForecast alloc] initWithDictionary:weatherDictionary];
NSLog(@"Weather: %@", weatherForecast);
XCTAssertEqualObjects(@"Clear", weatherForecast.currentForecast.summary);
//XCTAssertEqualObjects(@"Clear", weatherForecast.summary);
//XCTAssertEqualObjects(@"clear-night", weatherForecast.icon);

    
}

@end
