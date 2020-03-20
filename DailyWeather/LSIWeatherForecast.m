//
//  LSIWeatherForecast.m
//  DailyWeather
//
//  Created by Michael on 3/19/20.
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
        
        NSMutableArray *dailyArray = [[NSMutableArray alloc] init];
        for (NSDictionary *day in daily) {
            LSIDailyForecast *dailyForecast = [[LSIDailyForecast alloc] initWithDictionary:day];
            [dailyArray addObject: dailyForecast];
        }
        
        NSMutableArray *hourlyArray = [[NSMutableArray alloc] init];
        for (NSDictionary *hour in hourly) {
            LSIHourlyForecast *hourlyForecast = [[LSIHourlyForecast alloc] initWithDictionary:hour];
            [hourlyArray addObject: hourlyForecast];
        }
        
        if (!(latitudeNumber && longitudeNumber)) {
            NSLog(@"ERROR: Unable to parse JSON for WeatherForecast: %@", dictionary);
            return nil;
        }
        
        _location = CLLocationCoordinate2DMake(latitudeNumber.doubleValue, longitudeNumber.doubleValue);
        _current = currentForecast;
        _daily = dailyArray;
        _hourly = hourlyArray;
    }
    return self;
}

@end
