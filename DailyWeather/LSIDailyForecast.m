//
//  LSIDailyForecast.m
//  DailyWeather
//
//  Created by Lydia Zhang on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForecast.h"

@implementation LSIDailyForecast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
                 sunriseTime:(NSNumber *)sunriseTime
                  sunsetTime:(NSNumber *)sunsetTime
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
        _sunriseTime = sunriseTime;
        _sunsetTime = sunsetTime;
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


- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    
    NSDate *time = dictionary[@"time"];
    NSString *summary = dictionary[@"summary"];
    NSString *icon = dictionary[@"icon"];
    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSNumber *sunriseTime = dictionary[@"sunriseTime"];
    NSNumber *sunsetTime = dictionary[@"sunsetTime"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSString *precipType = dictionary[@"precipType"];
    NSNumber *temperatureLow = dictionary[@"temperatureLow"];
    NSNumber *temperatureHigh = dictionary[@"temperatureHigh"];
    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];
    
    if([summary isKindOfClass:[NSNull class]]) {
        summary = nil;
    }

    if([icon isKindOfClass:[NSNull class]]) {
        icon = nil;
    }

    if([precipProbability isKindOfClass:[NSNull class]]) {
        precipProbability = nil;
    }

    if([sunriseTime isKindOfClass:[NSNull class]]) {
        sunriseTime = nil;
    }

    if([sunsetTime isKindOfClass:[NSNull class]]) {
        sunsetTime = nil;
    }

    if([precipIntensity isKindOfClass:[NSNull class]]) {
        precipIntensity = nil;
    }

    if([precipType isKindOfClass:[NSNull class]]) {
        precipType = nil;
    }

    if([temperatureLow isKindOfClass:[NSNull class]]) {
        temperatureLow = nil;
    }

    if([temperatureHigh isKindOfClass:[NSNull class]]) {
        temperatureHigh = nil;
    }

    if([apparentTemperature isKindOfClass:[NSNull class]]) {
        apparentTemperature = nil;
    }

    if([humidity isKindOfClass:[NSNull class]]) {
        humidity = nil;
    }

    if([pressure isKindOfClass:[NSNull class]]) {
        pressure = nil;
    }

    if([windSpeed isKindOfClass:[NSNull class]]) {
        windSpeed = nil;
    }

    if([windBearing isKindOfClass:[NSNull class]]) {
        windBearing = nil;
    }

    if([uvIndex isKindOfClass:[NSNull class]]) {
        uvIndex = nil;
    }

    return [self initWithTime:time
                      summary:summary
                         icon:icon
                  sunriseTime:sunriseTime
                   sunsetTime:sunsetTime
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
    
}



@end
