//
//  LSIHourlyForecast.m
//  DailyWeather
//
//  Created by Karen Rodriguez on 5/12/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIHourlyForecast.h"

@implementation LSIHourlyForecast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(NSNumber *)precipProbability
             precipIntensity:(NSNumber *)precipIntensity
                  precipType:(NSString *)precipType
              temperatureLow:(NSNumber *)temperatureLow
             temperatureHigh:(NSNumber *)temperatureHigh
         apparentTemperature:(NSNumber *)apparentTemperature
                    humidity:(NSNumber *)humidity
                    pressure:(NSNumber *)pressure
                   windSpeed:(NSNumber *)windSpeed
                 windBearing:(NSNumber *)windBearing
                     uvIndex:(NSNumber *)uvIndex {
    self = [super init];
    if (self) {
        _time = time;
        _summary = [summary copy];
        _icon = [icon copy];
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _precipType = [precipType copy];
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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    // No need for containers
    // Temporary properties to check for nil
    NSDate *time = dictionary[@"time"];

    // Optional checker boilerplate code snippet;
    // if([<#variable#> isKindOfClass:[NSNull class]]) { <#variable#> = nil; }
    NSString *summary = dictionary[@"summary"];
    if([summary isKindOfClass:[NSNull class]]) { summary = nil; }

    NSString *icon = dictionary[@"icon"];
    if([icon isKindOfClass:[NSNull class]]) { icon = nil; }

    NSNumber *precipProbability = dictionary[@"precipProbability"];
    if([precipProbability isKindOfClass:[NSNull class]]) { precipProbability = nil; }

    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    if([precipIntensity isKindOfClass:[NSNull class]]) { precipIntensity = nil; }

    NSString *precipType = dictionary[@"precipType"];
    if([precipType isKindOfClass:[NSNull class]]) { precipType = nil; }

    NSNumber *temperatureLow = dictionary[@"temperatureLow"];
    if([temperatureLow isKindOfClass:[NSNull class]]) { temperatureLow = nil; }

    NSNumber *temperatureHigh = dictionary[@"temperatureHigh"];
    if([temperatureHigh isKindOfClass:[NSNull class]]) { temperatureHigh = nil; }

    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
    if([apparentTemperature isKindOfClass:[NSNull class]]) { apparentTemperature = nil; }

    NSNumber *humidity = dictionary[@"humidity"];
    if([humidity isKindOfClass:[NSNull class]]) { humidity = nil; }

    NSNumber *pressure = dictionary[@"pressure"];
    if([pressure isKindOfClass:[NSNull class]]) { pressure = nil; }

    NSNumber *windSpeed = dictionary[@"windSpeed"];
    if([windSpeed isKindOfClass:[NSNull class]]) { windSpeed = nil; }

    NSNumber *windBearing = dictionary[@"windBearing"];
    if([windBearing isKindOfClass:[NSNull class]]) { windBearing = nil; }

    NSNumber *uvIndex = dictionary[@"uvIndex"];
    if([uvIndex isKindOfClass:[NSNull class]]) { uvIndex = nil; }

    self = [self initWithTime:time
                      summary:summary
                         icon:icon
            precipProbability:precipProbability
              precipIntensity:precipIntensity
                   precipType:precipType
               temperatureLow:temperatureLow
              temperatureHigh:temperatureHigh
          apparentTemperature:apparentTemperature
                     humidity:humidity
                     pressure:pressure
                    windSpeed:windSpeed
                  windBearing:windBearing
                      uvIndex:uvIndex];

    return self;
}

@end
