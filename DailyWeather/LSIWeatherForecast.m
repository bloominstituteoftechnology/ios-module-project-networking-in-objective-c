//
//  LSIWeatherForecast.m
//  DailyWeather
//
//  Created by Karen Rodriguez on 5/12/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForecast.h"

@implementation LSIWeatherForecast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {

        // No need for containers
        // Temporary properties to check for nil
        NSDate *time = dictionary[@"time"];

        // Optional checker boilerplate code snippet;
        // if([<#variable#> isKindOfClass:[NSNull class]]) { <#variable#> = nil; }
        NSString *summary = dictionary[@"summary"];
        if([summary isKindOfClass:[NSNull class]]) { summary = nil; }

        NSString *icon = dictionary[@"icon"];
        if([icon isKindOfClass:[NSNull class]]) { icon = nil; }

        NSNumber *precipProbability = dictionary[@"precipProbability"];
        if([precipProbability isKindOfClass:[NSNull class]]) { precipProbability = nil; }

        NSNumber *precipIntensity = dictionary[@"precipIntensity"];
        if([precipIntensity isKindOfClass:[NSNull class]]) { precipIntensity = nil; }

        NSNumber *temperature = dictionary[@"temperature"];
        if([temperature isKindOfClass:[NSNull class]]) { temperature = nil; }

        NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
        if([apparentTemperature isKindOfClass:[NSNull class]]) { apparentTemperature = nil; }

        NSNumber *humidity = dictionary[@"humidity"];
        if([humidity isKindOfClass:[NSNull class]]) { humidity = nil; }

        NSNumber *pressure = dictionary[@"pressure"];
        if([pressure isKindOfClass:[NSNull class]]) { pressure = nil; }

        NSNumber *windSpeed = dictionary[@"windSpeed"];
        if([windSpeed isKindOfClass:[NSNull class]]) { windSpeed = nil; }

        NSNumber *windBearing = dictionary[@"windBearing"];
        if([windBearing isKindOfClass:[NSNull class]]) { windBearing = nil; }

        NSNumber *uvIndex = dictionary[@"uvIndex"];
        if([uvIndex isKindOfClass:[NSNull class]]) { uvIndex = nil; }

    }
    return self;
}

@end
