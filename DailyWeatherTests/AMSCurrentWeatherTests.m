//
//  AMSCurrentWeatherTests.m
//  DailyWeatherTests
//
//  Created by Alexander Supe on 19.03.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AMSCurrentForecast.h"
#import "LSIFileHelper.h"

@interface AMSCurrentWeatherTests : XCTestCase

@end

@implementation AMSCurrentWeatherTests

- (void)testParseCurrentWeather {
    NSData *data = loadFile(@"CurrentWeather.json", AMSCurrentWeatherTests.class);
    
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) { XCTFail(@"Parsing error: %@", error); }
    NSLog(@"JSON: %@", json);
    
    AMSCurrentForecast *forecast = [[AMSCurrentForecast alloc] initWithDictionary:json];
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354];
    XCTAssertEqualObjects(@"Clear", forecast.summary);
    XCTAssertEqualObjects(time, forecast.time);
}

@end
