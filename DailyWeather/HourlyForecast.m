//
//  HourlyForecast.m
//  DailyWeather
//
//  Created by Cora Jacobson on 11/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "HourlyForecast.h"

@implementation HourlyForecast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
                  precipType:(NSString *)precipType
                 temperature:(double)temperature
         apparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(double)windBearing
                     uvIndex:(int)uvIndex
                  visibility:(int)visibility
                    dewPoint:(double)dewPoint
{
    if (self = [super init]) {
        _time = time;
        _summary = summary.copy;
        _icon = icon.copy;
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _precipType = precipType.copy;
        _temperature = temperature;
        _apparentTemperature = apparentTemperature;
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
        _uvIndex = uvIndex;
        _visibility = visibility;
        _dewPoint = dewPoint;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    NSNumber *timeInSeconds = [aDictionary objectForKey:@"time"];
    if (![timeInSeconds isKindOfClass:NSNumber.class]) return nil;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInSeconds.longValue];
    
    NSString *summary = [aDictionary objectForKey:@"summary"];
    if (![summary isKindOfClass:NSString.class]) return nil;
    
    NSString *icon = [aDictionary objectForKey:@"icon"];
    if (![icon isKindOfClass:NSString.class]) return nil;
    
    NSNumber *precipProbability = [aDictionary objectForKey:@"precipProbability"];
    if (![precipProbability isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *precipIntensity = [aDictionary objectForKey:@"precipIntensity"];
    if (precipIntensity == nil || [precipIntensity isKindOfClass:NSNull.class]) {
        precipIntensity = 0;
    } else if (![precipIntensity isKindOfClass:NSNumber.class]) {
        return nil;
    }
    
    NSString *precipType = [aDictionary objectForKey:@"precipType"];
    if (precipType == nil || [precipType isKindOfClass:NSNull.class]) {
        precipType = @"";
    } else if (![precipType isKindOfClass:NSString.class]) {
        return nil;
    }
    
    NSNumber *temperature = [aDictionary objectForKey:@"temperature"];
    if (![temperature isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *apparentTemperature = [aDictionary objectForKey:@"apparentTemperature"];
    if (![apparentTemperature isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *humidity = [aDictionary objectForKey:@"humidity"];
    if (![humidity isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *pressure = [aDictionary objectForKey:@"pressure"];
    if (![pressure isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *windSpeed = [aDictionary objectForKey:@"windSpeed"];
    if (![windSpeed isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *windBearing = [aDictionary objectForKey:@"windBearing"];
    if (windBearing == nil || [windBearing isKindOfClass:NSNull.class]) {
        windBearing = 0;
    } else if (![windBearing isKindOfClass:NSNumber.class]) {
        return nil;
    }
    
    NSNumber *uvIndex = [aDictionary objectForKey:@"uvIndex"];
    if (![uvIndex isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *visibility = [aDictionary objectForKey:@"visibility"];
    if (![visibility isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *dewPoint = [aDictionary objectForKey:@"dewPoint"];
    if (![dewPoint isKindOfClass:NSNumber.class]) return nil;
    
    return [self initWithTime:time
                      summary:summary
                         icon:icon
            precipProbability:precipProbability.doubleValue
              precipIntensity:precipIntensity.doubleValue
                   precipType:precipType
                  temperature:temperature.doubleValue
          apparentTemperature:apparentTemperature.doubleValue
                     humidity:humidity.doubleValue
                     pressure:pressure.doubleValue
                    windSpeed:windSpeed.doubleValue
                  windBearing:windBearing.doubleValue
                      uvIndex:uvIndex.intValue
                   visibility:visibility.intValue
                     dewPoint:dewPoint.doubleValue];
}

@end
