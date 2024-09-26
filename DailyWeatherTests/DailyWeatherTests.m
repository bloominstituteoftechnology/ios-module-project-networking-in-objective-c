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
#import "../DailyWeather/CurrentForecast.h"
#import "../DailyWeather/LSIWeatherForcast.h"



@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testCurrentWeatherParsing {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    NSData *weatherData = loadFile(@"CurrentWeather.json", [DailyWeatherTests class]);

    NSError *jsonError = nil;
    NSDictionary *currentDictionary = [NSJSONSerialization JSONObjectWithData:weatherData
                                                                      options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&jsonError]; // NSError **
    if (!currentDictionary) {
        NSLog(@"We've got an error: %@", jsonError);
    }

    if (![currentDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"currentDictionary is not a dictionary!");
        return;
    }

    CurrentForecast *current = [[CurrentForecast alloc] initWithDictionary:currentDictionary];

    NSLog(@"current forecast: %@", current);

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354 / 1000.0];

    XCTAssertEqual(48.35, current.temperature);
    XCTAssertEqualObjects(@"Clear", current.summary);
    XCTAssertEqualObjects(time, current.time);

//    // For now we'll just set the alert to nil, you may want to use @"" instead
//    XCTAssertNil(current.alert);

    // TODO: Create Unit Tests for each separate JSON file

}

@end

//- (void)testCurrentWeatherParsing
//{
//    NSData *quakeData = loadFile(@"Quake.json", [Quakes_ObjcTests class]);
//    //    NSLog(@"quake (as data): %@", quakeData);
//
//    //    NSString *quakeJSONString = [[NSString alloc] initWithData:quakeData encoding:NSUTF8StringEncoding];
//    //    NSLog(@"quake (as string): %@", quakeJSONString);
//
//    // [NSJSONSerialization JSONObjectWithData:quakeData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:NULL];
//    NSError *jsonError = nil;
//    NSDictionary *quakeDictionary = [NSJSONSerialization JSONObjectWithData:quakeData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&jsonError]; // NSError **
//    if (!quakeDictionary) {
//        NSLog(@"We've got an error: %@", jsonError);
//    }
//
//    //    NSLog(@"quake (as a dictionary): %@", quakeDictionary);
//
//    if (![quakeDictionary isKindOfClass:[NSDictionary class]]) {
//        NSLog(@"quakeDictionary is not a dictionary!");
//        return;
//    }
//
//    Quake *quake = [[Quake alloc] initWithDictionary:quakeDictionary];
//
//    NSLog(@"quake: %@", quake);
//
//    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1388620296020 / 1000.0];
//
//    XCTAssertEqualWithAccuracy(1.29, quake.magnitude, 0.0001);
//    XCTAssertEqualObjects(@"10km SSW of Idyllwild, CA", quake.place);
//    XCTAssertEqualObjects(time, quake.time);
//
//    // For now we'll just set the alert to nil, you may want to use @"" instead
//    XCTAssertNil(quake.alert);
//
//    XCTAssertEqualObjects(@"earthquake", quake.type);
//    XCTAssertEqualWithAccuracy(33.663333299999998, quake.latitude, 0.0001);
//    XCTAssertEqualWithAccuracy(-116.7776667, quake.longitude, 0.0001);
//}
