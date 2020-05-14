//
//  LSIWeatherConditions.m
//  DailyWeather
//
//  Created by Shawn Gee on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherConditions.h"

@implementation LSIWeatherConditions

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSNumber *timeNumber = dictionary[@"time"];
    NSString *summary = dictionary[@"summary"];
    NSString *iconString = dictionary[@"icon"];
    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSString *precipType = dictionary[@"precipType"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *sunriseTimeNumber = dictionary[@"sunriseTime"];
    NSNumber *sunsetTimeNumber = dictionary[@"sunsetTime"];
    NSNumber *temperature = dictionary[@"temperature"];
    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
    NSNumber *temperatureLow = dictionary[@"temperatureLow"];
    NSNumber *temperatureHigh = dictionary[@"temperatureHigh"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];
    
    if (self = [super init]) {
        _time = [NSDate dateWithTimeIntervalSince1970:timeNumber.intValue];
        _summary = [summary copy];
        _iconString = [iconString copy];
        _precipProbabilty = precipProbability;
        _precipIntensity = precipIntensity;
        _precipType = precipType;
        _humidity = humidity;
        _pressure = pressure;
        _sunriseTime = [NSDate dateWithTimeIntervalSince1970:sunriseTimeNumber.intValue];
        _sunsetTime = [NSDate dateWithTimeIntervalSince1970:sunsetTimeNumber.intValue];
        _temperature = temperature;
        _apparentTemperature = apparentTemperature;
        _temperatureLow = temperatureLow;
        _temperatureHigh = temperatureHigh;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
        _uvIndex = uvIndex;
    }
    
    return self;
}

@end
