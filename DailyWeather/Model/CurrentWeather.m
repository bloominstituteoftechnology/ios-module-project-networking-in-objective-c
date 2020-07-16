//
//  CurrentWeather.m
//  DailyWeather
//
//  Created by Vincent Hoang on 7/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CurrentWeather.h"

@implementation CurrentWeather

- (instancetype)initWithTime:(NSTimeInterval *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(NSInteger *)precipProbability
             precipIntensity:(NSInteger *)precipIntensity
         apparentTemperature:(NSNumber *)apparentTemperature
                    humidity:(NSNumber *)humidity
                    pressure:(NSNumber *)pressure
                   windSpeed:(NSNumber *)windSpeed
                 windBearing:(NSInteger *)windBearing
                     uvIndex:(NSInteger *)uvIndex {
    self = [super init];
    
    if (self) {
        _time = time;
        _summary = [summary copy];
        _icon = [icon copy];
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _apparentTemperature = apparentTemperature;
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
        _uvIndex = uvIndex;
    }
    
    return self;
}

@end
