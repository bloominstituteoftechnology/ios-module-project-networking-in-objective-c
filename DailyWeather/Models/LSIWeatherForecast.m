//
//  LSIWeatherForecast.m
//  DailyWeather
//
//  Created by Claudia Maciel on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForecast.h"

@implementation LSIWeatherForecast

- (instancetype)initWithCurrently:(NSDictionary *)currently daily:(NSDictionary *)daily hourly:(NSDictionary *)hourly
{
    if (self = [super init])
    {
    _currently = currently;
    _daily = daily;
    _hourly = hourly;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    return nil;
}


@end
