//
//  LSIDailyForecast.m
//  DailyWeather
//
//  Created by Michael on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForecast.h"

@implementation LSIDailyForecast

- (instancetype)initWithTime:(NSDate *)time
                sunsriseTime:(NSDate *)sunriseTime
                  sunsetTime:(NSDate *)sunsetTime
                     summary:(NSString *)summary
                        icon:(NSString *)icon
                  precipType:(NSString *)precipType
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
              temperatureLow:(double)temperatureLow
             temperatureHigh:(double)temperatureHigh
     apparentTemperatureHigh:(double)apparentTemperatureHigh
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(double)windBearing
                     uvIndex:(double)uvIndex {
    
    self = [super init];
    if (self) {
        _time = time;
        _sunriseTime = sunsetTime;
        _sunsetTime = sunsetTime;
        _summary = summary;
        _icon = icon;
        _precipType = precipType;
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _temperatureLow = temperatureLow;
        _temperatureHigh = temperatureHigh;
        _apparentTemperatureHigh = apparentTemperatureHigh;
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
        _uvIndex = uvIndex;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        NSNumber *timeNumber = dictionary[@"time"];
        NSNumber *sunriseTimeNumber = dictionary[@"sunriseTime"];
        NSNumber *sunsetTimeNumber = dictionary[@"sunsetTime"];
        NSString *summary = dictionary[@"summary"];
        NSString *icon = dictionary[@"icon"];
        NSString *precipType = dictionary[@"precipType"];
        NSNumber *precipProbability = dictionary[@"precipProbability"];
        NSNumber *precipIntensity = dictionary[@"precipIntensity"];
        NSNumber *temperatureLow = dictionary[@"temperatureLow"];
        NSNumber *temperatureHigh = dictionary[@"temperatureHigh"];
        NSNumber *apparentTemperatureHigh = dictionary[@"apparentTemperatureHigh"];
        NSNumber *humidity = dictionary[@"humidity"];
        NSNumber *pressure = dictionary[@"pressure"];
        NSNumber *windSpeed = dictionary[@"windSpeed"];
        NSNumber *windBearing = dictionary[@"windBearing"];
        NSNumber *uvIndex = dictionary[@"uvIndex"];
        
        
        _time = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue];
        _sunriseTime = [NSDate dateWithTimeIntervalSince1970:sunriseTimeNumber.longValue];
        _sunsetTime = [NSDate dateWithTimeIntervalSince1970:sunsetTimeNumber.longValue];
        _summary = summary;
        _icon = icon;
        _precipType = precipType;
        _precipProbability = [precipProbability doubleValue];
        _precipIntensity = [precipIntensity doubleValue];
        _temperatureLow = [temperatureLow doubleValue];
        _temperatureHigh = [temperatureHigh doubleValue];
        _apparentTemperatureHigh = [apparentTemperatureHigh doubleValue];
        _humidity = [humidity doubleValue];
        _pressure = [pressure doubleValue];
        _windSpeed = [windSpeed doubleValue];
        _windBearing = [windBearing doubleValue];
        _uvIndex = [uvIndex doubleValue];
        
    }
    return self;
}

@end
