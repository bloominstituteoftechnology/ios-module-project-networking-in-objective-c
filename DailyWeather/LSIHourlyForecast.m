//
//  LSIHourlyForecast.m
//  DailyWeather
//
//  Created by Sal B Amer on 5/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIHourlyForecast.h"

@implementation LSIHourlyForecast

- (instancetype)initWithTime:(NSNumber *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
//                 sunriseTime:(NSDate *)sunriseTime
//                  sunsetTime:(NSDate *)sunsetTime
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
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.longValue];
        _time = date;
        _summary = [summary copy];
        _icon = [icon copy];
//        sunriseTime = sunriseTime;
//        sunsetTime = sunsetTime;
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _precipType = [precipType copy];
        _temperatureLow = temperatureLow;
        _temperatureHigh = temperatureHigh;
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
    NSDate *time = dictionary[@"time"];
 
//  NSNumber *timeInSeconds = [dictionary objectForKey:@"time"];
//  if ([timeInSeconds isKindOfClass:[NSNull class]]) {
//      timeInSeconds = nil;
//  } else if (![timeInSeconds isKindOfClass:[NSNumber class]]) return nil;
//  NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInSeconds.longValue];

    NSString *summary = dictionary[@"summary"];
    if([summary isKindOfClass:[NSNull class]]) { summary = nil; }

    NSString *icon = dictionary[@"icon"];
    if([icon isKindOfClass:[NSNull class]]) { icon = nil; }

    NSNumber *precipProbability = dictionary[@"precipProbability"];
    if([precipProbability isKindOfClass:[NSNull class]]) { precipProbability = nil; }

    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    if([precipIntensity isKindOfClass:[NSNull class]]) { precipIntensity = nil; }

    NSString *precipType = dictionary[@"precipType"];
    if([precipType isKindOfClass:[NSNull class]]) { precipType = nil; }

//  NSNumber *temperatureLow = [dictionary objectForKey:@"temperatureLow"];
//  if ([temperatureLow isKindOfClass:[NSNull class]]) {
//    temperatureLow = nil;
//  } else if (![temperatureLow isKindOfClass:[NSNumber class]]) return nil;
//
//  NSNumber *temperatureHigh = [dictionary objectForKey:@"temperatureHigh"];
//  if ([temperatureHigh isKindOfClass:[NSNull class]]) {
//    temperatureHigh = nil;
//  } else if (![temperatureHigh isKindOfClass:[NSNumber class]]) return nil;
  
    NSNumber *temperatureLow = dictionary[@"temperatureLow"];
    if([temperatureLow isKindOfClass:[NSNull class]]) { temperatureLow = nil; }

    NSNumber *temperatureHigh = dictionary[@"temperatureHigh"];
    if([temperatureHigh isKindOfClass:[NSNull class]]) { temperatureHigh = nil; }

    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
    if([apparentTemperature isKindOfClass:[NSNull class]]) { apparentTemperature = nil; }
  

    NSNumber *humidity = dictionary[@"humidity"];
    if([humidity isKindOfClass:[NSNull class]]) { humidity = nil; }

    NSNumber *pressure = dictionary[@"pressure"];
    if([pressure isKindOfClass:[NSNull class]]) { pressure = nil; }

    NSNumber *windSpeed = dictionary[@"windSpeed"];
    if([windSpeed isKindOfClass:[NSNull class]]) { windSpeed = nil; }

    NSNumber *windBearing = dictionary[@"windBearing"];
    if([windBearing isKindOfClass:[NSNull class]]) { windBearing = nil; }
  
//    NSNumber *sunriseTime = dictionary[@"sunriseTime"];
//     if([sunriseTime isKindOfClass:[NSNull class]]) { sunriseTime = nil; }
//
//     NSNumber *sunsetTime = dictionary[@"sunsetTime"];
//     if([sunsetTime isKindOfClass:[NSNull class]]) { sunsetTime = nil; }

    NSNumber *uvIndex = dictionary[@"uvIndex"];
    if([uvIndex isKindOfClass:[NSNull class]]) { uvIndex = nil; }

    self = [self initWithTime:time
                      summary:summary
                         icon:icon
            precipProbability:precipProbability
              precipIntensity:precipIntensity
                   precipType:precipType
               temperatureLow:temperatureLow
              temperatureHigh:temperatureHigh
          apparentTemperature:apparentTemperature
                     humidity:humidity
                     pressure:pressure
                    windSpeed:windSpeed
                  windBearing:windBearing
//                  sunriseTime:sunriseTime
//                   sunsetTime:sunsetTime
                      uvIndex:uvIndex];

    return self;
}


@end
