//
//  LSIWeatherForecast.m
//  DailyWeather
//
//  Created by Cora Jacobson on 11/18/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForecast.h"

@implementation LSIWeatherForecast

- (instancetype)initWithCurrentWeather:(CurrentForecast *)currentWeather
                          dailyWeather:(NSArray<DailyForecast *> *)dailyWeather
                         hourlyWeather:(NSArray<HourlyForecast *> *)hourlyWeather
{
    if (self = [super init]) {
        _currentWeather = currentWeather;
        _dailyWeather = dailyWeather;
        _hourlyWeather = hourlyWeather;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    NSDictionary *currentDictionary = [aDictionary objectForKey:@"currently"];
    if (![currentDictionary isKindOfClass:NSDictionary.class]) return nil;
    
    CurrentForecast *currentForecast = [[CurrentForecast alloc] initWithDictionary:currentDictionary];
    if (![currentForecast isKindOfClass:CurrentForecast.class]) return nil;
    
    NSDictionary *dailyDictionary = [aDictionary objectForKey:@"daily"];
    if (![dailyDictionary isKindOfClass:NSDictionary.class]) return nil;
    
    NSArray *dailyForecastArray = [dailyDictionary objectForKey:@"data"];
    if (![dailyForecastArray isKindOfClass:NSArray.class]) return nil;
    
    NSMutableArray<DailyForecast *> *dailyForecasts = [[NSMutableArray<DailyForecast *> alloc] init];
    
    for (NSDictionary *daily in dailyForecastArray) {
        DailyForecast *dailyForecast = [[DailyForecast alloc] initWithDictionary:daily];
        [dailyForecasts addObject:dailyForecast];
    }
    
    NSDictionary *hourlyDictionary = [aDictionary objectForKey:@"hourly"];
    if (![hourlyDictionary isKindOfClass:NSDictionary.class]) return nil;
    
    NSArray *hourlyForecastArray = [hourlyDictionary objectForKey:@"data"];
    if (![hourlyForecastArray isKindOfClass:NSArray.class]) return nil;
    
    NSMutableArray<HourlyForecast *> *hourlyForecasts = [[NSMutableArray<HourlyForecast *> alloc] init];
    
    for (NSDictionary *hourly in hourlyForecastArray) {
        HourlyForecast *hourlyForecast = [[HourlyForecast alloc] initWithDictionary:hourly];
        [hourlyForecasts addObject:hourlyForecast];
    }
    
    return [self initWithCurrentWeather:currentForecast
                           dailyWeather:dailyForecasts
                          hourlyWeather:hourlyForecasts];
}

@end
