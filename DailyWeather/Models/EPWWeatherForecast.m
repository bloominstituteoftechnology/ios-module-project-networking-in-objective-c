//
//  EPWWeatherForecast.m
//  DailyWeather
//
//  Created by Elizabeth Wingate on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "EPWWeatherForecast.h"
#import "EPWCurrentForecast.h"
#import "EPWDailyWeather.h"
#import "EPWHourlyWeather.h"

@implementation EPWWeatherForecast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSNumber *latitudeNumber = dictionary[@"latitude"];
        NSNumber *longitudeNumber = dictionary[@"longitude"];
        NSDictionary *currently = dictionary[@"currently"];
        NSDictionary *dailyOverview = dictionary[@"daily"];
        NSArray<EPWDailyWeather*> *daily = dailyOverview[@"data"];
        
        NSDictionary *hourlyOverview = dictionary[@"hourly"];
        NSArray<EPWHourlyWeather *> *hourly = hourlyOverview[@"data"];
        
        EPWCurrentForecast *currentForecast = [[EPWCurrentForecast alloc] initWithDictionary:currently];
        
        NSMutableArray *dailyArray = [[NSMutableArray alloc] init];
        for (NSDictionary *day in daily) {
            EPWDailyWeather *dailyForecast = [[EPWDailyWeather alloc] initWithDictionary:day];
            [dailyArray addObject: dailyForecast];
        }
        
        NSMutableArray *hourlyArray = [[NSMutableArray alloc] init];
        for (NSDictionary *hour in hourly) {
            EPWHourlyWeather *hourlyForecast = [[EPWHourlyWeather alloc] initWithDictionary:hour];
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
