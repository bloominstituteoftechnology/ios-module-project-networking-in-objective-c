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
    
    NSNumber *latitudeNumber = dictionary[@"latitude"];
    NSNumber *longitudeNumber = dictionary[@"longitude"];
    
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
    
    _location = CLLocationCoordinate2DMake(latitudeNumber.doubleValue, longitudeNumber.doubleValue);
    _currently = currentForecast;
    _daily = dailyArray;
    _hourly = hourlyArray;

    return self;
}



@end
