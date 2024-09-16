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

-(void)testLSICurrentWeatherForecastParsing
{
  NSData *weatherForecastData = loadFile(@"CurrentWeather.json", [DailyWeatherTests class]);
  
  NSLog(@"Current Weather Data (as data): %@", weatherForecastData);
  NSString *weatherJSONString = [[NSString alloc] initWithData:weatherForecastData encoding:NSUTF8StringEncoding];
  NSLog(@"Current Weather Data (as string): %@", weatherJSONString);

}

-(void)testDailyWeatherForecastParsing
{
  NSData *dailyWeatherForecastData = loadFile(@"DailyWeather.json", [DailyWeatherTests class]);
  
  NSLog(@"Daily Weather Data (as data): %@", dailyWeatherForecastData);
  NSString *dailyWeatherJSONString = [[NSString alloc] initWithData:dailyWeatherForecastData encoding:NSUTF8StringEncoding];
  NSLog(@"Daily Weather Data (as string): %@", dailyWeatherJSONString);

}

-(void)testHourlyWeatherForecastParsing
{
  NSData *hourlyWeatherForecastData = loadFile(@"HourlyWeather.json", [DailyWeatherTests class]);
  
  NSLog(@"Hourly Weather Data (as data): %@", hourlyWeatherForecastData);
  NSString *hourlyWeatherJSONString = [[NSString alloc] initWithData:hourlyWeatherForecastData encoding:NSUTF8StringEncoding];
  NSLog(@"Hourly Weather Data (as string): %@", hourlyWeatherJSONString);

}




@end
