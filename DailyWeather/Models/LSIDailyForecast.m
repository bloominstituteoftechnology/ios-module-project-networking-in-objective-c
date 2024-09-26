//
//  LSIDailyForecast.m
//  DailyWeather
//
//  Created by Mark Gerrior on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForecast.h"

@implementation LSIDailyForecast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
                 sunriseTime:(NSDate *)sunriseTime
                  sunsetTime:(NSDate *)sunsetTime
           precipProbability:(NSNumber *)precipProbability
             precipIntensity:(NSNumber *)precipIntensity
                  precipType:(NSString *)precipType
              temperatureLow:(NSNumber *)temperatureLow
             temperatureHigh:(NSNumber *)temperatureHigh
     apparentTemperatureHigh:(NSNumber *)apparentTemperatureHigh
                    humidity:(NSNumber *)humidity
                    pressure:(NSNumber *)pressure
                   windSpeed:(NSNumber *)windSpeed
                 windBearing:(NSNumber *)windBearing
                     uvIndex:(NSNumber *)uvIndex {

    self = [super init];
    if (self != nil) {
        _time = time;
        _summary = [summary copy];
        _icon = [icon copy];
        _sunriseTime = sunriseTime;
        _sunsetTime = sunsetTime;
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _precipType = [precipType copy];
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

    NSNumber *timeAsNumber            = dictionary[@"time"];
    NSString *summary                 = dictionary[@"summary"];
    NSString *icon                    = dictionary[@"icon"];
    NSNumber *sunriseTimeAsNumber     = dictionary[@"sunriseTime"];
    NSNumber *sunsetTimeAsNumber      = dictionary[@"sunsetTime"];
    NSNumber *precipProbability       = dictionary[@"precipProbability"];
    NSNumber *precipIntensity         = dictionary[@"precipIntensity"];
    NSString *precipType              = dictionary[@"precipType"];
    NSNumber *temperatureLow          = dictionary[@"temperatureLow"];
    NSNumber *temperatureHigh         = dictionary[@"temperatureHigh"];
    NSNumber *apparentTemperatureHigh = dictionary[@"apparentTemperatureHigh"];
    NSNumber *humidity                = dictionary[@"humidity"];
    NSNumber *pressure                = dictionary[@"pressure"];
    NSNumber *windSpeed               = dictionary[@"windSpeed"];
    NSNumber *windBearing             = dictionary[@"windBearing"];
    NSNumber *uvIndex                 = dictionary[@"uvIndex"];

    // a UNIX time (that is, seconds since midnight GMT on 1 Jan 1970)
    // FIXME: or a string formatted as follows: [YYYY]-[MM]-[DD]T[HH]:[MM]:[SS][timezone]. timezone
    double timeInSeconds = timeAsNumber.doubleValue;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInSeconds];

    timeInSeconds = sunriseTimeAsNumber.doubleValue;
    NSDate *sunriseTime = [NSDate dateWithTimeIntervalSince1970:timeInSeconds];

    timeInSeconds = sunsetTimeAsNumber.doubleValue;
    NSDate *sunsetTime = [NSDate dateWithTimeIntervalSince1970:timeInSeconds];

    if ([precipProbability       isKindOfClass:[NSNull class]]) { precipProbability       = nil; }
    if ([precipIntensity         isKindOfClass:[NSNull class]]) { precipIntensity         = nil; }
    if ([temperatureLow          isKindOfClass:[NSNull class]]) { temperatureLow          = nil; }
    if ([temperatureHigh         isKindOfClass:[NSNull class]]) { temperatureHigh         = nil; }
    if ([apparentTemperatureHigh isKindOfClass:[NSNull class]]) { apparentTemperatureHigh = nil; }
    if ([humidity                isKindOfClass:[NSNull class]]) { humidity                = nil; }
    if ([pressure                isKindOfClass:[NSNull class]]) { pressure                = nil; }
    if ([windSpeed               isKindOfClass:[NSNull class]]) { windSpeed               = nil; }
    if ([windBearing             isKindOfClass:[NSNull class]]) { windBearing             = nil; }
    if ([uvIndex                 isKindOfClass:[NSNull class]]) { uvIndex                 = nil; }

    // The required elements
    if (!time) {
        return nil;
    }

    return [self initWithTime:time
                      summary:summary
                         icon:icon
                  sunriseTime:sunriseTime
                   sunsetTime:sunsetTime
            precipProbability:precipProbability
              precipIntensity:precipIntensity
                   precipType:precipType
               temperatureLow:temperatureLow
              temperatureHigh:temperatureHigh
      apparentTemperatureHigh:apparentTemperatureHigh
                     humidity:humidity
                     pressure:pressure
                    windSpeed:windSpeed
                  windBearing:windBearing
                      uvIndex:uvIndex
            ];
}

@end
