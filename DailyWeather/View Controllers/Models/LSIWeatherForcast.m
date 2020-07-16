//
//  LSIWeatherForcast.m
//  DailyWeather
//
//  Created by Nonye on 7/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForcast.h"

@implementation LSIWeatherForcast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(NSNumber *)precipProbability
             precipIntensity:(NSNumber *)precipIntensity
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
        _summary = [summary copy];
        _icon = [icon copy];
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
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
    
    NSNumber *timeNumber = dictionary[@"time"];
    NSString *summary = dictionary[@"summary"];
    NSString *icon = dictionary[@"icon"];
    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];
    NSNumber *temperature = dictionary[@"temperature"];
    NSNumber *apparentTemperature = dictionary[@"apparentTemperature"];
    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];
    NSNumber *windBearing = dictionary[@"windBearing"];
    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *uvIndex = dictionary[@"uvIndex"];
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue / 1000.0];
    // TODO - if statements
    
    
//    if (!(magnitude &&
//          place &&
//          time &&
//          latitudeNumber &&
//          longitudeNumber)) {
//        // This makes the intializer "failable"
//        return nil;
//    }
    
    if (!(time &&
          summary &&
          icon &&
          precipProbability &&
          precipIntensity &&
          temperature &&
          apparentTemperature &&
          humidity &&
          pressure &&
          windBearing &&
          windSpeed &&
          uvIndex)) {
    return nil;
}
    
    return [self initWithTime:time
                      summary:summary
                         icon:icon
            precipProbability:precipProbability
              precipIntensity:precipIntensity
                  temperature:temperature
          apparentTemperature:apparentTemperature
                     humidity:humidity
                     pressure:pressure
                    windSpeed:windSpeed
                  windBearing:windBearing
                      uvIndex:uvIndex];

    }

    @end

