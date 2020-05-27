//
//  AMSWeather.m
//  DailyWeather
//
//  Created by Alexander Supe on 19.03.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "AMSWeather.h"
#import "AMSForcast.h"

@implementation AMSWeather

- (instancetype)initWithCurrently:(AMSCurrentForecast *)currently
                            daily:(NSMutableArray<AMSDailyWeather *> *)daily
                           hourly:(NSMutableArray<AMSHourlyWeather *> *)hourly {
    if (self = [super init]) {
        _currently = currently;
        _daily = daily;
        _hourly = hourly;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSDictionary *dailysData = dictionary[@"daily"];
    NSArray *dailys = dailysData[@"data"];
    NSDictionary *hourlysData = dictionary[@"hourly"];
    NSArray *hourlys = hourlysData[@"data"];
    AMSCurrentForecast *currently = [[AMSCurrentForecast alloc] initWithDictionary:dictionary[@"currently"]];
    NSMutableArray<AMSDailyWeather *> *daily = NSMutableArray.new;
    NSMutableArray<AMSHourlyWeather *> *hourly = NSMutableArray.new;
    
    for (NSDictionary *element in dailys) {
        AMSDailyWeather *weather = [[AMSDailyWeather alloc] initWithDictionary:element];
        [daily addObject:weather];
    }
    
    for (NSDictionary *element in hourlys) {
        AMSHourlyWeather *weather = [[AMSHourlyWeather alloc] initWithDictionary:element];
        [hourly addObject:weather];
    }
    
    self = [self initWithCurrently:currently
                             daily:daily
                            hourly:hourly];
    
    return self;
}

@end
