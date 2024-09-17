//
//  LSIWeatherForecast.m
//  DailyWeather
//
//  Created by scott harris on 4/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForecast.h"
#import "SAHHourlyForecast.h"
#import "SAHDailyForecast.h"
#import "SAHCurrentForecast.h"

@implementation LSIWeatherForecast

- (instancetype)initWithCurrentForecast:(SAHCurrentForecast *)currentForecast dailyForecasts:(NSArray<SAHDailyForecast *> *)dailyForecasts hourlyForecasts:(NSArray<SAHHourlyForecast *> *)hourlyForecasts {
    
    self = [self init];
    if (self) {
        _currentForecast = currentForecast;
        _dailyForecast = [dailyForecasts copy];
        _hourlyForecast = [hourlyForecasts copy];
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSDictionary *current = dictionary[@"currently"];
    NSArray *daily = dictionary[@"daily"][@"data"];
    NSArray *hourly = dictionary[@"hourly"][@"data"];
    NSMutableArray *dailyForecasts = [[NSMutableArray alloc] init];
    NSMutableArray *hourlyForecasts = [[NSMutableArray alloc] init];
    
    SAHCurrentForecast *currentForecast = [[SAHCurrentForecast alloc] initWithDictionary:current];
    
    for (NSDictionary *day in daily) {
        SAHDailyForecast *dayForecast = [[SAHDailyForecast alloc] initWithDictionary:day];
        [dailyForecasts addObject:dayForecast];
    }
    
    for (NSDictionary *hour in hourly) {
        SAHHourlyForecast *hourForecast = [[SAHHourlyForecast alloc] initWithDictionary:hour];
        [hourlyForecasts addObject:hourForecast];
    }
    
    self = [self initWithCurrentForecast:currentForecast dailyForecasts:dailyForecasts hourlyForecasts:hourlyForecasts];
    
    return self;

}

@end
