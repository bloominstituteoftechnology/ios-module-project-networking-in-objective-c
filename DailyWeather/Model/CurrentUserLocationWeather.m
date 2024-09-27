//
//  CurrentUserLocationWeather.m
//  DailyWeather
//
//  Created by Nick Nguyen on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CurrentUserLocationWeather.h"

@implementation CurrentUserLocationWeather

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
                 temperature:(double )temperature
                    humidity:(double )humidity
                    pressure:(double )pressure
                   windSpeed:(double )windSpeed
                     uvIndex:(int )uvIndex
                  visibility:(int )visibility
{
    self = [super init];
    if (self) {
        _time = time ;
        _summary = summary;
        _icon = icon;
        _temperature = temperature;
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _uvIndex = uvIndex;
        _visibility = visibility;
    }
    return self;
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSDictionary *currently = dictionary[@"currently"];
    
    NSNumber *timeNumber = currently[@"time"];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue / 1000.0];
    
    NSString *summary = currently[@"summary"];
    NSString *icon = currently[@"icon"];
    NSNumber *temperature = currently[@"temperature"];
    NSNumber *humidity = currently[@"humidity"];
    NSNumber *pressure = currently[@"pressure"];
    NSNumber *windSpeed = currently[@"windSpeed"];
    NSNumber *uvIndex = currently[@"uvIndex"];
    NSNumber *visibility = currently[@"visibility"];
    
    self = [self initWithTime:time
                      summary:summary
                         icon:icon
                  temperature:temperature.doubleValue
                     humidity:humidity.doubleValue
                     pressure:pressure.doubleValue
                    windSpeed:windSpeed.doubleValue
                      uvIndex:uvIndex.intValue
                   visibility:visibility.intValue];
    return self;
    
}

@end
