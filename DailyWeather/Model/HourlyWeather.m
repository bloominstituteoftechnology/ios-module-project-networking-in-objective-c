//
//  HourlyWeather.m
//  DailyWeather
//
//  Created by Nick Nguyen on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "HourlyWeather.h"

@implementation HourlyWeather

- (instancetype)initWithIcon:(NSString *)icon time:(NSDate*)time temperature:(double)temperature
{
    self = [super init];
    if (self) {
        _icon = [icon copy];
        _time = time;
        _temperature = temperature;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary index:(int )index
{
    
    NSDictionary *hourly = dictionary[@"hourly"];
    NSArray *data = hourly[@"data"];
    NSNumber *timeNumber = data[index][0];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue / 1000.0];
    
    NSString *icon = data[index][2];
    NSNumber *temperature = data[index][5];

    self = [self initWithIcon:icon time:time temperature:temperature.doubleValue];
   
    return self;
}

@end
