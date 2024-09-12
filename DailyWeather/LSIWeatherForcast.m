//
//  LSIWeatherForcast.m
//  DailyWeather
//
//  Created by Bhawnish Kumar on 6/10/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForcast.h"

@implementation LSIWeatherForcast

- (instancetype)initWithCurrently:(LSICurrentWeather *)currently
                            daily:(LSIDailyForcast *)daily
                           hourly:(LSIHourlyWeather *)hourly
{
    self = [super init];
    if (self) {
        _currently = currently;
        _daily = daily;
        _hourly = hourly;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    LSICurrentWeather *currently = dictionary[@"currently"];
    LSIDailyForcast *daily = dictionary[@"daily"];
    LSIHourlyWeather *hourly = dictionary[@"hourly"];
    
    return [self initWithCurrently:currently
                             daily:daily
                            hourly:hourly];
    
}

@end
