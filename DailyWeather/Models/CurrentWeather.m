//
//  CurrentWeather.m
//  DailyWeather
//
//  Created by Cody Morley on 7/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CurrentWeather.h"

@implementation CurrentWeather

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(UIImage *)icon
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
                 temperature:(double)temperature
        appparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(int)windBearing
                     uvIndex:(int)uvIndex
{
    self = [super init];
    if (self) {
        _time = time;
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
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _time = dictionary[@"time"];
        _summary = dictionary[@"summary"];
        _temperature = [dictionary[@"temperature"] doubleValue];
        _icon = dictionary[@"icon"];
    }
    
//    NSDictionary *currentForecast = dictionary;
//
//    NSNumber *timeNumber = currentForecast[@"time"];
//    NSDate *time = [NSDate dateWithTimeIntervalSince1970: timeNumber.longValue];
//
//    NSString *summary = currentForecast[@"summary"];
//
//    NSString *iconString = currentForecast[@"icon"];
//    UIImage *image = [UIImage imageNamed: (@"%@", iconString)];
//
//    NSNumber *precipProbability = currentForecast[@"precipProbability"];
//    NSNumber *precipIntensity = currentForecast[@"precipIntensity"];
//    NSNumber *temperature = currentForecast[@"temperature"];
//    NSNumber *apparentTemperature = currentForecast[@"apparentTemperature"];
//    NSNumber *humidty = currentForecast[@"humidity"];
//    NSNumber *pressure = currentForecast[@"pressure"];
//    NSNumber *windSpeed = currentForecast[@"windSpeed"];
//    NSNumber *windBearing = currentForecast[@"windBearing"];
//    NSNumber *uvIndex = currentForecast[@"uvIndex"];
//
//    if (!( time && temperature && precipProbability && humidty)) {
//        return nil;
//    }
//
//    self = [self initWithTime: time
//                      summary: summary
//                         icon: image
//            precipProbability: precipProbability.doubleValue
//              precipIntensity: precipIntensity.doubleValue
//                  temperature: temperature.doubleValue
//         appparentTemperature: apparentTemperature.doubleValue
//                     humidity: humidty.doubleValue
//                     pressure: pressure.doubleValue
//                    windSpeed: windSpeed.doubleValue
//                  windBearing: windBearing.intValue
//                      uvIndex: uvIndex.intValue];
//    return self;
}

@end
