//
//  CBDCurrentForcast.m
//  DailyWeather
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CBDCurrentForcast.h"

@implementation CBDCurrentForcast

- (instancetype)initWithTemperature:(double)temperature
                apparentTemperature:(double)apparentTemperature
                               time:(NSDate *)time
                            summary:(NSString *)summary
                               icon:(NSString *)icon
                  precipProbability:(double)precipProbability
                    precipIntensity:(double)precipIntensity
                           humidity:(double)humidity
                           pressure:(double)pressure
                          windSpeed:(double)windSpeed
                        windBearing:(double)windBearing
                            uvIndex:(double)uvIndex {
    self = [super init];
    if (self) {
        _temperature = temperature;
        _apparentTemperature = apparentTemperature;
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
    NSNumber *precipIntensityNumber = dictionary[@"precipIntensity"];
    NSNumber *temperatureNumber = dictionary[@"temperature"];
    NSNumber *apparentTemperatureNumber = dictionary[@"apparentTemperature"];
    NSNumber *humidityNumber = dictionary[@"humidity"];
    NSNumber *pressureNumber = dictionary[@"pressure"];
    NSNumber *windSpeedNumber = dictionary[@"windSpeed"];
    NSNumber *windBearingNumber = dictionary[@"windBearing"];
    NSNumber *uvIndexNumber = dictionary[@"uvIndex"];
    
    double timeInMilliseconds = timeNumber.doubleValue;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds/1000.0];
    double precipProbability = precipProbabilityNumber.doubleValue;
    double precipIntensity = precipIntensityNumber.doubleValue;
    double temperature = temperatureNumber.doubleValue;
    double apparentTemperature = apparentTemperatureNumber.doubleValue;
    double humidity = humidityNumber.doubleValue;
    double pressure = pressureNumber.doubleValue;
    double windSpeed = windSpeedNumber.doubleValue;
    double windBearing = windBearingNumber.doubleValue;
    double uvIndex = uvIndexNumber.doubleValue;
    
    
    return [self initWithTemperature:temperature
                 apparentTemperature:apparentTemperature
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
