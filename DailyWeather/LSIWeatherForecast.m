//
//  LSIWeatherForecast.m
//  DailyWeather
//
//  Created by Chris Gonzales on 4/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForecast.h"

@implementation LSIWeatherForecast

//- (instancetype)initWithTime:(NSDate *)time
//                     summary:(NSString *)summary
//               icon:(NSString *)icon
//  precipProbability:(NSNumber *)precipProbability
//    precipIntensity:(NSNumber *)precipIntensity
//        temperature:(NSNumber *)temperature
//apparentTemperature:(NSNumber *)apparentTemperature
//           humidity:(NSNumber *)humidity
//           pressure:(NSNumber *)pressure
//          windSpeed:(NSNumber *)windSpeed
//        windBearing:(NSNumber *)windBearing
//                     uvIndex:(NSNumber *)uvIndex {
//    self = [super init];
//    if (self) {
//        _time = time;
//        _summary = summary;
//        _icon = icon;
//        _precipProbability = precipProbability;
//        _precipIntensity = precipIntensity;
//        _temperature = temperature;
//        _apparentTemperature = apparentTemperature;
//        _humidity = humidity;
//        _pressure = pressure;
//        _windSpeed = windSpeed;
//        _windBearing = windBearing;
//        _uvIndex = uvIndex;
//    }
//    return self;
//}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    // Containers
    NSDictionary *currently = dictionary[@"currently"];
    
    // Non-optional values in JSON
    NSNumber *timeInUnix = currently[@"time"];
    
    // Optional values in JSON
    NSString *summary = currently[@"summary"];
    NSString *icon = currently[@"icon"];
    NSNumber *precipProbability = currently[@"precipProbability"];
    NSNumber *precipIntensity = currently[@"precipIntensity"];
    NSNumber *temperature = currently[@"temperature"];
    NSNumber *apparentTemperature = currently[@"apparentTemperature"];
    NSNumber *humidity = currently[@"humidity"];
    NSNumber *pressure = currently[@"pressure"];
    NSNumber *windSpeed = currently[@"windSpeed"];
    NSNumber *windBearing = currently[@"windBearing"];
    NSNumber *uvIndex= currently[@"uvIndex"];
    
    if ([summary isKindOfClass:[NSNull class]]) {
        summary = nil;
    }
    if ([icon isKindOfClass:[NSNull class]]) {
        icon = nil;
    }
    if ([precipProbability isKindOfClass:[NSNull class]]) {
        precipProbability = nil;
    }
    if ([precipIntensity isKindOfClass:[NSNull class]]) {
           precipIntensity = nil;
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
    
    if (timeInUnix) {
//        double timeDouble = [NSDate dateWithTimeIntervalSince1970:timeInUnix.longValue];
        _time = [NSDate dateWithTimeIntervalSince1970:timeInUnix.longValue];
        _summary = summary;
        _icon = icon;
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _temperature = temperature;
        _apparentTemperature = apparentTemperature;
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
        _uvIndex = uvIndex;

        //Move to View Controller
//        NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
//        [formatter setLocale:[NSLocale currentLocale]];
//        [formatter setDateFormat:@"dd.MM.yyyy"];
//        NSString *dateString = [formatter stringFromDate:_time];
    }
        
    return self;
}
@end
