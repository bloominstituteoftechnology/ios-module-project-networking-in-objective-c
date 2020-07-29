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
    
    
    
}

@end
