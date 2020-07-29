//
//  LSIWeatherForcast.m
//  DailyWeather
//
//  Created by Matthew Martindale on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForcast.h"
#import "LSICurrentForecast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

@class LSICurrentForecast;

@implementation LSIWeatherForcast

- (instancetype)initWithLatitude:(double)latitude
                       longitude:(double)longitude
                        timezone:(NSString *)timezone
                 currentForecast:(LSICurrentForecast *)currently
                   dailyForecast:(NSArray<LSIDailyForecast *> *)daily
                  hourlyForecast:(NSArray<LSIHourlyForecast *> *)hourly
{
    if (self = [super init]) {
        _latitude = latitude;
        _longitude = longitude;
        _timezone = timezone.copy;
        _currently = currently;
        _daily = daily.copy;
        _hourly = hourly.copy;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *latitude = [dictionary objectForKey:@"latitude"];
    if (![latitude isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *longitude = [dictionary objectForKey:@"longitude"];
    if (![longitude isKindOfClass:NSNumber.class]) return nil;
    
    NSString *timezone = [dictionary objectForKey:@"timezone"];
    if (![timezone isKindOfClass:NSString.class]) return nil;
    
    // Currently dictionary
    // optional
    NSDictionary *currently = [dictionary objectForKey:@"currently"];
    if ([currently isKindOfClass:NSNull.class]) currently = nil;
    else if (![currently isKindOfClass:NSDictionary.class]) return nil;
    
    LSICurrentForecast *currentForecast = [[LSICurrentForecast alloc] initWithDictionary:currently];
    
    // Daily dictionary
    // optional
    NSDictionary *daily = [dictionary objectForKey:@"daily"];
    if ([daily isKindOfClass:NSNull.class]) daily = nil;
    else if (![daily isKindOfClass:NSDictionary.class]) return nil;
    
    // Data for daily dictionary
    NSArray *dailyDataDictionary = [daily objectForKey:@"data"];
    if (![dailyDataDictionary isKindOfClass:NSArray.class]) return nil;
    
    NSMutableArray *dailyData = [[NSMutableArray alloc] initWithCapacity:dailyDataDictionary.count];
    
    for (NSDictionary *dailyDictionary in daily) {
        if (![dailyDictionary isKindOfClass:NSDictionary.class]) continue;
        
        LSIDailyForecast *dailyForecast = [[LSIDailyForecast alloc] initWithDictionary:daily];
        
        if (dailyForecast) {
            [dailyData addObject:dailyForecast];
        } else {
            NSLog(@"Unable to parse daily forecast data: %@", dailyDictionary);
        }
    }
    
    // Hourly dictionary
    // optional
    NSDictionary *hourly = [dictionary objectForKey:@"hourly"];
    if ([hourly isKindOfClass:NSNull.class]) hourly = nil;
    else if (![hourly isKindOfClass:NSDictionary.class]) return nil;
    
    // Data for hourly dictionary
    NSArray *hourlyDataDictionary = [hourly objectForKey:@"data"];
    if (![hourlyDataDictionary isKindOfClass:NSArray.class]) return nil;
    
    NSMutableArray *hourlyData = [[NSMutableArray alloc] initWithCapacity:hourlyDataDictionary.count];
    
    for (NSDictionary *hourlyDictionary in hourly) {
        if (![hourlyDictionary isKindOfClass:NSDictionary.class]) continue;
        
        LSIHourlyForecast *hourlyForecast = [[LSIHourlyForecast alloc] initWithDictionary:hourly];
        
        if (hourlyForecast) {
            [hourlyData addObject:hourlyForecast];
        } else {
            NSLog(@"Unable to parse hourly forecast data: %@", hourlyDictionary);
        }
    }
    
    return [self initWithLatitude:latitude.doubleValue
                        longitude:longitude.doubleValue
                         timezone:timezone
                  currentForecast:currentForecast
                    dailyForecast:dailyData
                   hourlyForecast:hourlyData];
    
    
}

@end
