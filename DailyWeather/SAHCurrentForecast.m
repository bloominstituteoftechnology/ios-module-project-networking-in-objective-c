//
//  SAHCurrentForecast.m
//  DailyWeather
//
//  Created by scott harris on 4/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "SAHCurrentForecast.h"

@implementation SAHCurrentForecast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
                 temperature:(double)temperature
         apparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(double)windBearing
                     uvIndex:(double)uvIndex {
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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSNumber *timeNumber = dictionary[@"time"];
    NSString *summary = dictionary[@"summary"];
    NSString *icon = dictionary[@"icon"];
    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSNumber *temperature = dictionary[@"temperature"];
    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeNumber.longLongValue];
    
    if (time && summary && icon && precipProbability && precipIntensity && temperature && apparentTemperature && humidity && pressure && windSpeed && windBearing && uvIndex) {
        
        self = [self initWithTime:time summary:summary icon:icon precipProbability:precipProbability.doubleValue precipIntensity:precipIntensity.doubleValue temperature:temperature.doubleValue apparentTemperature:apparentTemperature.doubleValue humidity:humidity.doubleValue pressure:pressure.doubleValue windSpeed:windSpeed.doubleValue windBearing:windBearing.doubleValue uvIndex:uvIndex.doubleValue];
    }
    
    return self;
    
    
}

@end
