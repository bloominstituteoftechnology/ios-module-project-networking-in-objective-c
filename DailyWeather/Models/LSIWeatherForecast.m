//
//  LSIWeatherForecast.m
//  DailyWeather
//
//  Created by Claudia Maciel on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForecast.h"
#import "LSICurrentForecast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

@implementation LSIWeatherForecast

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithCurrently:(LSICurrentForecast *)currently daily:(NSArray<LSIDailyForecast *> *)daily hourly:(NSArray<LSIHourlyForecast *> *)hourly latitude:(double)latitude longitude:(double)longitude timezone:(nonnull NSString *)timezone
{
    if (self = [super init])
    {
        _currently = currently;
        _daily = daily;
        _hourly = hourly;
        _latitude = latitude;
        _longitude = longitude;
        _timezone = timezone;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *latitude = [dictionary objectForKey:@"latitude"];
    if (![latitude isKindOfClass:[NSNumber class]]) return nil;

    NSNumber *longitude = [dictionary objectForKey:@"longitude"];
    if (![longitude isKindOfClass:[NSNumber class]]) return nil;

    NSString *timezone = [dictionary objectForKey:@"timezone"];
    if ([timezone isKindOfClass:[NSNull class]]) timezone = nil;
    else if (![timezone isKindOfClass:[NSString class]]) return nil;
    
    NSDictionary *currentForecastDictionary = [dictionary objectForKey:@"currently"];
    if ([currentForecastDictionary isKindOfClass:[NSNull class]]) currentForecastDictionary = nil;
    else if (![currentForecastDictionary isKindOfClass:[NSDictionary class]]) return nil;

    LSICurrentForecast *currentForecast = [[LSICurrentForecast alloc] initWithDictionary:currentForecastDictionary];
    
    NSDictionary *dailyDictionary = [dictionary objectForKey:@"daily"];
    if (![dailyDictionary isKindOfClass:[NSDictionary class]]) return nil;

    NSArray *dailyDataDictionaries = [dailyDictionary objectForKey:@"data"];
    if (![dailyDataDictionaries isKindOfClass:[NSArray class]]) return nil;

    NSMutableArray *dailyForecasts = [[NSMutableArray alloc] initWithCapacity:dailyDataDictionaries.count];

    for (NSDictionary *dailyDataDictionary in dailyDataDictionaries) {
        if (![dailyDataDictionary isKindOfClass:[NSDictionary class]]) continue;

        LSIDailyForecast *dailyForecast = [[LSIDailyForecast alloc] initWithDictionary:dailyDataDictionary];

        if (dailyForecast) {
            [dailyForecasts addObject:dailyForecast];
        } else {
            NSLog(@"Unable to parse daily data dictionary: %@", dailyDataDictionary);
        }
    }

    NSDictionary *hourlyDictionary = [dictionary objectForKey:@"hourly"];
    if (![hourlyDictionary isKindOfClass:[NSDictionary class]]) return nil;

    NSArray *hourlyDataDictionaries = [hourlyDictionary objectForKey:@"data"];
    if (![hourlyDataDictionaries isKindOfClass:[NSArray class]]) return nil;

    NSMutableArray *hourlyForecasts = [[NSMutableArray alloc] initWithCapacity:hourlyDataDictionaries.count];

    for (NSDictionary *hourlyDataDictionary in hourlyDataDictionaries) {
        if (![hourlyDataDictionary isKindOfClass:[NSDictionary class]]) continue;

        LSIHourlyForecast *hourlyForecast = [[LSIHourlyForecast alloc] initWithDictionary:hourlyDataDictionary];

        if (hourlyForecast) {
            [hourlyForecasts addObject:hourlyForecast];
        } else {
            NSLog(@"Unable to parse hourly data dictionary: %@", hourlyDataDictionary);
        }
    }
    
    return [self initWithCurrently:currentForecast
                             daily:dailyForecasts
                            hourly:hourlyForecasts
                          latitude:latitude.doubleValue
                         longitude:longitude.doubleValue
                          timezone:timezone];
}


@end
