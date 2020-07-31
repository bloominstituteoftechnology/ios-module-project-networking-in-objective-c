//
//  LSICurrentForecast.m
//  DailyWeather
//
//  Created by Chad Parker on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSICurrentForecast.h"

@implementation LSICurrentForecast

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
                 windBearing:(int)windBearing
                     uvIndex:(int)uvIndex
{
    if (self = [super init]) {
        _time = time;
        _summary = summary.copy;
        _icon = icon.copy;
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
    NSNumber *secondsSince1970 = dictionary[@"time"];
    if (![secondsSince1970 isKindOfClass:NSNumber.class]) return nil;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:secondsSince1970.doubleValue];

    NSString *summary = dictionary[@"summary"];
    if (![summary isKindOfClass:NSString.class]) return nil;

    NSString *icon = dictionary[@"icon"];
    if (![icon isKindOfClass:NSString.class]) return nil;

    NSNumber *precipProbability = dictionary[@"precipProbability"];
    if (![precipProbability isKindOfClass:NSNumber.class]) return nil;

    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    if (![precipIntensity isKindOfClass:NSNumber.class]) return nil;

    NSNumber *temperature = dictionary[@"temperature"];
    if (![temperature isKindOfClass:NSNumber.class]) return nil;

    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
    if (![apparentTemperature isKindOfClass:NSNumber.class]) return nil;

    NSNumber *humidity = dictionary[@"humidity"];
    if (![humidity isKindOfClass:NSNumber.class]) return nil;

    NSNumber *pressure = dictionary[@"pressure"];
    if (![pressure isKindOfClass:NSNumber.class]) return nil;

    NSNumber *windSpeed = dictionary[@"windSpeed"];
    if (![windSpeed isKindOfClass:NSNumber.class]) return nil;

    NSNumber *windBearing = dictionary[@"windBearing"];
    if (![windBearing isKindOfClass:NSNumber.class]) return nil;

    NSNumber *uvIndex = dictionary[@"uvIndex"];
    if (![uvIndex isKindOfClass:NSNumber.class]) return nil;

    return [self initWithTime:time
                      summary:summary icon:icon
            precipProbability:precipProbability.doubleValue
              precipIntensity:precipIntensity.doubleValue
                  temperature:temperature.doubleValue
          apparentTemperature:apparentTemperature.doubleValue
                     humidity:humidity.doubleValue
                     pressure:pressure.doubleValue
                    windSpeed:windSpeed.doubleValue
                  windBearing:windBearing.intValue
                      uvIndex:uvIndex.intValue];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"⭐️ %@, %.1f°", self.summary, self.temperature];
}

@end
