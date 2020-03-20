//
//  LSICurrentForcast.m
//  DailyWeather
//
//  Created by Michael on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSICurrentForecast.h"

@implementation LSICurrentForecast

//- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
//    self = [super init];
//    if (self) {
//
//        NSNumber *timeNumber = dictionary[@"time"];
//        _time = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue];
//        _summary = dictionary[@"summary"];
//        _icon = dictionary[@"icon"];
//        _precipProbability = [NSNumber numberWithDouble:[dictionary[@"precipProbability"]doubleValue]];
//        _precipIntensity = [NSNumber numberWithDouble:[dictionary[@"precipIntensity"]doubleValue]];
//        _temperature = [NSNumber numberWithDouble:[dictionary[@"temperature"]doubleValue]];
//        _apparentTemperature = [NSNumber numberWithDouble:[dictionary[@"apparentTemperature"]doubleValue]];
//        _humidity = [NSNumber numberWithDouble:[dictionary[@"humidity"]doubleValue]];
//        _pressure = [NSNumber numberWithDouble:[dictionary[@"pressure"]doubleValue]];
//        _windSpeed = [NSNumber numberWithDouble:[dictionary[@"windSpeed"]doubleValue]];
//        _windBearing = [NSNumber numberWithDouble:[dictionary[@"windBearing"]doubleValue]];
//        _uvIndex = [NSNumber numberWithDouble:[dictionary[@"uvIndex"] doubleValue]];
//    }
//    return self;
//}

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
                     uvIndex:(double)uvIndex {
    
    self = [super init];
    if (self) {
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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        NSNumber *timeNumber = dictionary[@"time"];
        _time = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue];
        _summary = dictionary[@"summary"];
        _icon = dictionary[@"icon"];
        _precipProbability = [dictionary[@"precipProbability"]doubleValue];
        _precipIntensity = [dictionary[@"precipIntensity"]doubleValue];
        _temperature = [dictionary[@"temperature"]doubleValue];
        _apparentTemperature = [dictionary[@"apparentTemperature"]doubleValue];
        _humidity = [dictionary[@"humidity"]doubleValue];
        _pressure = [dictionary[@"pressure"]doubleValue];
        _windSpeed = [dictionary[@"windSpeed"]doubleValue];
        _windBearing = [dictionary[@"windBearing"]doubleValue];
        _uvIndex = [dictionary[@"uvIndex"] doubleValue];
    }
    return self;
}

@end
