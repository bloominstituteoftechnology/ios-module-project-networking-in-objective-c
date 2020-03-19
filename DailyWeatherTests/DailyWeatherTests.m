//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIWeatherForcast.h"
#import "LSILog.h"
#import "LSIFileHelper.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testParseWeatherForcast {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    NSData *data = loadFile(@"CurrentWeather.json", [LSIWeatherForcast class]);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) {  // if (error != nil) {
        XCTFail(@"Error parsing JSON: %@", error);
    }
    NSLog(@"JSON: %@", json);

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354 / 1000.0];
    LSIWeatherForcast *weatherForcast = [[LSIWeatherForcast alloc] initWithDictionary:json];
    
    NSLog(@"weatherForcast = %@", weatherForcast);

}

// TODO: Create Unit Tests for each separate JSON file

@end
