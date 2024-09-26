//
//  LSIDailyForecast.m
//  DailyWeather
//
//  Created by Chris Gonzales on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForecast.h"

@implementation LSIDailyForecast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) { return nil; }
    
    NSNumber *unixTime = dictionary[@"time"];
    NSString *icon = dictionary[@"icon"];
    NSString *summary = dictionary[@"summary"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];
    
    if (!(unixTime)) {
        return nil;
    }
    
    _icon = icon;
    _summary = summary;
    _precipIntensity = [precipIntensity doubleValue];
    _precipProbability = [precipProbability doubleValue];
    _humidity = [humidity doubleValue];
    _windSpeed = [windSpeed doubleValue];
    _windBearing = [windBearing doubleValue];
    _uvIndex = [uvIndex doubleValue];
    
    return self;
}

@end
