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
#import "../DailyWeather/LSIWeatherForcast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testExample {

    // TODO: Use LSIFileHelper to load JSON from your test bundle
    
    // TODO: Create Unit Tests for each separate JSON file

}

-(void)testLSIWeatherForecastParsing
{
  NSData *weatherForecastData = loadFile(@"CurrentWeather.json", [DailyWeatherTests class]);
  
  NSLog(@"Weather Data (as data): %@", weatherForecastData);
  NSString *weatherJSONString = [[NSString alloc] initWithData:weatherForecastData encoding:NSUTF8StringEncoding];
  NSLog(@"Weather Data (as string): %@", weatherJSONString);

}

@end
