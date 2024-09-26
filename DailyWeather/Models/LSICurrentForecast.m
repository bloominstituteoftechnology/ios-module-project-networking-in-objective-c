//
//  CurrentForecast.m
//  DailyWeather
//
//  Created by Claudia Maciel on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSICurrentForecast.h"
#import "LSIWeatherForecast.h"

@implementation LSICurrentForecast
-(instancetype)init
{
    return [self initWithTime:NSDate.now
                      summary:@""
                         icon:@""
            precipProbability:0
              precipIntensity:0
                  temperature:0
          apparentTemperature:0
                     humidity:0
                     pressure:0
                    windSpeed:0
                  windBearing:0
                      uvIndex:0];
}

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
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
        _summary = summary;
        _icon = icon;
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
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
    if (![dictionary isKindOfClass:[NSDictionary class]]) return nil;

    NSNumber *timeInMilliseconds = dictionary[@"time"];
    if ([timeInMilliseconds isKindOfClass:NSNull.class]) timeInMilliseconds = nil;
    else if (![timeInMilliseconds isKindOfClass:NSNumber.class]) return nil;
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000.0];
    
    NSString *summary = dictionary[@"summary"];
    if ([summary isKindOfClass:NSNull.class]) summary = nil;
    else if (![summary isKindOfClass:NSString.class]) return nil;
    
    NSString *icon = dictionary[@"icon"];
    if ([icon isKindOfClass:[NSNull class]]) icon = nil;
    else if (![icon isKindOfClass:[NSString class]]) return nil;
    
    NSNumber *precipProbability = dictionary[@"precipProbability"];
    if ([precipProbability isKindOfClass:[NSNull class]]) precipProbability = nil;
    else if (![precipProbability isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    if ([precipIntensity isKindOfClass:[NSNull class]]) precipIntensity = nil;
    else if (![precipIntensity isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *temperature = dictionary[@"temperature"];
    if ([temperature isKindOfClass:[NSNull class]]) temperature = nil;
    else if (![temperature isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *apparentTemperature = [dictionary objectForKey:@"apparentTemperature"];
    if ([apparentTemperature isKindOfClass:[NSNull class]]) apparentTemperature = nil;
    else if (![apparentTemperature isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *humidity = dictionary[@"humidity"];
    if ([humidity isKindOfClass:[NSNull class]]) humidity = nil;
    else if (![humidity isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *pressure = dictionary[@"pressure"];
    if ([pressure isKindOfClass:[NSNull class]]) pressure = nil;
    else if (![pressure isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    if ([windSpeed isKindOfClass:[NSNull class]]) windSpeed = nil;
    else if (![windSpeed isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *windBearing = dictionary[@"windBearing"];
    if ([windBearing isKindOfClass:[NSNull class]]) windBearing = nil;
    else if (![windBearing isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *uvIndex = dictionary[@"uvIndex"];
    if ([uvIndex isKindOfClass:[NSNull class]]) uvIndex = nil;
    else if (![uvIndex isKindOfClass:[NSNumber class]]) return nil;

    return [self initWithTime:time
                      summary:summary.copy
                         icon:icon
            precipProbability:precipProbability.doubleValue
              precipIntensity:precipIntensity.doubleValue
                  temperature:temperature.doubleValue
          apparentTemperature:apparentTemperature.doubleValue
                     humidity:humidity.doubleValue
                     pressure:pressure.doubleValue
                    windSpeed:windSpeed.doubleValue
                  windBearing:windBearing.doubleValue
                      uvIndex:uvIndex.doubleValue];
}

@end
