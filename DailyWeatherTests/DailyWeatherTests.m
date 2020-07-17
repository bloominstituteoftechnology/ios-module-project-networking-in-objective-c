//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CurrentWeather.h"
#import "LSIFileHelper.h"
#import "LSILog.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testExample {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    
    // TODO: Create Unit Tests for each separate JSON file

}

- (void)testCurrentWeather {
    
    NSData *data = loadFile(@"CurrentWeather.json", [CurrentWeather class]);
    
    NSError *error;
    
    NSDictionary *dict = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:0
                          error:&error];
    
    if (error) {
        LSILog(@"Unable to parse data from json file");
    } else {
        LSILog(@"%@", dict);
        XCTAssertTrue(true);
    }
}

@end
