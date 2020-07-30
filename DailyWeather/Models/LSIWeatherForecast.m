//
//  LSIWeatherForecast.m
//  DailyWeather
//
//  Created by Claudia Maciel on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForecast.h"
#import "LSICurrentForecast.h"

@implementation LSIWeatherForecast

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithCurrently:(LSICurrentForecast *)currently daily:(NSDictionary *)daily hourly:(NSDictionary *)hourly latitude:(double)latitude longitude:(double)longitude timezone:(nonnull NSString *)timezone
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
    
    return [self initWithCurrently:currentForecast
                             daily:nil
                            hourly:nil
                          latitude:latitude.doubleValue
                         longitude:longitude.doubleValue
                          timezone:timezone];
}


@end
