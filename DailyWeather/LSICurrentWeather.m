//
//  LSICurrentWeather.m
//  DailyWeather
//
//  Created by Bhawnish Kumar on 6/11/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSICurrentWeather.h"

@implementation LSICurrentWeather

- (instancetype)initWithTime:(NSDate *)time summary:(NSString *)summary icon:(NSString *)icon precipProbability:(NSNumber *)precipProbability precipIntensity:(NSNumber *)precipIntensity temperature:(double)temperature apparentTemperature:(double)apparentTemperature humidity:(NSNumber *)humidity pressure:(NSNumber *)pressure windSpeed:(NSNumber *)windSpeed windBearing:(NSNumber *)windBearing uvIndex:(NSNumber *)uvIndex {
    
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
    
    return nil;
}


@end
