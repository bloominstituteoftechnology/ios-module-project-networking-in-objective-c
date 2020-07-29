//
//  CurrentForecast.m
//  DailyWeather
//
//  Created by Claudia Maciel on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CurrentForecast.h"
#import "LSIWeatherForecast.h"

@implementation CurrentForecast
-(instancetype)init
{
    return [self initWithTime:NSDate.now
                      summary:@""
                         icon:@""
            precipProbability:0
              precipIntensity:0
                  temperature:0
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
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _windBearing = &windBearing;
        _uvIndex = &uvIndex;

    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (![dictionary isKindOfClass:[NSDictionary class]]) return nil;

    NSNumber *timeInMilliseconds = dictionary[@"time"];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000.0];
    NSString *summary = dictionary[@"summary"];
    NSString *icon = dictionary[@"icon"];
    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSNumber *temperature = dictionary[@"temperature"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];

    return [self initWithTime:time
                      summary:summary.copy
                         icon:icon
            precipProbability:precipProbability.doubleValue
              precipIntensity:precipIntensity.doubleValue
                  temperature:temperature.doubleValue
                     humidity:humidity.doubleValue
                     pressure:pressure.doubleValue
                    windSpeed:windSpeed.doubleValue
                  windBearing:windBearing.doubleValue
                      uvIndex:uvIndex.doubleValue];
}

@end
