//
//  CBDHourlyForcast.m
//  DailyWeather
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CBDHourlyForcast.h"

@implementation CBDHourlyForcast

- (instancetype)initWithTemperatureLow:(NSNumber *)temperatureLow
                       temperatureHigh:(NSNumber *)temperatureHigh
                   apparentTemperature:(double)apparentTemperature
                           temperature:(NSNumber *)temperature
                            precipType:(NSString *)precipType
                                  time:(NSDate *)time
                               summary:(NSString *)summary
                                  icon:(NSString *)icon
                     precipProbability:(double)precipProbability
                       precipIntensity:(NSNumber *)precipIntensity
                              humidity:(double)humidity
                              pressure:(double)pressure
                             windSpeed:(double)windSpeed
                           windBearing:(double)windBearing
                               uvIndex:(double)uvIndex {
    self = [super init];
    if (self) {
        _temperatureLow = temperatureLow;
        _temperatureHigh = temperatureHigh;
        _apparentTemperature = apparentTemperature;
        _temperature = temperature;
        _precipType = precipType;
        self.time = time;
        self.summary = summary;
        self.icon = icon;
        self.precipProbability = precipProbability;
        self.precipIntensity = precipIntensity;
        self.humidity = humidity;
        self.pressure = pressure;
        self.windSpeed = windSpeed;
        self.windBearing = windBearing;
        self.uvIndex = uvIndex;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSNumber *timeNumber = dictionary[@"time"];
    NSString *summary = dictionary[@"summary"];
    NSString *icon = dictionary[@"icon"];
    NSNumber *precipProbabilityNumber = dictionary[@"precipProbability"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSString *precipType = dictionary[@"precipType"];
    NSNumber *temperatureLow = dictionary[@"temperatureLow"];
    NSNumber *temperatureHigh = dictionary[@"temperatureHigh"];
    NSNumber *temperature = dictionary[@"temperature"];
    NSNumber *apparentTemperatureNumber = dictionary[@"apparentTemperature"];
    NSNumber *humidityNumber = dictionary[@"humidity"];
    NSNumber *pressureNumber = dictionary[@"pressure"];
    NSNumber *windSpeedNumber = dictionary[@"windSpeed"];
    NSNumber *windBearingNumber = dictionary[@"windBearing"];
    NSNumber *uvIndexNumber = dictionary[@"uvIndex"];
    
    double timeInMilliseconds = timeNumber.doubleValue;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds/1000.0];
    double precipProbability = precipProbabilityNumber.doubleValue;
    double apparentTemperature = apparentTemperatureNumber.doubleValue;
    double humidity = humidityNumber.doubleValue;
    double pressure = pressureNumber.doubleValue;
    double windSpeed = windSpeedNumber.doubleValue;
    double windBearing = windBearingNumber.doubleValue;
    double uvIndex = uvIndexNumber.doubleValue;
    
    if (!precipIntensity || [precipIntensity isKindOfClass:[NSNull class]]) {
        precipIntensity = nil;
    }
    if (!precipType || [precipType isKindOfClass:[NSNull class]]) {
        precipType = nil;
    }
    if (!temperatureLow || [temperatureLow isKindOfClass:[NSNull class]]) {
        temperatureLow = nil;
    }
    if (!temperatureHigh || [temperatureHigh isKindOfClass:[NSNull class]]) {
        temperatureHigh = nil;
    }
    if (!temperature || [temperature isKindOfClass:[NSNull class]]) {
        temperature = nil;
    }
    
    return [self initWithTemperatureLow:temperatureLow
                        temperatureHigh:temperatureHigh
                    apparentTemperature:apparentTemperature
                            temperature:temperature
                             precipType:precipType
                                   time:time
                                summary:summary
                                   icon:icon
                      precipProbability:precipProbability
                        precipIntensity:precipIntensity
                               humidity:humidity
                               pressure:pressure
                              windSpeed:windSpeed
                            windBearing:windBearing
                                uvIndex:uvIndex];
}


@end
