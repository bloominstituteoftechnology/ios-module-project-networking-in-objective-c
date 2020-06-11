//
//  HSIHourlyWeather.m
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import "HSIHourlyForecast.h"

@implementation HSIHourlyForecast

- (instancetype) initWithTime:(NSDate *)time
                      summary:(NSString *)summary
                         icon:(NSString *)icon
            precipProbability:(double)precipProbability
              precipIntensity:(double)precipIntensity
                   precipType:(NSString *)precipType
               temperatureLow:(double)temperatureLow
              temperatureHigh:(double)temperatureHigh
          apparentTemperature:(double)apparentTemperature
                     humidity:(double)humidity
                     pressure:(double)pressure
                    windSpeed:(double)windSpeed
                  windBearing:(double)windBearing
                      uvIndex:(double)uvIndex
{
    self = [super init];
    if (self) {
        _time = time;
        _summary = [summary copy];
        _icon = [icon copy];
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _temperatureLow = temperatureLow;
        _temperatureHigh = temperatureHigh;
        _apparentTemperature = apparentTemperature;
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
        _uvIndex = uvIndex;
    }
    return self;
}

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    
    return nil;
}

@end
