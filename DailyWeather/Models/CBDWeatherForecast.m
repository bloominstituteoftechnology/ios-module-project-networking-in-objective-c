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

- (instancetype)initWithCurrentForecast:(CBDCurrentForecast *)currentForecast
                        hourlyForecasts:(NSArray *)hourlyForecasts
                         dailyForecasts:(NSArray *)dailyForecasts;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
