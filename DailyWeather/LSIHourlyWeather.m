//
//  LSIHourlyWeather.m
//  DailyWeather
//
//  Created by Bhawnish Kumar on 6/10/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIHourlyWeather.h"

@implementation LSIHourlyWeather

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(NSNumber *)precipProbability
                  precipType:(NSString *)precipType
                 temperature:(NSNumber *)temperature
         apparentTemperature:(NSNumber *)apparentTemperature
                    humidity:(NSNumber *)humidity
                    pressure:(NSNumber *)pressure
                   windSpeed:(NSNumber *)windSpeed
                 windBearing:(NSNumber *)windBearing
                     uvIndex:(NSNumber *)uvIndex
{
    self = [super init];
    if (self) {
        _time = time;
        _summary = [summary copy];
        _icon = [icon copy];
        _precipProbability = precipProbability;
        _precipType = [precipType copy];
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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSNumber *time = dictionary[@"time"];
    NSString *summary = dictionary[@"summary"];
    NSString *icon = dictionary[@"icon"];
    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSString *precipType = dictionary[@"precipType"];
    NSNumber *temperature = dictionary[@"temperature"];
    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];
    
    double timeInMiliseconds = time.doubleValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInMiliseconds / 1000.00];
    
    if ([precipProbability   isKindOfClass:[NSNull class]]) { precipProbability   = nil; }
       if ([temperature         isKindOfClass:[NSNull class]]) { temperature         = nil; }
       if ([apparentTemperature isKindOfClass:[NSNull class]]) { apparentTemperature = nil; }
       if ([humidity            isKindOfClass:[NSNull class]]) { humidity            = nil; }
       if ([pressure            isKindOfClass:[NSNull class]]) { pressure            = nil; }
       if ([windSpeed           isKindOfClass:[NSNull class]]) { windSpeed           = nil; }
       if ([windBearing         isKindOfClass:[NSNull class]]) { windBearing         = nil; }
       if ([uvIndex             isKindOfClass:[NSNull class]]) { uvIndex             = nil; }
    
    
    if (!time) {
        return nil;
    }
    
    return [self initWithTime:date
                      summary:summary
                         icon:icon
            precipProbability:precipProbability
                   precipType:precipType
                  temperature:temperature
          apparentTemperature:apparentTemperature
                     humidity:humidity
                     pressure:pressure
                    windSpeed:windSpeed
                  windBearing:windBearing
                      uvIndex:uvIndex];
    
}


@end
