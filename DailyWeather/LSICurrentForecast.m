//
//  LSICurrentForecast.m
//  DailyWeather
//
//  Created by Chris Gonzales on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSICurrentForecast.h"

@implementation LSICurrentForecast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        NSTimeInterval unixTime = [dictionary[@"time"] doubleValue];
        _time = [NSDate dateWithTimeIntervalSince1970:unixTime];
        _summary = dictionary[@"summary"];
        _icon = dictionary[@"icon"];
        _temperature = [dictionary[@"temperature"] doubleValue];
        _windSpeed = [dictionary[@"windSpeed"] doubleValue];
        _windBearing = [dictionary[@"windBearing"] doubleValue];
    }
    return self;
}

@end
