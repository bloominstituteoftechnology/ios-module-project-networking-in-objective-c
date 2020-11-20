//
//  BRSCurrentForecast.m
//  DailyWeather
//
//  Created by BrysonSaclausa on 11/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "BRSCurrentForecast.h"

@implementation BRSCurrentForecast

// create init

- (instancetype)initWithTime:(NSDate *)time summary:(NSString *)summary icon:(NSString *)icon precipIntensity:(double)precipIntensity precipProbability:(double)precipProbability temperature:(double)temperature apparentTemperature:(double)apparentTemperature humidity:(double)humidity pressure:(double)pressure windSpeed:(double)windSpeed windBearing:(double)windBearing uvIndex:(double)uvIndexs {
    
    if (self = [super init]) {
        _time = [NSDate new];
        _summary = [NSString new];
        _icon = [NSString new] ; // dict["icon"]
        _precipIntensity = 0;// dict["precipIntensity"]
        
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSTimeInterval unixTime = [dictionary[@"time"] doubleValue];
    if (self = [super init]) {
        _time = [NSDate dateWithTimeIntervalSince1970:unixTime];
        _summary = dictionary[@"summary"];
        
    }
    return self;
}
  


@end

/*
 
 person.name
 [person name]
 
 person.age
 [person age]
 
 person.changeName(to: Steven)
 [person changeName: @"Steven"]
 
 */



