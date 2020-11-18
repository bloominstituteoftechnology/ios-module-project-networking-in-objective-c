//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "LSILog.h"
#import "LSICurrentForecast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testCurrentWeatherParsing {

    NSData *weatherData = loadFile(@"CurrentWeather.json", [DailyWeatherTests class]);
    NSError *jsonError = nil;
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&jsonError];
    if (!weatherDictionary) {
        NSLog(@"Error: %@", jsonError);
    }
    
    if (![weatherDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"weatherDictionary is not a dictionary");
        return;
    }
    
    LSICurrentForecast *currentForcast) = [[LSICurrentForecast alloc] initWithDictionary:weatherDictionary];
    NSLog(@"weather: %@", currentForecast);
}

@end
