//
//  LSIHourlyForecast.m
//  DailyWeather
//
//  Created by Michael on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIHourlyForecast.h"

@implementation LSIHourlyForecast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        NSNumber *timeNumber = dictionary[@"time"];
        NSString *summary = dictionary[@"summary"];
        NSString *icon = dictionary[@"icon"];
        NSString *precipType = dictionary[@"precipType"];
        NSNumber *precipIntensity = dictionary[@"precipIntensity"];
        NSNumber *precipProbability = dictionary[@"precipProbability"];
        NSNumber *temperature = dictionary[@"temperature"];
        NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
        NSNumber *humidity = dictionary[@"humidity"];
        NSNumber *pressure = dictionary[@"pressure"];
        NSNumber *windSpeed = dictionary[@"windSpeed"];
        NSNumber *windBearing = dictionary[@"windBearing"];
        NSNumber *uvIndex = dictionary[@"uvIndex"];
        
        if (!(timeNumber)) {
            return nil;
        }
        
        _time = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue];
        _summary = summary;
        _icon = icon;
        _precipType = precipType;
        _precipProbability = [precipProbability doubleValue];
        _precipIntensity = [precipIntensity doubleValue];
        _temperature = [temperature doubleValue];
        _apparentTemperature = [apparentTemperature doubleValue];
        _humidity = [humidity doubleValue];
        _pressure = [pressure doubleValue];
        _windSpeed = [windSpeed doubleValue];
        _windBearing = [windBearing doubleValue];
        _uvIndex = [uvIndex doubleValue];
        
        if ([precipType isKindOfClass:[NSNull class]]) {
            _precipType = nil;
        } else {
            _precipType = precipType;
        }
    }
    return self;
}

@end
