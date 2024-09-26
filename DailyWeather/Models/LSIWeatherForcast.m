//
//  LSIWeatherForecast.m
//  DailyWeather
//
//  Created by Mark Gerrior on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForecast.h"

@implementation LSIWeatherForecast

- (instancetype)initWithCurrently:(LSICurrentWeather *)currently
                            daily:(LSIDailyForecast *)daily
                           hourly:(LSIHourlyForecast *)hourly {
    self = [super init];
    if (self != nil) {
        _currently = currently;
        _daily = daily;
        _hourly = hourly;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    LSICurrentWeather *currently = dictionary[@"currently"];
    LSIDailyForecast *daily      = dictionary[@"daily"];
    LSIHourlyForecast *hourly    = dictionary[@"hourly"];

    // No required elements

    return [self initWithCurrently:currently
                             daily:daily
                            hourly:hourly
            ];
}

@end
