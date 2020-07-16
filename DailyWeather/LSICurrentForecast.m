//
//  LSICurrentForecast.m
//  DailyWeather
//
//  Created by Kelson Hartle on 7/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSICurrentForecast.h"

@implementation LSICurrentForecast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
      precipitationIntensity:(NSNumber *)precipitationIntensity
    precipitationProbability:(NSNumber *)precipitationProbability
                 temperature:(NSNumber *)temperature
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
        _precipitationIntensity = precipitationIntensity;
        _precipitationProbability = precipitationProbability;
        _temperature = temperature;
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
    NSNumber *precipitationIntensity = dictionary[@"precipIntensity"];
    NSNumber *precipitationProbability = dictionary[@"precipProbability"];
    NSNumber *temperature = dictionary[@"temperature"];
    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];

    double timeInMiliseconds = timeNumber.doubleValue;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970: timeInMiliseconds / 1000.0];
    
    if ([precipitationProbability isKindOfClass:[NSNull class]]) {
        precipitationProbability= nil;
    }
    if ([temperature isKindOfClass:[NSNull class]]) {
        temperature = nil;
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
    
    return [self initWithTime:time summary:summary icon:icon precipitationIntensity:precipitationProbability precipitationProbability:precipitationIntensity temperature:temperature apparentTemperature:apparentTemperature humidity:humidity pressure:pressure windSpeed:windSpeed windBearing:windBearing uvIndex:uvIndex];

}




@end
