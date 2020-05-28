//
//  LSIWeatherForcast.m
//  DailyWeather
//
//  Created by David Wright on 5/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForcast.h"
#import "LSICurrentForecast.h"

@implementation LSIWeatherForcast

- (instancetype)initWithCurrentForecast:(LSICurrentForecast *)currentForecast
{
    if (self = [super init]) {
        _currentForecast = currentForecast;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    LSICurrentForecast *currentForecast = [[LSICurrentForecast alloc] initWithDictionary:dictionary];
    if (![currentForecast isKindOfClass:[NSDictionary class]]) return nil;
    
    return [self initWithCurrentForecast:currentForecast];
}

@end
