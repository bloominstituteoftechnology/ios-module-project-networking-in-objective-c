//
//  LSIDailyWeather.m
//  DailyWeather
//
//  Created by Kelson Hartle on 7/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForecast.h"

@implementation LSIDailyForecast

- (instancetype)initWithTime:(NSDate *)time
                 summary:(NSString *)summary
                    icon:(NSString *)icon
             sunriseTime:(NSDate *)sunriseTime
              sunsetTime:(NSDate *)sunsetTime
  precipitationIntensity:(NSNumber *)precipitationIntensity
precipitationProbability:(NSNumber *)precipitationProbability
       precipitationType:(NSString *)precipitationType
          temperatureLow:(NSNumber *)temperatureLow
         temperatureHigh:(NSNumber *)temperatureHigh
     apparentTemperature:(NSNumber *)apparentTemperature
                humidity:(NSNumber *)humidity
                pressure:(NSNumber *)pressure
               windSpeed:(NSNumber *)windSpeed
             windBearing:(NSNumber *)windBearing
                     uvIndex:(NSNumber *)uvIndex; {
    
    self = [super init];
    if (self) {
        _time = time;
        _summary = [summary copy];
        _icon = [icon copy];
        _sunriseTime = sunriseTime;
        _sunsetTime = sunsetTime;
        _precipitationIntensity = precipitationIntensity;
        _precipitationProbability = precipitationProbability;
        _precipitationType = [precipitationType copy];
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

-(instancetype)initWithDictionary:(NSDictionary *)dictionary; {
    
    NSNumber *timeNumber = dictionary[@"time"];
    NSString *summary = dictionary[@"summary"];
    NSString *icon = dictionary[@"icon"];
    NSNumber *sunriseTimeNumber = dictionary[@"sunriseTime"];
    NSNumber *sunsetTimeNumber = dictionary[@"sunsetTime"];
    NSNumber *precipitationIntensity = dictionary[@"precipIntensity"];
    NSNumber *precipitationProbability = dictionary[@"precipProbability"];
    NSString *precipitationType = dictionary[@"precipType"];
    NSNumber *temperatureLow = dictionary[@"temperatureLow"];
    NSNumber *temperatureHigh = dictionary[@"temperatureHigh"];
    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];

    double timeForTimeInMiliseconds = timeNumber.doubleValue;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970: timeForTimeInMiliseconds / 1000.0];
    
    double sunsetInMiliseconds = sunsetTimeNumber.doubleValue;
    NSDate *sunsetTime = [NSDate dateWithTimeIntervalSince1970: sunsetInMiliseconds / 1000.0];
    double sunriseInMiliseconds = sunriseTimeNumber.doubleValue;
    NSDate *sunriseTime = [NSDate dateWithTimeIntervalSince1970: sunriseInMiliseconds / 1000.0];
    
    // TODO: create functions like the ones below for all the dates.
    
    if ([precipitationProbability isKindOfClass:[NSNull class]]) {
        precipitationProbability= nil;
    }
    if ([precipitationType isKindOfClass:[NSNull class]]) {
        precipitationType= nil;
    }
    if ([temperatureLow isKindOfClass:[NSNull class]]) {
        temperatureLow = nil;
    }
    if ([temperatureHigh isKindOfClass:[NSNull class]]) {
        temperatureHigh= nil;
    }
    if ([apparentTemperature isKindOfClass:[NSNull class]]) {
        apparentTemperature = nil;
    }
    if ([humidity isKindOfClass:[NSNull class]]) {
        humidity = nil;
    }
    if ([pressure isKindOfClass:[NSNull class]]) {
        pressure = nil;
    }
    if ([windSpeed isKindOfClass:[NSNull class]]) {
        windSpeed = nil;
    }
    if ([windBearing isKindOfClass:[NSNull class]]) {
        windBearing = nil;
    }
    if ([uvIndex isKindOfClass:[NSNull class]]) {
        uvIndex = nil;
    }
    
    return [self initWithTime:time summary:summary icon:icon sunriseTime:sunriseTime sunsetTime:sunsetTime precipitationIntensity:precipitationIntensity precipitationProbability:precipitationProbability precipitationType:precipitationType temperatureLow:temperatureLow temperatureHigh:temperatureHigh apparentTemperature:apparentTemperature humidity:humidity pressure:pressure windSpeed:windSpeed windBearing:windBearing uvIndex:uvIndex];

}

@end
