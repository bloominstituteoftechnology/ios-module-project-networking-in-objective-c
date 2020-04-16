//
//  LSICurrentForcast.m
//  CurrentForcast
//
//  Created by Ufuk Türközü on 15.04.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSICurrentForcast.h"

@implementation LSICurrentForcast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
             precipIntensity:(double)precipIntensity
           precipProbability:(double)precipProbability
                 temperature:(double)temperature
         apparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(double)windBearing
                     uvIndex:(double)uvIndex {
    self = [super init];
    if (self) {
        _time = time;
        _summary = summary;
        _icon = icon;
        _precipIntensity = precipIntensity;
        _precipProbability = precipProbability;
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
    NSNumber *timeNumber = dictionary[@"time"];
    NSString *summary = dictionary[@"summary"];
    NSString *icon = dictionary[@"icon"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSNumber *temperature = dictionary[@"temperature"];
    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue];
    
    self = [self initWithTime:time
                      summary:summary
                         icon:icon
              precipIntensity:precipIntensity.doubleValue
            precipProbability:precipProbability.doubleValue
                  temperature:temperature.doubleValue
          apparentTemperature:apparentTemperature.doubleValue
                     humidity:humidity.doubleValue
                     pressure:pressure.doubleValue
                    windSpeed:windSpeed.doubleValue
                  windBearing:windBearing.doubleValue
                      uvIndex:uvIndex.doubleValue];
    
    return self;
}

@end
