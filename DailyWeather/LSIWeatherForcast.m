//
//  LSIWeatherForcast.m
//  DailyWeather
//
//  Created by Bhawnish Kumar on 6/10/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForcast.h"

@implementation LSIWeatherForcast

- (instancetype)initWithTime:(NSDate *)time
            summary:(NSString *)summary
               icon:(NSString *)icon
  precipProbability:(NSNumber *)precipProbability
   precipeIntensity:(NSNumber *)precipeIntensity
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
        _summary = summary;
        _icon = icon;
        _precipProbability = precipProbability;
        _precipIntensity = precipeIntensity;
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

@end
