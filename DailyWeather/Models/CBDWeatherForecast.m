//
//  CBDWeatherForecast.m
//  DailyWeather
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CBDWeatherForecast.h"
#import "CBDCurrentForcast.h"
#import "CBDDailyForcast.h"
#import "CBDHourlyForcast.h"

@implementation CBDWeatherForecast

- (instancetype)initWithCurrentForecast:(CBDCurrentForcast *)currentForecast
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
    
    CBDCurrentForcast *currentForecast = dictionary[@"currently"];
    NSArray *hourlyForecasts = hourly[@"data"];
    NSArray *dailyForecasts = daily[@"data"];
    
    return [self initWithCurrentForecast:currentForecast hourlyForecasts:hourlyForecasts dailyForecasts:dailyForecasts];
}

@end
