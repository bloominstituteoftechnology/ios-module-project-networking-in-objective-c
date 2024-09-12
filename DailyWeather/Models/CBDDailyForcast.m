//
//  CBDDailyForcast.m
//  DailyWeather
//
//  Created by Christopher Devito on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CBDDailyForcast.h"

@implementation CBDDailyForcast

- (instancetype)initWithTemperatureLow:(NSNumber *)temperatureLow
                       temperatureHigh:(NSNumber *)temperatureHigh
                           sunriseTime:(NSDate *)sunriseTime
                            sunsetTime:(NSDate *)sunsetTime
                            precipType:(NSString *)precipType
                                  time:(NSDate *)time
                               summary:(NSString *)summary
                                  icon:(NSString *)icon
                     precipProbability:(NSNumber *)precipProbability
                       precipIntensity:(NSNumber *)precipIntensity
                              humidity:(NSNumber *)humidity
                              pressure:(NSNumber *)pressure
                             windSpeed:(NSNumber *)windSpeed
                           windBearing:(NSNumber *)windBearing
                               uvIndex:(NSNumber *)uvIndex {
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
    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSString *precipType = dictionary[@"precipType"];
    NSNumber *temperatureLow = dictionary[@"temperatureLow"];
    NSNumber *temperatureHigh = dictionary[@"temperatureHigh"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];
    
    double timeInMilliseconds = timeNumber.doubleValue;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds/1000.0];
    double sunriseTimeInMilliseconds = sunriseTimeNumber.doubleValue;
    NSDate *sunriseTime = [NSDate dateWithTimeIntervalSince1970:sunriseTimeInMilliseconds/1000.0];
    double sunsetTimeInMilliseconds = sunsetTimeNumber.doubleValue;
    NSDate *sunsetTime = [NSDate dateWithTimeIntervalSince1970:sunsetTimeInMilliseconds/1000.0];
    
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
