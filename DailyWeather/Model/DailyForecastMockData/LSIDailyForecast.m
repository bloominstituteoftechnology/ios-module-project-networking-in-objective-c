//
//  LSIDailyForecast.m
//  DailyWeather
//
//  Created by Nick Nguyen on 4/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForecast.h"

@implementation LSIDailyForecast
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
                 windBearing:(int)windBearing
                     uvIndex:(int)uvIndex {
    self = [super init];
        if (self) {
            _time = time;
            _summary = [summary copy];
            _icon = [icon copy];
            _sunriseTime = sunriseTime;
            _sunsetTime = sunsetTime;
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
    // Temp value
    NSNumber *timeNumber = dictionary[@"time"];
    NSDate *convertedTime = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue / 1000.0];
    
    NSString *summary = dictionary[@"summary"];
    NSString *icon = dictionary[@"icon"];
    
    NSNumber *sunriseTimeNumber = dictionary[@"sunriseTime"];
    NSDate *convertedSunriseTime = [NSDate dateWithTimeIntervalSince1970:sunriseTimeNumber.longValue / 1000.0];
    NSNumber *sunsetTimeNumber = dictionary[@"sunsetTime"];
    NSDate *convertedSunsetTime = [NSDate dateWithTimeIntervalSince1970:sunsetTimeNumber.longValue / 1000.0];
    
    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    
    NSString *precipType = dictionary[@"precipType"];
    
    if ([precipType isKindOfClass:[NSNull class]]) {
        precipType = nil;
    }
    NSNumber *tempLow = dictionary[@"temperatureLow"];
    NSNumber *tempHigh = dictionary[@"temperatureHigh"];
    NSNumber *apparentTemperatureLow = dictionary[@"apparentTemperatureLow"];
    NSNumber *apparentTemperatureHigh = dictionary[@"apparentTemperatureHigh"];
    double apparentTemperature = apparentTemperatureLow.doubleValue + apparentTemperatureHigh.doubleValue / 2;
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];
    
    if (timeNumber && summary && icon && sunriseTimeNumber && sunsetTimeNumber && precipProbability &&  precipIntensity && precipType && tempLow && tempHigh &&humidity && pressure && windSpeed && windBearing && uvIndex )
    {
        self = [self initWithTime:convertedTime summary:summary icon:icon
                      sunriseTime:convertedSunriseTime sunsetTime:convertedSunsetTime
                precipProbability:precipProbability.doubleValue
                  precipIntensity:precipIntensity.doubleValue precipType:precipType
                   temperatureLow:tempLow.doubleValue
                  temperatureHigh:tempHigh.doubleValue
              apparentTemperature:apparentTemperature
                         humidity:humidity.doubleValue
                         pressure:pressure.doubleValue
                        windSpeed:windSpeed.doubleValue
                      windBearing:windBearing.intValue
                          uvIndex:uvIndex.intValue];
    } else {
        NSLog(@"Error: Invalid object, unable to parse,%@", dictionary);
        return nil;
    }
    
    return self;
    
}
@end
