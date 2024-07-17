//
//  LSIHourlyForecast.m
//  DailyWeather
//
//  Created by Clayton Watkins on 9/23/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIHourlyForecast.h"

@implementation LSIHourlyForecast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
             precipIntensity:(double)precipIntensity
           precipProbability:(double)precipProbability
                  precipType:(NSString *)precipType
                 temperature:(double)temperature
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
         _icon = icon;
         _precipIntensity = precipIntensity;
         _precipProbability = precipProbability;
         _precipType = precipType.copy;
         _temperature = temperature;
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
    NSNumber *timeInSeconds = [dictionary objectForKey:@"time"];
    if ([timeInSeconds isKindOfClass:[NSNull class]]) {
        timeInSeconds = nil;
    } else if (![timeInSeconds isKindOfClass:[NSNumber class]]) return nil;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInSeconds.longValue];
    
    NSString *summary = [dictionary objectForKey:@"summary"];
    if ([summary isKindOfClass:[NSNull class]]) {
        summary = nil;
    } else if (![summary isKindOfClass:[NSString class]]) return nil;
    
    NSString *icon = [dictionary objectForKey:@"icon"];
    if ([icon isKindOfClass:[NSNull class]]) {
        icon = nil;
    } else if (![icon isKindOfClass:[NSString class]]) return nil;
    
    NSNumber *precipIntensity = [dictionary objectForKey:@"precipIntensity"];
    if ([precipIntensity isKindOfClass:[NSNull class]]) {
        precipIntensity = nil;
    } else if (![precipIntensity isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *precipProbability = [dictionary objectForKey:@"precipProbability"];
    if ([precipProbability isKindOfClass:[NSNull class]]) {
        precipProbability = nil;
    } else if (![precipProbability isKindOfClass:[NSNumber class]]) return nil;
    
    NSString *precipType = [dictionary objectForKey:@"precipType"];
    if ([precipType isKindOfClass:[NSNull class]]) {
        precipType = nil;
    } else if (![precipType isKindOfClass:[NSString class]]) return nil;
    
    NSNumber *temperature = [dictionary objectForKey:@"temperature"];
    if ([temperature isKindOfClass:[NSNull class]]) {
        temperature = nil;
    } else if (![temperature isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *apparentTemperature = [dictionary objectForKey:@"apparentTemperature"];
    if ([apparentTemperature isKindOfClass:[NSNull class]]) {
        apparentTemperature = nil;
    } else if (![apparentTemperature isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *humidity = [dictionary objectForKey:@"humidity"];
    if ([humidity isKindOfClass:[NSNull class]]) {
        humidity = nil;
    } else if (![humidity isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *pressure = [dictionary objectForKey:@"pressure"];
    if ([pressure isKindOfClass:[NSNull class]]) {
        pressure = nil;
    } else if (![pressure isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *windSpeed = [dictionary objectForKey:@"windSpeed"];
    if ([windSpeed isKindOfClass:[NSNull class]]) {
        windSpeed = nil;
    } else if (![windSpeed isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *windBearing = [dictionary objectForKey:@"windBearing"];
    if ([windBearing isKindOfClass:[NSNull class]]) {
        windBearing = nil;
    } else if (![windBearing isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *uvIndex = [dictionary objectForKey:@"uvIndex"];
    if ([uvIndex isKindOfClass:[NSNull class]]) {
        uvIndex = nil;
    } else if (![uvIndex isKindOfClass:[NSNumber class]]) return nil;
    
    return [self initWithTime:time
                      summary:summary
                         icon:icon
              precipIntensity:precipIntensity.doubleValue
            precipProbability:precipProbability.doubleValue
                   precipType:precipType
                  temperature:temperature.doubleValue
          apparentTemperature:apparentTemperature.doubleValue
                     humidity:humidity.doubleValue
                     pressure:pressure.doubleValue
                    windSpeed:windSpeed.doubleValue
                  windBearing:windBearing.doubleValue
                      uvIndex:uvIndex.doubleValue];
}

@end
