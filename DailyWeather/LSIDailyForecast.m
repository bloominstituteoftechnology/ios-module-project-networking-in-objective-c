//
//  LSIDailyForecast.m
//  DailyWeather
//
//  Created by Karen Rodriguez on 5/12/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForecast.h"

@implementation LSIDailyForecast

- (instancetype)initWithTime:(NSDate *)time
            summary:(NSString *)summary
               icon:(NSString *)icon
        sunriseTime:(NSNumber *)sunriseTime
         sunsetTime:(NSNumber *)sunsetTime
  precipProbability:(NSNumber *)precipProbability
    precipIntensity:(NSNumber *)precipIntensity
         precipType:(NSString *)precipType
     temperatureLow:(NSNumber *)temperatureLow
    temperatureHigh:(NSNumber *)temperatureHigh
apparentTemperature:(NSNumber *)apparentTemperature
           humidity:(NSNumber *)humidity
           pressure:(NSNumber *)pressure
          windSpeed:(NSNumber *)windSpeed
        windBearing:(NSNumber *)windBearing
                     uvIndex:(NSNumber *)uvIndex {
    self = [super init];
    if (self) {
        _time = time;
        _summary = [summary copy];
        _icon = [icon copy];
        _sunriseTime = sunriseTime;
        _sunsetTime = sunsetTime;
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _precipType = [precipType copy];
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
    return self;
}

@end
