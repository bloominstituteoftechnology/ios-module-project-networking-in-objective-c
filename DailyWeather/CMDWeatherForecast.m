//
//  CMDWeatherForecast.m
//  DailyWeather
//
//  Created by Chris Dobek on 6/11/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CMDWeatherForecast.h"
#import "CMDCurrentForecast.h"
#import "CMDHourlyForecast.h"
#import "CMDDailyForecast.h"

@implementation CMDWeatherForecast

- (instancetype)initWithCurrentForecast:(CMDCurrentForecast *)currentForecast
                        hourlyForecasts:(NSArray *)hourlyForecasts
                         dailyForecasts:(NSArray *)dailyForecasts {
    self = [super init];
    if (self) {
        _currentForecast = currentForecast;
        _hourlyForecasts = hourlyForecasts;
        _dailyForecasts = dailyForecasts;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSDictionary *hourly = dictionary[@"hourly"];
    NSDictionary *daily = dictionary[@"daily"];
    NSDictionary *currentForecast = dictionary[@"currently"];
    NSArray *hourlyForecasts = hourly[@"data"];
    NSArray *dailyForecasts = daily[@"data"];
    CMDCurrentForecast *current = [[CMDCurrentForecast alloc] initWithDictionary:currentForecast];
    NSMutableArray *finalDailyForecasts = [NSMutableArray new];
    for (int i = 0; i < dailyForecasts.count; i++) {
        CMDDailyForecast *dailyforcastObject = [[CMDDailyForecast alloc] initWithDictionary:dailyForecasts[i]];
        [finalDailyForecasts addObject:dailyforcastObject];
    }
    NSMutableArray *finalHourlyForecasts = [NSMutableArray new];
    for (int i = 0; i < hourlyForecasts.count; i++) {
        CMDHourlyForecast *hourlyForcastObject = [[CMDHourlyForecast alloc] initWithDictionary:hourlyForecasts[i]];
        [finalHourlyForecasts addObject:hourlyForcastObject];
    }
    return [self initWithCurrentForecast:current hourlyForecasts:finalHourlyForecasts dailyForecasts:dailyForecasts];
}

@end
