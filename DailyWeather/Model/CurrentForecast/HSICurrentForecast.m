//
//  HSICurrentForecast.m
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import "HSICurrentForecast.h"

@implementation HSICurrentForecast

- (instancetype) initWithTime:(NSDate *)time
                      summary:(NSString *)summary
                         icon:(NSString *)icon
            precipProbability:(double)precipProbability
              precipIntensity:(double)precipIntensity
                  temperature:(double)temperature
          apparentTemperature:(double)apparentTemperature
                     humidity:(double)humidity
                     pressure:(double)pressure
                    windSpeed:(double)windSpeed
                  windBearing:(int)windBearing {

    self = [super init];

    if (self) {
        _time = time;
        _summary = summary;
        _icon = icon;
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _temperature = temperature;
        _apparentTemperature = apparentTemperature;
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
    }
    return self;
}

- (instancetype) initWithDictionary:(NSDictionary *) dictionary {

    NSNumber *timeValue = dictionary[@"time"];
    NSString *summary = dictionary[@"summary"];
    NSString *icon = dictionary[@"icon"];

    NSNumber *precipProbability = dictionary[@"precipProbability"];
    NSNumber *precipIntensity = dictionary[@"precipIntensity"];

    NSNumber *temperature = dictionary[@"temperature"];
    NSNumber *apparentTemperature = [NSNumber alloc];
    if (temperature) {
        apparentTemperature = dictionary[@"apparentTemperature"];
    }

    NSNumber *humidity = dictionary[@"humidity"];
    NSNumber *pressure = dictionary[@"pressure"];

    NSNumber *windSpeed = dictionary[@"windSpeed"];
    NSNumber *windBearing = [NSNumber alloc];
    if (windSpeed) {
        windBearing = dictionary[@"windBearing"];
    }

    NSDate *time = [[NSDate alloc] initWithTimeIntervalSince1970:timeValue.longValue];

    if (time && summary && icon && precipProbability && precipIntensity && temperature && humidity && pressure && windSpeed) {
        return [self initWithTime:time
                          summary:[summary copy]
                             icon:[icon copy]
                precipProbability:precipProbability.doubleValue
                  precipIntensity:precipIntensity.doubleValue
                      temperature:temperature.doubleValue
              apparentTemperature:apparentTemperature.doubleValue
                         humidity:humidity.doubleValue
                         pressure:pressure.doubleValue
                        windSpeed:windSpeed.doubleValue
                      windBearing:windBearing.intValue];
    } else {
        return nil;
    }
}

@end
