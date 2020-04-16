//
//  LSIHourlyForecast.m
//  DailyWeather
//
//  Created by Ufuk Türközü on 16.04.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIHourlyForecast.h"

@implementation LSIHourlyForecast

- (instancetype)initWithTime:(NSDate *)time
                        icon:(NSString *)icon
             temperatureHigh:(double)temperatureHigh
              temperatureLow:(double)temperatureLow
             precipIntensity:(double)precipIntensity
           precipProbability:(double)precipProbability
                  percipType:(NSString *)percipType
         apparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(double)windBearing
                     uvIndex:(double)uvIndex {
    self = [super init];
    if (self) {
        _time = time;
        _icon = icon;
        _temperatureHigh = temperatureHigh;
        _temperatureLow = temperatureLow;
        _precipIntensity = precipIntensity;
        _precipProbability = precipProbability;
        _percipType = percipType;
        _apparentTemperature = apparentTemperature;
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
        _uvIndex = uvIndex;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSNumber *timeNumber = dictionary[@"time"];
    NSString *icon = dictionary[@"icon"];
    NSNumber *temperatureHigh = dictionary[@"temperatureHigh"];
    NSNumber *temperatureLow = dictionary[@"temperatureLow"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSString *percipType = dictionary[@"percipType"];
    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue];
    
    self = [self initWithTime:time
                         icon:icon
              temperatureHigh:temperatureHigh.doubleValue
               temperatureLow:temperatureLow.doubleValue
              precipIntensity:precipIntensity.doubleValue precipProbability:precipProbability.doubleValue
                   percipType:percipType
          apparentTemperature:apparentTemperature.doubleValue
                     humidity:humidity.doubleValue
                     pressure:pressure.doubleValue
                    windSpeed:windSpeed.doubleValue
                  windBearing:windBearing.doubleValue
                      uvIndex:uvIndex.doubleValue];
    return self;
}

@end
