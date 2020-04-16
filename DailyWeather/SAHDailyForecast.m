//
//  SAHDailyForecast.m
//  DailyWeather
//
//  Created by scott harris on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "SAHDailyForecast.h"

@implementation SAHDailyForecast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
                 sunriseTime:(NSDate *)sunriseTime
                  sunsetTime:(NSDate *)sunsetTime
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
                  precipType:(NSString *)precipType
             temperatureHigh:(double)temperatureHigh
              temperatureLow:(double)temperatureLow
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
        _sunriseTime = sunriseTime;
        _sunsetTime = sunsetTime;
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _precipType = precipType;
        _temperatureHigh = temperatureHigh;
        _temperatureLow = temperatureLow;
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
    NSNumber *sunriseNumber = dictionary[@"sunriseTime"];
    NSNumber *sunsetNumber = dictionary[@"sunsetTime"];
    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSString *precipType = dictionary[@"precipType"];
    NSNumber *temperatureHigh = dictionary[@"temperatureHigh"];
    NSNumber *temperatureLow = dictionary[@"temperatureLow"];
    NSNumber *apparentTemperature = dictionary[@"apparentTemperatureHigh"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue];
    
    NSDate *sunriseTime = [NSDate dateWithTimeIntervalSince1970:sunriseNumber.longValue];
    NSDate *sunsetTime = [NSDate dateWithTimeIntervalSince1970:sunsetNumber.longValue];
    
    if (time && summary && icon && sunriseTime && sunsetTime && precipProbability && precipIntensity && precipType && temperatureHigh && temperatureLow && apparentTemperature && humidity && pressure && windSpeed && windBearing && uvIndex) {
        
        self = [self initWithTime:time summary:summary icon:icon sunriseTime:sunriseTime sunsetTime:sunsetTime precipProbability:precipProbability.doubleValue precipIntensity:precipIntensity.doubleValue precipType:precipType temperatureHigh:temperatureHigh.doubleValue temperatureLow:temperatureLow.doubleValue apparentTemperature:apparentTemperature.doubleValue humidity:humidity.doubleValue pressure:pressure.doubleValue windSpeed:windSpeed.doubleValue windBearing:windBearing.doubleValue uvIndex:uvIndex.doubleValue];
        
    }
    
    return self;
    
    
}


@end
