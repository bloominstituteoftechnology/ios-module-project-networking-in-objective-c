//
//  LSIDailyForecast.m
//  DailyWeather
//
//  Created by Sean Acres on 7/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForecast.h"

@implementation LSIDailyForecast

- (instancetype)init
{
    return [self initWithTime:NSDate.now summary:@"" icon:@"" sunriseTime:NSDate.now sunsetTime:NSDate.now precipProbability:0 precipIntensity:0 precipType:@"" temperatureLow:0 temperatureHigh:0 apparentTemperature:0 humidity:0 pressure:0 windSpeed:0 windBearing:0 uvIndex:0];
}

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
                 sunriseTime:(NSDate *)sunriseTime
                  sunsetTime:(NSDate *)sunsetTime
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
                  precipType:(NSString *)precipType
              temperatureLow:(double)temperatureLow
             temperatureHigh:(double)temperatureHigh
         apparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(double)windBearing
                     uvIndex:(double)uvIndex
{
    if (self = [super init]) {
        _time = time;
        _summary = summary.copy;
        _icon = icon.copy;
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
    NSNumber *timeInMilliseconds = [dictionary objectForKey:@"time"];
    if (![timeInMilliseconds isKindOfClass:NSNumber.class]) return nil;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000.];
    
    NSString *summary = [dictionary objectForKey:@"summary"];
    if ([summary isKindOfClass:NSNull.class]) summary = nil;
    else if (![summary isKindOfClass:NSString.class]) return nil;
    
    NSString *icon = [dictionary objectForKey:@"icon"];
    if ([icon isKindOfClass:NSNull.class]) icon = nil;
    else if (![icon isKindOfClass:NSString.class]) return nil;
    
    NSNumber *precipProbability = [dictionary objectForKey:@"precipProbability"];
    if ([precipProbability isKindOfClass:NSNull.class]) precipProbability = nil;
    else if (![precipProbability isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *precipIntensity = [dictionary objectForKey:@"precipIntensity"];
    if ([precipIntensity isKindOfClass:NSNull.class]) precipIntensity = nil;
    else if (![precipIntensity isKindOfClass:NSNumber.class]) return nil;
    
    // TODO: add apparenttemperature high or remove?
    NSNumber *apparentTemperature = [dictionary objectForKey:@"apparentTemperatureLow"];
    if ([apparentTemperature isKindOfClass:NSNull.class]) apparentTemperature = nil;
    else if (![apparentTemperature isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *humidity = [dictionary objectForKey:@"humidity"];
    if ([humidity isKindOfClass:NSNull.class]) humidity = nil;
    else if (![humidity isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *pressure = [dictionary objectForKey:@"pressure"];
    if ([pressure isKindOfClass:NSNull.class]) pressure = nil;
    else if (![pressure isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *windSpeed = [dictionary objectForKey:@"windSpeed"];
    if ([windSpeed isKindOfClass:NSNull.class]) windSpeed = nil;
    else if (![windSpeed isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *windBearing = [dictionary objectForKey:@"windBearing"];
    if ([windBearing isKindOfClass:NSNull.class]) windBearing = nil;
    else if (![windBearing isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *uvIndex = [dictionary objectForKey:@"uvIndex"];
    if ([uvIndex isKindOfClass:NSNull.class]) uvIndex = nil;
    else if (![uvIndex isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *sunriseTimeInMilliseconds = [dictionary objectForKey:@"sunriseTime"];
    if (![sunriseTimeInMilliseconds isKindOfClass:NSNumber.class]) return nil;
    NSDate *sunriseTime = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000.];
    
    NSNumber *sunsetTimeInMilliseconds = [dictionary objectForKey:@"sunsetTime"];
    if (![sunsetTimeInMilliseconds isKindOfClass:NSNumber.class]) return nil;
    NSDate *sunsetTime = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000.];
    
    NSString *precipType = [dictionary objectForKey:@"precipType"];
    if ([precipType isKindOfClass:NSNull.class]) precipType = nil;
    else if (![precipType isKindOfClass:NSString.class]) return nil;
    
    NSNumber *temperatureLow = [dictionary objectForKey:@"temperatureLow"];
    if ([temperatureLow isKindOfClass:NSNull.class]) temperatureLow = nil;
    else if (![temperatureLow isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *temperatureHigh = [dictionary objectForKey:@"temperatureHigh"];
    if ([temperatureHigh isKindOfClass:NSNull.class]) temperatureHigh = nil;
    else if (![temperatureHigh isKindOfClass:NSNumber.class]) return nil;
    
    return [self initWithTime:time
                      summary:summary
                         icon:icon
                  sunriseTime:sunriseTime
                   sunsetTime:sunsetTime
            precipProbability:precipProbability.doubleValue
              precipIntensity:precipIntensity.doubleValue
                   precipType:precipType
               temperatureLow:temperatureLow.doubleValue
              temperatureHigh:temperatureHigh.doubleValue
          apparentTemperature:apparentTemperature.doubleValue
                     humidity:humidity.doubleValue
                     pressure:pressure.doubleValue
                    windSpeed:windSpeed.doubleValue
                  windBearing:windBearing.doubleValue
                      uvIndex:uvIndex.doubleValue];
}

@end
