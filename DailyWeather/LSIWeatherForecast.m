//
//  LSIWeatherForecast.m
//  DailyWeather
//
//  Created by Kelson Hartle on 7/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForecast.h"
#import "LSICurrentForecast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

@implementation LSIWeatherForecast



- (instancetype)initWithDictionary:(NSDictionary *)dictionary; {
    NSDictionary *currentlyDictionary = dictionary[@"currently"];
    NSDictionary *dailyDictionary = dictionary[@"daily"];
    NSArray<LSIDailyForecast *> *daily = dailyDictionary[@"data"];
    
    NSDictionary *houlryDictionary = dictionary [@"hourly"];
    NSArray<LSIHourlyForecast *> *hourly = houlryDictionary[@"data"];

    
    LSICurrentForecast *currentForecast = [[LSICurrentForecast alloc] initWithDictionary:currentlyDictionary];
    
    NSMutableArray *dailyArray = [[NSMutableArray alloc] init];
    for (NSDictionary *day in daily) {
        LSIDailyForecast *dailyForecast = [[LSIDailyForecast alloc] initWithDictionary:day];
        [dailyArray addObject:dailyForecast];
        
    }
    
    NSMutableArray *hourlyArray = [[NSMutableArray alloc] init];
    for (NSDictionary *hour in hourly) {
        LSIHourlyForecast *hourlyForecast = [[LSIHourlyForecast alloc] initWithDictionary:hour];
        [hourlyArray addObject: hourlyForecast];
    }
    
    _currently = currentForecast;
    _daily = dailyArray;
    _hourly = hourlyArray;
    
    
//    NSDictionary *dailyDictionary = [dictionary objectForKey:@"daily"];
//    if (![dailyDictionary isKindOfClass:[NSDictionary class]]) return nil;
//
//    NSArray *dailyDataDictionaries = [dailyDictionary objectForKey:@"data"];
//    if (![dailyDataDictionaries isKindOfClass:[NSArray class]]) return nil;
//
//    NSMutableArray *dailyForecasts = [[NSMutableArray alloc] initWithCapacity:dailyDataDictionaries.count];
//
//    for (NSDictionary *dailyDataDictionary in dailyDataDictionaries) {
//        if (![dailyDataDictionary isKindOfClass:[NSDictionary class]]) continue;
//
//        LSIDailyForecast *dailyForecast = [[LSIDailyForecast alloc] initWithDictionary:dailyDataDictionary];
//
//        if (dailyForecast) {
//            [dailyForecasts addObject:dailyForecast];
//        } else {
//            NSLog(@"Unable to parse daily data dictionary: %@", dailyDataDictionary);
//        }
//    }
//
//
//    NSDictionary *hourlyDictionary = [dictionary objectForKey:@"hourly"];
//    NSArray *hourlyData = [hourlyDictionary objectForKey:@"data"];
//
//    NSMutableArray *hourlyForecasts = [[NSMutableArray alloc] initWithCapacity:hourlyData.count];
//
//    for (NSDictionary *hourlyDataDictionary in hourlyData) {
//
//        LSIHourlyForecast *hourlyForecast = [[LSIHourlyForecast alloc] initWithDictionary:hourlyDataDictionary];
//
//        if (hourlyForecast) {
//            [hourlyForecasts addObject:hourlyForecast];
//        } else {
//            NSLog(@"ERROR");
//        }
//    }
//    return [self initWithCurrentForecast:currentForecast dailyForecast:dailyForecasts hourlyForecast:hourlyForecasts];
    return self;
}



@end
