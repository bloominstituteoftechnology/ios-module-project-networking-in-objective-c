//
//  LSIWeatherForecast.m
//  DailyWeather
//
//  Created by Chris Gonzales on 4/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForecast.h"
#import "LSICurrentForecast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

@implementation LSIWeatherForecast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSNumber *latitudeNumber = dictionary[@"latitude"];
        NSNumber *longitudeNumber = dictionary[@"longitude"];
        NSDictionary *currently = dictionary[@"currently"];
        NSDictionary *dailyOverview = dictionary[@"daily"];
        NSArray<LSIDailyForecast *> *daily = dailyOverview[@"data"];
        
        NSDictionary *hourlyOverview = dictionary[@"hourly"];
        NSArray<LSIHourlyForecast *> *hourly = hourlyOverview[@"data"];
        
        LSICurrentForecast *currentForecast = [[LSICurrentForecast alloc] initWithDictionary:currently];
        
        NSMutableArray *dailyForecastArray = [[NSMutableArray alloc] init];
        for (NSDictionary *day in daily) {
            LSIDailyForecast *dailyForecast = [[LSIDailyForecast alloc] initWithDictionary:day];
            [dailyForecastArray addObject: dailyForecast];
        }
        
        NSMutableArray *hourlyForecastArray = [[NSMutableArray alloc] init];
        for (NSDictionary *hour in hourly) {
            LSIHourlyForecast *hourlyForecast = [[LSIHourlyForecast alloc] initWithDictionary:hour];
            [hourlyForecastArray addObject: hourlyForecast];
        }
        
        if (!(latitudeNumber && longitudeNumber)) {
            NSLog(@"ERROR: Unable to parse JSON for WeatherForecast: %@", dictionary);
            return nil;
        }
    
        _current = currentForecast;
        _daily = dailyForecastArray;
        _hourly = hourlyForecastArray;
    }
    return self;
}
@end

// Should I verify data for all optional types in the .m for the corresponding model??

//    if ([summary isKindOfClass:[NSNull class]]) {
//        summary = nil;
//    }
//    if ([icon isKindOfClass:[NSNull class]]) {
//        icon = nil;
//    }
//    if ([precipProbability isKindOfClass:[NSNull class]]) {
//        precipProbability = nil;
//    }
//    if ([precipIntensity isKindOfClass:[NSNull class]]) {
//           precipIntensity = nil;
//       }
//    if ([temperature isKindOfClass:[NSNull class]]) {
//        temperature = nil;
//    }
//    if ([apparentTemperature isKindOfClass:[NSNull class]]) {
//        apparentTemperature = nil;
//    }
//    if ([humidity isKindOfClass:[NSNull class]]) {
//        humidity = nil;
//    }
//    if ([pressure isKindOfClass:[NSNull class]]) {
//        pressure = nil;
//    }
//    if ([windSpeed isKindOfClass:[NSNull class]]) {
//        windSpeed = nil;
//    }
//    if ([windBearing isKindOfClass:[NSNull class]]) {
//        windBearing = nil;
//    }
//    if ([uvIndex isKindOfClass:[NSNull class]]) {
//        uvIndex = nil;
//    }
