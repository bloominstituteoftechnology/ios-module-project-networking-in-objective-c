//
//  LSIWeatherForcast.m
//  DailyWeather
//
//  Created by Jessie Ann Griffin on 5/26/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForcast.h"

@implementation LSIWeatherForcast

- (instancetype)initWithCurrently:(NSDictionary *)currently
                            daily:(NSDictionary *)daily
                           hourly:(NSDictionary *)hourly
{
    if (self = [super init]) {
        _currently = currently;
        _daily = daily;
        _hourly = hourly;
    }
    return self;
}

//- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary
//{
//    NSDictionary *currently = [dictionary objectForKey:@"currently"];
//    if (![currently isKindOfClass:[NSDictionary class]]) return nil;
//
//    NSNumber *timeInMilliseconds = [currently objectForKey:@"time"];
//    if (![timeInMilliseconds isKindOfClass:[NSNumber class]]) return nil;
//    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000.0];
//
//    NSString *summary = [currently objectForKey:@"summary"];
//    if (![summary isKindOfClass:[NSString class]]) return nil;
//
//    NSString *icon = [currently objectForKey:@"icon"];
//    if (![icon isKindOfClass:[NSString class]]) return nil;
//
//    NSNumber *precipProbability = [currently objectForKey:@"precipProbability"];
//    if (![precipProbability isKindOfClass:[NSNumber class]]) return nil;
//
//    NSNumber *precipIntensity = [currently objectForKey:@"precipIntensity"];
//    if (![precipIntensity isKindOfClass:[NSNumber class]]) return nil;
//
//    NSNumber *temperature = [currently objectForKey:@"temperature"];
//    if (![temperature isKindOfClass:[NSNumber class]]) return nil;
//
//    NSNumber *humidity = [dictionary objectForKey:@"humidity"];
//    if (![humidity isKindOfClass:[NSNumber class]]) return nil;
//
//    NSNumber *pressure = [dictionary objectForKey:@"pressure"];
//    if (![pressure isKindOfClass:[NSNumber class]]) return nil;
//
//    NSNumber *windSpeed = [dictionary objectForKey:@"windSpeed"];
//    if (![windSpeed isKindOfClass:[NSNumber class]]) return nil;
//
//    NSString *windBearing = [dictionary objectForKey:@"windBearing"];
//    if (![windBearing isKindOfClass:[NSString class]]) return nil;
//
//    NSNumber *uvIndex = [dictionary objectForKey:@"uvIndex"];
//    if (![uvIndex isKindOfClass:[NSNumber class]]) return nil;
//
//    return [self ];

//}

@end
