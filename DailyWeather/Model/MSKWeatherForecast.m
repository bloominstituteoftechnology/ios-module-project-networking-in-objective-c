//
//  MSKWeatherForecast.m
//  DailyWeather
//
//  Created by Lambda_School_Loaner_268 on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "MSKWeatherForecast.h"



@implementation MSKCurrentForecast: NSObject
-(instancetype) initWithTime:(NSNumber *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
             precipIntensity:(NSNumber *) precipintensity
           precipProbability:(NSNumber *)precipProbability
                 temperature:(NSNumber *)temperature
         apparentTemperature:(NSNumber *)apparentTemperature
                    humidity:(NSNumber *)humidity
                    pressure:(NSNumber *)pressure
                   windSpeed:(NSNumber *)windSpeed
                 windBearing:(NSNumber *)windBearing
                     uvIndex:(NSNumber *)uvIndex {
    self = [super init];
    if (self) {
        _time = time;
        _summary = summary;
        _icon = icon;
        _precipIntensity = precipintensity;
        _precipProbability = precipProbability;
        _temperature = temperature;
        _apparentTemperature = apparentTemperature;
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
        _uvIndex = uvIndex;
    }
    return self;
}
-(instancetype)initWithDict:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _time = dictionary[@"time"];
        _summary = dictionary[@"summary"];
        _icon = dictionary[@"icon"];
        _precipIntensity = dictionary[@"precipintensity"];
        _precipProbability = dictionary[@"precipProbability"];
        _temperature = dictionary[@"temperature"];
        _apparentTemperature = dictionary[@"apparentTemperature"];
        _humidity = dictionary[@"humidity"];
        _pressure = dictionary[@"pressure"];
        _windSpeed = dictionary[@"windSpeed"];
        _windBearing = dictionary[@"windBearing"];
        _uvIndex = dictionary[@"uvIndex"];
    }
    return self;
}
@end
@implementation MSKDailyForecast: NSObject
-(instancetype) initWithTime:(NSNumber *)time
                     summary:(NSString *) summary
                        icon:(NSString *) icon
             precipIntensity:(NSNumber *) precipIntensity
           precipProbability:(NSNumber *) precipProbability
                  precipType:(NSString *) precipType
              temperatureLow:(NSNumber *)temperatureLow
             temperatureHigh:(NSNumber *) temperatureHigh
         apparentTemperature:(NSNumber *) apparentTemperature
                    humidity:(NSNumber *) humidity
                    pressure:(NSNumber *) pressure
                   windSpeed:(NSNumber *) windSpeed
                 windBearing:(NSNumber *) windBearing
                     uvIndex:(NSNumber *)uvIndex {
    self = [super init];
    if (self) {
        _time = time;
        _summary = summary;
        _icon = icon;
        _precipIntensity = precipIntensity;
        _precipProbability = precipProbability;
        _precipType = precipType;
        _temperatureLow = temperatureLow;
        _temperatureHigh = temperatureHigh;
        _apparentTemperature = apparentTemperature;
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
        _uvIndex = uvIndex;
    }
    return self;
}
-(instancetype)initWithDict:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _time = dictionary[@"time"];
        _summary = dictionary[@"summary"];
        _icon = dictionary[@"icon"];
        _precipIntensity = dictionary[@"precipintensity"];
        _precipProbability = dictionary[@"precipProbability"];
        _precipType = dictionary[@"precipType"];
        _temperatureLow = dictionary[@"temperatureLow"];
        _temperatureHigh = dictionary[@"temperatureHigh"];
        _apparentTemperature = dictionary[@"apparentTemperature"];
        _humidity = dictionary[@"humidity"];
        _pressure = dictionary[@"pressure"];
        _windSpeed = dictionary[@"windSpeed"];
        _windBearing = dictionary[@"windBearing"];
        _uvIndex = dictionary[@"uvIndex"];
    }
    return self;
}
@end
@implementation MSKHourlyForecast: NSObject
-(instancetype) initWithTime:(NSNumber *)time
                     summary:(NSString *) summary
                        icon:(NSString *) icon
             precipIntensity:(NSNumber *) precipIntensity
           precipProbability:(NSNumber *) precipProbability
                  precipType:(NSString *) precipType
              temperatureLow:(NSNumber *)temperatureLow
             temperatureHigh:(NSNumber *) temperatureHigh
         apparentTemperature:(NSNumber *) apparentTemperature
                    humidity:(NSNumber *) humidity
                    pressure:(NSNumber *) pressure
                   windSpeed:(NSNumber *) windSpeed
                 windBearing:(NSNumber *) windBearing
                     uvIndex:(NSNumber *) uvIndex {
    self = [super init];
    if (self) {
        _time = time;
        _summary = summary;
        _icon = icon;
        _precipIntensity = precipIntensity;
        _precipProbability = precipProbability;
        _precipType = precipType;
        _temperatureLow = temperatureLow;
        _temperatureHigh = temperatureHigh;
        _apparentTemperature = apparentTemperature;
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
        _uvIndex = uvIndex;
    }
    return self;
}
-(instancetype)initWithDict:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _time = dictionary[@"time"];
        _summary = dictionary[@"summary"];
        _icon = dictionary[@"icon"];
        _precipIntensity = dictionary[@"precipintensity"];
        _precipProbability = dictionary[@"precipProbability"];
        _precipType = dictionary[@"precipType"];
        _temperatureLow = dictionary[@"temperatureLow"];
        _temperatureHigh = dictionary[@"temperatureHigh"];
        _apparentTemperature = dictionary[@"apparentTemperature"];
        _humidity = dictionary[@"humidity"];
        _pressure = dictionary[@"pressure"];
        _windSpeed = dictionary[@"windSpeed"];
        _windBearing = dictionary[@"windBearing"];
        _uvIndex = dictionary[@"uvIndex"];
    }
    return self;
}
@end


@implementation MSKWeatherForecast
-(instancetype)initWithMSKCurrentForecast: (MSKCurrentForecast *) currentForcast
                            DailyForecast:(MSKDailyForecast *) dailyForecast
                            HourlyForcast:(MSKHourlyForecast *) hourlyForecast {
    self = [super init];
    if (self) {
        _currentForecast = currentForcast;
        _dailyForecast = dailyForecast;
        _houlyForecast = hourlyForecast;
    }
    return self;
}
/*
-(instancetype)initFromDict:(NSDictionary *) dict {
    self = [super init];
    if (self) {
        NSDictionary *currentDict = dict[@"Currently"];
        MSKCurrentForecast *currentForecast = [[MSKCurrentForecast alloc] initWithDict:currentDict];
        _currentForecast = currentForecast;
        NSDictionary *dailyMainDict = dict[@"daily"];
        NSArray *dailyDataArray = dailyMainDict[@"data"]
        for NSDictionary *dayDict in dailyDataArray {
        MSKDailyForecast *dailyForecast = [[MSKDailyForecast alloc] initWithDict:dailyDict];
        _dailyForecast = dailyForecast;
        NSDictionary *hourlyDict = dict[@"hourly"];
        MSKHourlyForecast *hourlyForecast =
        [[MSKHourlyForecast alloc] initWithDict:hourlyDict];
        _houlyForecast = hourlyForecast;
    }
    return self;
    
}
@end
*/
@end
