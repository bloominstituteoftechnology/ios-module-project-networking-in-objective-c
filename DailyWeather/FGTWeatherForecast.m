//
//  FGTWeatherForecast.m
//  DailyWeather
//
//  Created by FGT MAC on 7/4/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import "FGTWeatherForecast.h"

@implementation FGTWeatherForecast

- (instancetype)init
{
    return [self initWithTime: NSDate.now
                      summary: @""
                         icon: @""
            precipProbability: 0
              precipIntensity: 0
                  temperature: 0
          apparentTemperature: 0
                     humidity: 0
                     pressure: 0
                    windSpeed: 0
                  windBearing: 0
                      uvIndex: 0];
}

-(instancetype)initWithTime:(NSDate *)aTime
                    summary:(NSString *)aSummary
                       icon:(NSString *)aIcon
          precipProbability:(NSNumber *)aPrecipProbability
            precipIntensity:(NSNumber *)aPrecipIntensity
                temperature:(NSNumber *)aTemperature
        apparentTemperature:(NSNumber *)aApparentTemperature
                   humidity:(NSNumber *)aHumidity
                   pressure:(NSNumber *)aPressure
                  windSpeed:(NSNumber *)aWindSpeed
                windBearing:(NSNumber *)aWindBearing
                    uvIndex:(NSNumber *)aUvIndex
{
    self = [super init];
    if(self){
        _time = aTime;
        _summary = aSummary;
        _icon = aIcon;
        _precipProbability = aPrecipProbability;
        _precipIntensity = aPrecipIntensity;
        _temperature = aTemperature;
        _apparentTemperature = aApparentTemperature;
        _humidity = aHumidity;
        _pressure = aPressure;
        _windSpeed = aWindSpeed;
        _windBearing = aWindBearing;
        _uvIndex = aUvIndex;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    return [self initWithTime: NSDate.now
                      summary: @""
                         icon: @""
            precipProbability: 0
              precipIntensity: 0
                  temperature: 0
          apparentTemperature: 0
                     humidity: 0
                     pressure: 0
                    windSpeed: 0
                  windBearing: 0
                      uvIndex: 0];
}

@end
