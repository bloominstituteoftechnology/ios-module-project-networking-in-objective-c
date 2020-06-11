//
//  HSIDailyForecast.m
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import "HSIDailyForecast.h"

@implementation HSIDailyForecast

- (instancetype)initWithTime:(NSDate *)time
                    summmary:(NSString *)summary
                        icon:(NSString *)icon
                 sunriseTime:(NSDate *)sunriseTime
                  sunsetTime:(NSDate *)sunsetTime
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
                  precipType:(NSString *)precipType
                    pressure:(double)pressure
              temperatureLow:(double)temperatureLow
             temperatureHigh:(double)temperatureHigh
         apparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                   windSpeed:(double)windSpeed
                 windBearing:(int)windBearing
                     uvIndex:(int)uvIndex {
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
        _pressure = pressure;
        _temperatureLow = temperatureLow;
        _temperatureHigh = temperatureHigh;
        _apparentTemperature = apparentTemperature;
        _humidity = humidity;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
        _uvIndex = uvIndex;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSNumber *timeValue = dictionary[@"time"];
    NSString *summary = dictionary[@"summary"];
    NSString *icon = dictionary[@"icon"];

    NSNumber *sunriseTimeValue = dictionary[@"sunriseTime"];
    NSNumber *sunsetTimeValue = dictionary[@"sunsetTime"];

    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSString *precipType = dictionary[@"precipType"];

    NSNumber *temperatureLow = dictionary[@"temperatureLow"];
    NSNumber *temperatureHigh = dictionary[@"temperatureHigh"];
    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];

    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];

    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];

    NSDate *time = [[NSDate alloc] initWithTimeIntervalSince1970:timeValue.longValue];
    NSDate *sunriseTime = [[NSDate alloc] initWithTimeIntervalSince1970:sunriseTimeValue.longValue];
    NSDate *sunsetTime = [[NSDate alloc] initWithTimeIntervalSince1970:sunsetTimeValue.longValue];
    if (time && summary && icon && sunriseTime && sunsetTime && precipProbability && humidity && pressure && windSpeed && uvIndex) {
        return [self initWithTime:time
                         summmary:[summary copy]
                             icon:[icon copy]
                      sunriseTime:sunriseTime
                       sunsetTime:sunsetTime
                precipProbability:precipProbability.doubleValue
                  precipIntensity:precipIntensity.doubleValue
                       precipType:[precipType copy]
                         pressure:pressure.doubleValue
                   temperatureLow:temperatureLow.doubleValue
                  temperatureHigh:temperatureHigh.doubleValue
              apparentTemperature:apparentTemperature.doubleValue
                         humidity:humidity.doubleValue
                        windSpeed:windSpeed.doubleValue
                      windBearing:windBearing.intValue
                          uvIndex:uvIndex.intValue];
    }
    return nil;
}

@end
