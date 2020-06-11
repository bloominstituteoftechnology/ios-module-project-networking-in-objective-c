//
//  HSIDailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Kenny on 6/11/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HSIDailyForecast.h"
#import "LSIFileHelper.h"
#import "LSILog.h"

@interface HSIDailyWeatherTests : XCTestCase

@end

@implementation HSIDailyWeatherTests

- (void)testDailyWeatherParses {

    NSData *dailyWeatherData = loadFile(@"Weather.json", [HSIDailyWeatherTests class]);
    NSLog(@"NSData: %@", dailyWeatherData);

    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dailyWeatherData options:0 error:&error];
    if (error) {
        XCTFail(@"Error decoding JSON: %@", error);
    }

    NSLog(@"JSON: %@", json);
    XCTAssertNotNil(json);

    NSDictionary *dailyWeather = json[@"daily"];
    XCTAssertNotNil(dailyWeather);
}

@end
