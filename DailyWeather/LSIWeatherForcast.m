//
//  LSIWeatherForcast.m
//  DailyWeather
//
//  Created by Jessie Ann Griffin on 5/26/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForcast.h"

@implementation LSIWeatherForcast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(int)precipProbability
             precipIntensity:(int)precipIntensity
                 temperature:(double)temperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(NSString *)windBearing
                     uvIndex:(int)uvIndex
{
    if (self = [super init]) {
        _time = time;
        _summary = summary;
        _icon = icon;
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _temperature = temperature;
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
        _uvIndex = uvIndex;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (![dictionary isKindOfClass:[NSDictionary class]]) return nil;

    NSNumber *timeInMilliseconds = [dictionary objectForKey:@"time"];
    if (![timeInMilliseconds isKindOfClass:[NSNumber class]]) return nil;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000.0];

    NSString *summary = [dictionary objectForKey:@"summary"];
    if (![summary isKindOfClass:[NSString class]]) return nil;

    NSString *icon = [dictionary objectForKey:@"icon"];
    if (![icon isKindOfClass:[NSString class]]) return nil;

    NSNumber *precipProbability = [dictionary objectForKey:@"precipProbability"];
    if (![precipProbability isKindOfClass:[NSNumber class]]) return nil;

    NSNumber *precipIntensity = [dictionary objectForKey:@"precipIntensity"];
    if (![precipIntensity isKindOfClass:[NSNumber class]]) return nil;

    NSNumber *temperature = [dictionary objectForKey:@"temperature"];
    if (![temperature isKindOfClass:[NSNumber class]]) return nil;

    NSNumber *humidity = [dictionary objectForKey:@"humidity"];
    if (![humidity isKindOfClass:[NSNumber class]]) return nil;

    NSNumber *pressure = [dictionary objectForKey:@"pressure"];
    if (![pressure isKindOfClass:[NSNumber class]]) return nil;

    NSNumber *windSpeed = [dictionary objectForKey:@"windSpeed"];
    if (![windSpeed isKindOfClass:[NSNumber class]]) return nil;

    NSString *windBearing = [dictionary objectForKey:@"windBearing"];
    if (![windBearing isKindOfClass:[NSString class]]) return nil;

    NSNumber *uvIndex = [dictionary objectForKey:@"uvIndex"];
    if (![uvIndex isKindOfClass:[NSNumber class]]) return nil;

    return [self initWithTime:time
                      summary:summary.copy
                         icon:icon
            precipProbability:precipProbability.intValue
              precipIntensity:precipIntensity.intValue
                  temperature:temperature.doubleValue
                     humidity:humidity.doubleValue
                     pressure:pressure.doubleValue
                    windSpeed:windSpeed.doubleValue
                  windBearing:windBearing
                      uvIndex:uvIndex.intValue];

}

@end
