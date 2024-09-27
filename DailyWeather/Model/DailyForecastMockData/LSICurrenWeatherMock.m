//
//  LSICurrentWeather.m
//  DailyWeather
//
//  Created by Nick Nguyen on 4/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSICurrenWeatherMock.h"

@implementation LSICurrenWeatherMock


- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(int)precipProbability
             precipIntensity:(int)precipIntensity
                 temperature:(double)temperature
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


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    // Temporary value
    NSNumber *timeNumber = dictionary[@"time"];
    NSDate *convertedTime = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue / 1000.0];
    
    NSString *summary = dictionary[@"summary"];
    NSString *icon = dictionary[@"icon"];
    NSNumber *precipProbalitity = dictionary[@"precipProbability"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSNumber *temperature = dictionary[@"temperature"];
    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];
    
    self = [self initWithTime:convertedTime
                      summary:summary icon:icon
            precipProbability:precipProbalitity.intValue
              precipIntensity:precipIntensity.intValue
                  temperature:temperature.doubleValue
          apparentTemperature:apparentTemperature.doubleValue
                     humidity:humidity.doubleValue pressure:pressure.doubleValue
                    windSpeed:windSpeed.doubleValue
                  windBearing:windBearing.doubleValue uvIndex:uvIndex.intValue];
    
    
    
    return self;
}

@end
