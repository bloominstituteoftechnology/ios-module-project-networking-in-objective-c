//
//  HSIHourlyWeatherTests.m
//  CurrentWeatherTests
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HSIHourlyForecast.h"
#import "LSIFileHelper.h"
#import "LSILog.h"

@interface HSIHourlyWeatherTests : XCTestCase

@end

@implementation HSIHourlyWeatherTests

- (void)testHourlyWeatherParses {
    NSData *hourlyWeatherData = loadFile(@"HourlyWeather.json", [HSIHourlyWeatherTests class]);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:hourlyWeatherData options:0 error:&error];
    if (error) {
        XCTFail(@"Error decoding JSON: %@", error);
    }

    XCTAssertNotNil(json);

    HSIHourlyForecast *forecast = [[HSIHourlyForecast alloc] initWithDictionary:json];
    XCTAssertNotNil(forecast);
}

@end
