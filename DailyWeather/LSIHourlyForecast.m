//
//  LSIHourlyForecast.m
//  DailyWeather
//
//  Created by Chris Gonzales on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIHourlyForecast.h"

@implementation LSIHourlyForecast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        NSNumber *unixTime = dictionary[@"time"];
        NSString *summary = dictionary[@"summary"];
        NSString *icon = dictionary[@"icon"];
        NSNumber *temperature = dictionary[@"temperature"];
        NSNumber *precipIntensity = dictionary[@"precipIntensity"];
        NSNumber *precipProbability = dictionary[@"precipProbability"];
        NSNumber *humidity = dictionary[@"humidity"];
        NSNumber *windSpeed = dictionary[@"windSpeed"];
        NSNumber *windBearing = dictionary[@"windBearing"];
        NSNumber *uvIndex = dictionary[@"uvIndex"];
        
        if (!(unixTime)) {
            return nil;
        }
        _date = [NSDate dateWithTimeIntervalSince1970:unixTime.longValue];
        _summary = summary;
        _icon = icon;
        _temperature = [temperature doubleValue];
        _precipIntensity = [precipIntensity doubleValue];
        _precipProbability = [precipProbability doubleValue];
        _humidity = [humidity doubleValue];
        _windSpeed = [windSpeed doubleValue];
        _windBearing = [windBearing doubleValue];
        _uvIndex = [uvIndex doubleValue];
    }
    return self;
}
@end
