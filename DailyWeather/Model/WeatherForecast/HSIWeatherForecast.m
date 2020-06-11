//
//  HSIDailyForecast.m
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import "HSIWeatherForecast.h"

@implementation HSIWeatherForecast

- (instancetype)initWithCurrentForecast:(HSICurrentForecast *)currentForecast
                         dailyForecasts:(NSArray<HSIDailyForecast *> *)dailyForecasts
                        hourlyForecasts:(NSArray<HSIHourlyForecast *> *)hourlyForecasts
{
    self = [super init];
    if (self) {
        _currentForecast = currentForecast;
        _dailyForecasts = dailyForecasts;
        _hourlyForecasts = hourlyForecasts;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *) dictionary {


    NSDictionary *currentForecastData = dictionary[@"currently"];
    NSArray *dailyForecastsData = dictionary[@"daily"][@"data"];
    NSArray *hourlyForecastsData = dictionary[@"hourly"][@"data"];

    NSMutableArray<HSIDailyForecast *> *dailyForecasts = nil;

    if (dailyForecastsData) {
        for (NSDictionary *dailyData in dailyForecastsData) {
            HSIDailyForecast *dailyForecast = [[HSIDailyForecast alloc] initWithDictionary:dailyData];
            if (dailyForecasts) {
                [dailyForecasts addObject:dailyForecast];
            } else {
                dailyForecasts = [[NSMutableArray<HSIDailyForecast *> alloc] init];
                [dailyForecasts addObject:dailyForecast];
            }
        }
    } else {
        NSLog(@"No daily Forecast Data");
        return nil;
    }

    NSMutableArray<HSIHourlyForecast *> *hourlyForecasts = nil;

       if (hourlyForecastsData) {
           for (NSDictionary *hourlyData in hourlyForecastsData) {
               HSIHourlyForecast *hourlyForecast = [[HSIHourlyForecast alloc] initWithDictionary:hourlyData];
               if (hourlyForecasts) {
                   [hourlyForecasts addObject:hourlyForecast];
               } else {
                   hourlyForecasts = [[NSMutableArray<HSIHourlyForecast *> alloc] init];
                   [hourlyForecasts addObject:hourlyForecast];
               }
           }
       } else {
           NSLog(@"No hourly Forecast Data");
           return nil;
       }

    HSICurrentForecast *currentForecast = [[HSICurrentForecast alloc] initWithDictionary:currentForecastData];
    if (currentForecast && dailyForecasts && hourlyForecasts) {
        return [self initWithCurrentForecast:currentForecast
                              dailyForecasts:dailyForecasts
                             hourlyForecasts:hourlyForecasts];
    } else {
        NSLog(@"One or more forecasts/arrays is/are empty");
        return nil;
    }

}

@end
