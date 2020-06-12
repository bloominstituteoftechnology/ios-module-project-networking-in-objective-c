//
//  LSIDailyForcast.m
//  DailyWeather
//
//  Created by Bhawnish Kumar on 6/10/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForcast.h"

@implementation LSIDailyForcast

- (instancetype)initWithTime:(NSDate *)time
            summary:(NSString *)summary
               icon:(NSString *)icon
        sunriseTime:(NSDate *)sunriseTime
         sunsetTime:(NSDate *)sunsetTime
  precipProbability:(NSNumber *)precipProbability
   precipeIntensity:(NSNumber *)precipeIntensity
         precipType:(NSString *)precipType
     temperatureLow:(NSNumber *)temperatureLow
    temperatureHigh:(NSNumber *)temperatureHigh
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
        _sunriseTime = sunriseTime;
        _sunsetTime = sunsetTime;
       _precipProbability = precipProbability;
       _precipType = [precipType copy];
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

@end
