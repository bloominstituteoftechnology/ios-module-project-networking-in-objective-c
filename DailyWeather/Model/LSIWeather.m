//
//  LSIWeather.m
//  DailyWeather
//
//  Created by Kenneth Jones on 12/3/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeather.h"

@implementation LSIWeather

- (instancetype)init
{
    return [self initWithWeather:[[LSIWeatherForecast alloc] initWithTime:NSDate.now
                                                                  summary:@""
                                                                     icon:@""
                                                        precipProbability:0
                                                          precipIntensity:0
                                                              temperature:0
                                                      apparentTemperature:0
                                                                 humidity:0
                                                                 pressure:0
                                                                windSpeed:0
                                                              windBearing:0
                                                                  uvIndex:0]
                    dailyWeather:@[]
                   hourlyWeather:@[]];
}

- (instancetype)initWithWeather:(LSIWeatherForecast *)someWeather
                   dailyWeather:(NSArray<LSIDailyForecast *> *)someDailyWeather
                  hourlyWeather:(NSArray<LSIHourlyForecast *> *)someHourlyWeather
{
    if (self = [super init]) {
        _weather = someWeather;
        _dailyWeather = someDailyWeather.copy;
        _hourlyWeather = someHourlyWeather.copy;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    // Current weather
    NSDictionary *weatherDictionary = [aDictionary objectForKey:@"currently"];
    if (![weatherDictionary isKindOfClass:NSDictionary.class]) return nil;
    
    LSIWeatherForecast *weather = [[LSIWeatherForecast alloc] initWithDictionary:weatherDictionary];
    
    // Daily weather
    NSDictionary *dailyDictionary = [aDictionary objectForKey:@"daily"];
    if (![dailyDictionary isKindOfClass:NSDictionary.class]) return nil;
    
    NSArray *dailyData = [dailyDictionary objectForKey:@"data"];
    if (![dailyData isKindOfClass:NSArray.class]) return nil;
    
    NSMutableArray *dailyWeather = [[NSMutableArray alloc] initWithCapacity:dailyData.count];
    
    for (NSDictionary *dailyDict in dailyData) {
        if (![dailyDict isKindOfClass:NSDictionary.class]) continue;
        
        LSIDailyForecast *daily = [[LSIDailyForecast alloc] initWithDictionary:dailyDict];
        
        if (daily) {
            [dailyWeather addObject:daily];
        } else {
            NSLog(@"Unable to parse weather dictionary: %@", dailyDict);
        }
    }
    
    // Hourly weather
    NSDictionary *hourlyDictionary = [aDictionary objectForKey:@"hourly"];
    if (![hourlyDictionary isKindOfClass:NSDictionary.class]) return nil;
    
    NSArray *hourlyData = [hourlyDictionary objectForKey:@"data"];
    if (![hourlyData isKindOfClass:NSArray.class]) return nil;
    
    NSMutableArray *hourlyWeather = [[NSMutableArray alloc] initWithCapacity:hourlyData.count];
    
    for (NSDictionary *hourlyDict in hourlyData) {
        if (![hourlyDict isKindOfClass:NSDictionary.class]) continue;
        
        LSIHourlyForecast *hourly = [[LSIHourlyForecast alloc] initWithDictionary:hourlyDict];
        
        if (hourly) {
            [hourlyWeather addObject:hourly];
        } else {
            NSLog(@"Unable to parse weather dictionary: %@", hourlyDict);
        }
    }
    
    return [self initWithWeather:weather
                    dailyWeather:dailyWeather
                   hourlyWeather:hourlyWeather];
}

@end
