//
//  CBDDailyForcast.m
//  DailyWeather
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CBDDailyForcast.h"

@implementation CBDDailyForcast

- (instancetype)initWithTemperatureLow:(double)temperatureLow
                       temperatureHigh:(double)temperatureHigh
                           sunriseTime:(NSDate *)sunriseTime
                            sunsetTime:(NSDate *)sunsetTime
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
        _sunriseTime = sunriseTime;
        _sunsetTime = sunsetTime;
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
    NSString *sunriseTimeNumber = dictionary[@"sunriseTime"];
    NSString *sunsetTimeNumber = dictionary[@"sunsetTime"];
    NSNumber *precipProbabilityNumber = dictionary[@"precipProbability"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSString *precipType = dictionary[@"precipType"];
    NSNumber *temperatureLowNumber = dictionary[@"temperatureLow"];
    NSNumber *temperatureHighNumber = dictionary[@"temperatureHigh"];
    NSNumber *humidityNumber = dictionary[@"humidity"];
    NSNumber *pressureNumber = dictionary[@"pressure"];
    NSNumber *windSpeedNumber = dictionary[@"windSpeed"];
    NSNumber *windBearingNumber = dictionary[@"windBearing"];
    NSNumber *uvIndexNumber = dictionary[@"uvIndex"];
    
    double timeInMilliseconds = timeNumber.doubleValue;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds/1000.0];
    double sunriseTimeInMilliseconds = sunriseTimeNumber.doubleValue;
    NSDate *sunriseTime = [NSDate dateWithTimeIntervalSince1970:sunriseTimeInMilliseconds/1000.0];
    double sunsetTimeInMilliseconds = sunsetTimeNumber.doubleValue;
    NSDate *sunsetTime = [NSDate dateWithTimeIntervalSince1970:sunsetTimeInMilliseconds/1000.0];
    double precipProbability = precipProbabilityNumber.doubleValue;
    double temperatureLow = temperatureLowNumber.doubleValue;
    double temperatureHigh = temperatureHighNumber.doubleValue;
    double humidity = humidityNumber.doubleValue;
    double pressure = pressureNumber.doubleValue;
    double windSpeed = windSpeedNumber.doubleValue;
    double windBearing = windBearingNumber.doubleValue;
    double uvIndex = uvIndexNumber.doubleValue;
    
    return [self initWithTemperatureLow:temperatureLow
                        temperatureHigh:temperatureHigh
                            sunriseTime:sunriseTime
                             sunsetTime:sunsetTime
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
