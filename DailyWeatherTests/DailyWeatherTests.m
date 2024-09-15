//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../DailyWeather/LambdaSDK/LSIFileHelper.h"
#import "../DailyWeather/LSIWeatherForcast.h"
#import "../DailyWeather/LSIHourlyForecast.h"
#import "../DailyWeather/LSIDailyForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests



- (void)testCurrentWeather {
    NSData *data = loadFile(@"CurrentWeather.json", [LSIWeatherForcast class]);
       NSError *error = nil;
       NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
       if (error) {
           NSLog(@"error parsing json: %@", error);
       }
       NSLog(@"json: %@", json);
}
- (void)testDailyWeather {
    NSData *data = loadFile(@"DailyWeather.json", [LSIDailyForecast class]);
       NSError *error = nil;
       NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
       if (error) {
           NSLog(@"error parsing json: %@", error);
       }
       NSLog(@"json: %@", json);
}
- (void)testHourlyWeather {
    NSData *data = loadFile(@"HourlyWeather.json", [LSIHourlyForecast class]);
       NSError *error = nil;
       NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
       if (error) {
           NSLog(@"error parsing json: %@", error);
       }
       NSLog(@"json: %@", json);
}



@end
