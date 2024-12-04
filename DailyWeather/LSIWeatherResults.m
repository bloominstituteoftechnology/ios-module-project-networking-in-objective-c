//
//  LSIWeatherResults.m
//  DailyWeather
//
//  Created by Sean Acres on 7/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherResults.h"
#import "LSICurrentForecast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

@implementation LSIWeatherResults

- (instancetype)init
{
    return [self initWithCurrentForecast:[[LSICurrentForecast alloc] init] hourlyForecasts:@[] dailyForecasts:@[]];
}

- (instancetype)initWithCurrentForecast:(LSICurrentForecast *)currentForecast hourlyForecasts:(NSArray<LSIHourlyForecast *> *)hourlyForecasts dailyForecasts:(NSArray<LSIDailyForecast *> *)dailyForecasts
{
    if (self = [super init]) {
        _currentForecast = currentForecast;
        _hourlyForecasts = hourlyForecasts.copy;
        _dailyForecasts = dailyForecasts.copy;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSDictionary *currentWeatherDictionary = [dictionary objectForKey:@"currently"];
    LSICurrentForecast *currentForecast = [[LSICurrentForecast alloc] initWithDictionary:currentWeatherDictionary];
    
    NSDictionary *dailyWeatherDictionary = [dictionary objectForKey:@"daily"];
    NSArray *dailyWeatherDictionaries = [dailyWeatherDictionary objectForKey:@"data"];
    if (![dailyWeatherDictionaries isKindOfClass:NSArray.class]) return nil;
    
    NSMutableArray *dailyForecasts = [[NSMutableArray alloc] initWithCapacity:dailyWeatherDictionaries.count];
    
    for (NSDictionary *dailyForecastDictionary in dailyWeatherDictionaries) {
        if (![dailyForecastDictionary isKindOfClass:NSDictionary.class]) continue;
        
        LSIDailyForecast *dailyForecast = [[LSIDailyForecast alloc] initWithDictionary:dailyForecastDictionary];
        
        if (dailyForecast) {
            [dailyForecasts addObject:dailyForecast];
        } else {
            NSLog(@"Unable to parse daily forecast dictionary: %@", dailyForecastDictionary);
        }
    }
    
    NSDictionary *hourlyWeatherDictionary = [dictionary objectForKey:@"hourly"];
    NSArray *hourlyWeatherDictionaries = [hourlyWeatherDictionary objectForKey:@"data"];
    if (![hourlyWeatherDictionaries isKindOfClass:NSArray.class]) return nil;
    
    NSMutableArray *hourlyForecasts = [[NSMutableArray alloc] initWithCapacity:hourlyWeatherDictionaries.count];
    
    for (NSDictionary *hourlyForecastDictionary in hourlyWeatherDictionaries) {
        if (![hourlyForecastDictionary isKindOfClass:NSDictionary.class]) continue;
        
        LSIHourlyForecast *hourlyForecast = [[LSIHourlyForecast alloc] initWithDictionary:hourlyForecastDictionary];
        
        if (hourlyForecast) {
            [hourlyForecasts addObject:hourlyForecast];
        } else {
            NSLog(@"Unable to parse hourly forecast dictionary: %@", hourlyForecastDictionary);
        }
    }
    
    return [self initWithCurrentForecast:currentForecast hourlyForecasts:hourlyForecasts dailyForecasts:dailyForecasts];
}

@end
