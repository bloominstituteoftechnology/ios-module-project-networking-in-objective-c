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
        }
        return self;
}

/*
 //r=required o=optional //d=dependent on above property
 @property (nonatomic) NSDate *time; //r

 @property (nonatomic, copy) NSString *summary; //o

 @property (nonatomic, copy) NSString *icon; //o

 @property (nonatomic) double precipProbability; //o
 @property (nonatomic) double precipIntensity; //o d

 @property (nonatomic) double temperature; //o
 @property (nonatomic) double apparentTemperature; //o d

 @property (nonatomic) double humidity; //o

 @property (nonatomic) double pressure; //o

 @property (nonatomic) double windSpeed; //o
 @property (nonatomic) int windBearing; //o d
 */
- (instancetype) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];

    if (self) {
        NSNumber *timeValue = dictionary[@"time"];
        NSString *summary = dictionary[@"summary"];
        NSString *icon = dictionary[@"icon"];

        NSNumber *precipProbability = dictionary[@"precipProbability"];
        //while this is dependent on probability, it's guaranteed to be between 0-1
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

        if (time && summary && icon && precipProbability && precipIntensity && temperature && humidity && pressure && windBearing) {
            return [self initWithTime:time
                       summary:summary
                          icon:icon
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
    return self;
}

@end
