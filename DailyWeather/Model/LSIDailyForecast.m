//
//  LSIDailyForecast.m
//  DailyWeather
//
//  Created by Matthew Martindale on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForecast.h"

@implementation LSIDailyForecast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
                 sunriseTime:(NSDate *)sunriseTime
                  sunsetTime:(NSDate *)sunsetTime
           precipProbability:(int)precipProbability
             precipIntensity:(double)precipIntensity
                  precipType:(NSString *)precipType
              temperatureLow:(double)temperatureLow
             temperatureHigh:(double)temperatureHigh
         apparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(int)windBearing
                     uvIndex:(int)uvIndex
{
    if (self = [super init]) {
        _time = time;
        _summary = summary.copy;
        _icon = icon;
        _sunriseTime = sunriseTime;
        _sunsetTime = sunsetTime;
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _precipType = precipType.copy;
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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    // required
    NSNumber *timeInMilliseconds = [dictionary objectForKey:@"time"];
    if (![timeInMilliseconds isKindOfClass:NSNumber.class]) return nil;
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000.];
    
    // optional
    NSString *summary = [dictionary objectForKey:@"summary"];
    if ([summary isKindOfClass:NSNull.class]) summary = nil;
    else if (![summary isKindOfClass:NSString.class]) return nil;
    
    // optional
    NSString *icon = [dictionary objectForKey:@"icon"];
    if ([icon isKindOfClass:NSNull.class]) icon = nil;
    else if (![icon isKindOfClass:NSString.class]) return nil;
    
    // sunrise time
    // optional
    timeInMilliseconds = [dictionary objectForKey:@"sunriseTime"];
    if ([timeInMilliseconds isKindOfClass:[NSNull class]]) timeInMilliseconds = nil;
    else if (![timeInMilliseconds isKindOfClass:[NSNumber class]]) return nil;
    NSDate *sunriseTime = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000.];
    
    // sunset time
    // optional
    timeInMilliseconds = [dictionary objectForKey:@"sunsetTime"];
    if ([timeInMilliseconds isKindOfClass:[NSNull class]]) timeInMilliseconds = nil;
    else if (![timeInMilliseconds isKindOfClass:[NSNumber class]]) return nil;
    NSDate *sunsetTime = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000.];
    
    // optional
    NSNumber *precipProbability = [dictionary objectForKey:@"precipProbability"];
    if ([precipProbability isKindOfClass:NSNull.class]) precipProbability = nil;
    else if (![precipProbability isKindOfClass:NSNumber.class]) return nil;
    
    // optional
    NSNumber *precipIntensity = [dictionary objectForKey:@"precipIntensity"];
    if ([precipIntensity isKindOfClass:NSNull.class]) precipIntensity = nil;
    else if (![precipIntensity isKindOfClass:NSNumber.class]) return nil;
    
    // precipType
    // optional
    NSString *precipType = [dictionary objectForKey:@"precipType"];
    if ([precipType isKindOfClass:[NSNull class]]) precipType = nil;
    else if (![precipType isKindOfClass:[NSString class]]) return nil;
    
    // optional on daily
    NSNumber *temperatureLow = [dictionary objectForKey:@"temperatureLow"];
    if ([temperatureLow isKindOfClass:[NSNull class]]) temperatureLow = nil;
    else if (![temperatureLow isKindOfClass:[NSNumber class]]) return nil;
    
    // optional on daily
    NSNumber *temperatureHigh = [dictionary objectForKey:@"temperatureHigh"];
    if ([temperatureHigh isKindOfClass:[NSNull class]]) temperatureHigh = nil;
    else if (![temperatureHigh isKindOfClass:[NSNumber class]]) return nil;
    
    // optional on hourly and currently
    NSNumber *apparentTemperature = [dictionary objectForKey:@"apparentTemperature"];
    if ([apparentTemperature isKindOfClass:[NSNull class]]) apparentTemperature = nil;
    else if (![apparentTemperature isKindOfClass:[NSNumber class]]) return nil;
    
    // optional
    NSNumber *humidity = [dictionary objectForKey:@"humidity"];
    if ([humidity isKindOfClass:[NSNull class]]) humidity = nil;
    else if (![humidity isKindOfClass:[NSNumber class]]) return nil;
    
    // optional
    NSNumber *pressure = [dictionary objectForKey:@"pressure"];
    if ([pressure isKindOfClass:[NSNull class]]) pressure = nil;
    else if (![pressure isKindOfClass:[NSNumber class]]) return nil;
    
    // optional
    NSNumber *windSpeed = [dictionary objectForKey:@"windSpeed"];
    if ([windSpeed isKindOfClass:[NSNull class]]) windSpeed = nil;
    else if (![windSpeed isKindOfClass:[NSNumber class]]) return nil;
    
    // optional
    NSNumber *windBearing = [dictionary objectForKey:@"windBearing"];
    if ([windBearing isKindOfClass:[NSNull class]]) windBearing = nil;
    else if (![windBearing isKindOfClass:[NSNumber class]]) return nil;
    
    // optional
    NSNumber *uvIndex = [dictionary objectForKey:@"uvIndex"];
    if ([uvIndex isKindOfClass:[NSNull class]]) uvIndex = nil;
    else if (![uvIndex isKindOfClass:[NSNumber class]]) return nil;
    
    return [self initWithTime:time
                      summary:summary
                         icon:icon
                  sunriseTime:sunriseTime
                   sunsetTime:sunsetTime
            precipProbability:precipProbability.intValue
              precipIntensity:precipIntensity.doubleValue
                   precipType:precipType
               temperatureLow:temperatureLow.doubleValue
              temperatureHigh:temperatureHigh.doubleValue
          apparentTemperature:apparentTemperature.doubleValue
                     humidity:humidity.doubleValue
                     pressure:pressure.doubleValue
                    windSpeed:windSpeed.doubleValue
                  windBearing:windBearing.intValue
                      uvIndex:uvIndex.intValue];
}

@end
