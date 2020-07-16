//
//  HourlyWeather.m
//  DailyWeather
//
//  Created by Bling Morley on 7/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "HourlyWeather.h"

@implementation HourlyWeather

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(UIImage *)icon
                     sunrise:(NSDate *)sunrise
                      sunset:(NSDate *)sunset
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
                  precipType:(NSString *)precipType
             temperatureHigh:(double)temperatureHigh
              temperatureLow:(double)temperatureLow
         apparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(int)windBearing
                     uvIndex:(int)uvIndex
{
    self = [super init];
    if (self) {
        _time = time;
        _summary = summary;
        _icon = icon;
        _sunrise = sunrise;
        _sunset = sunset;
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _precipType = precipType;
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
    NSDictionary *dailyForecast = dictionary;
    
    NSNumber *timeNumber = dailyForecast[@"time"];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970: timeNumber.longValue];
    
    NSString *summary = dailyForecast[@"summary"];
    
    NSString *iconString = dailyForecast[@"icon"];
    UIImage *image = [UIImage imageNamed: (@"%@", iconString)];
    
    NSNumber *sunriseNumber = dailyForecast[@"sunriseTime"];
    NSNumber *sunsetNumber = dailyForecast[@"sunsetTime"];
    NSDate *sunrise = [NSDate dateWithTimeIntervalSince1970: sunriseNumber.longValue];
    NSDate *sunset = [NSDate dateWithTimeIntervalSince1970: sunsetNumber.longValue];
    
    NSNumber *precipProbability = dailyForecast[@"precipProbability"];
    NSNumber *precipIntensity = dailyForecast[@"precipIntensity"];
    
    NSString *typeString = @"";
    if (dailyForecast[@"precipType"] == nil) {
        typeString = @"N/A";
    } else {
        typeString = dailyForecast[@"precipType"];
    }
    NSString *precipType = typeString;
    
    NSNumber *temperatureHigh = dailyForecast[@"temperatureHigh"];
    NSNumber *temperatureLow = dailyForecast[@"temperatureLow"];
    NSNumber *apparentTemperature = dailyForecast[@"apparentTemperature"];
    NSNumber *humidty = dailyForecast[@"humidity"];
    NSNumber *pressure = dailyForecast[@"pressure"];
    NSNumber *windSpeed = dailyForecast[@"windSpeed"];
    NSNumber *windBearing = dailyForecast[@"windBearing"];
    NSNumber *uvIndex = dailyForecast[@"uvIndex"];
    
    if (!( time && temperatureHigh && precipProbability && humidty)) {
        return nil;
    }
    
    self = [self initWithTime: time
                      summary: summary
                         icon: image
                      sunrise: sunrise
                       sunset: sunset
            precipProbability: precipProbability.doubleValue
              precipIntensity: precipIntensity.doubleValue
                   precipType: precipType
              temperatureHigh: temperatureHigh.doubleValue
               temperatureLow: temperatureLow.doubleValue
          apparentTemperature: apparentTemperature.doubleValue
                     humidity: humidty.doubleValue
                     pressure: pressure.doubleValue
                    windSpeed: windSpeed.doubleValue
                  windBearing: windBearing.intValue
                      uvIndex: uvIndex.intValue];
    return self;
    
}
@end
