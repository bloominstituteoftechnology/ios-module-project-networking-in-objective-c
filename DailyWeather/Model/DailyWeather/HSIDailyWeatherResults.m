//
//  HSIDailyWeatherResults.m
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import "HSIDailyWeatherResults.h"
#import "HSIDailyWeather.h"

@implementation HSIDailyWeatherResults

- (instancetype)initWithArray:(NSMutableArray<HSIDailyWeather *> *)array {
    HSIDailyWeatherResults *dailyWeatherObject = [HSIDailyWeatherResults alloc];
    dailyWeatherObject.days = array;
    if (dailyWeatherObject.days) {
        return dailyWeatherObject;
    } else {
        return nil;
    }
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSDictionary *daily = dictionary[@"daily"];
    NSArray *data = daily[@"data"];
    NSMutableArray *dailyResults = [[NSMutableArray<HSIDailyWeather *> alloc] init];
    for (NSDictionary *resultDictionary in data) {

        NSString *icon = resultDictionary[@"icon"];
        NSNumber *lowTemperature = resultDictionary[@"temperatureLow"];
        NSNumber *highTemperature = resultDictionary[@"temperatureHigh"];

        if (icon && lowTemperature && highTemperature) {
            HSIDailyWeather *dailyWeather = [[HSIDailyWeather alloc] initWithIcon:icon
                                                                  highTemperature:highTemperature.doubleValue
                                                                   lowTemperature:lowTemperature.doubleValue];
            [dailyResults addObject: dailyWeather];
        }
    }

    if (dailyResults) {
        return [[HSIDailyWeatherResults alloc] initWithArray:dailyResults];
    } else {
        return nil;
    }
    
}

@end
