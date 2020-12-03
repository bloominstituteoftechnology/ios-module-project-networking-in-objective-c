//
//  LSIWeatherForecast.m
//  DailyWeather
//
//  Created by Kenneth Jones on 12/2/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForecast.h"

@implementation LSIWeatherForecast

- (instancetype)init
{
    return [self initWithTime:NSDate.now
                      summary:@""
                         icon:@""
            precipProbability:0
              precipIntensity:0
                  temperature:0
          apparentTemperature:0
                     humidity:0
                     pressure:0
                    windSpeed:0
                  windBearing:0
                      uvIndex:0];
}

- (instancetype)initWithTime:(NSDate *)aTime
                     summary:(NSString *)aSummary
                        icon:(NSString *)aIcon
           precipProbability:(double)aPrecipProbability
             precipIntensity:(double)aPrecipIntensity
                 temperature:(double)aTemperature
         apparentTemperature:(double)aApparentTemperature
                    humidity:(double)aHumidity
                    pressure:(double)aPressure
                   windSpeed:(double)aWindSpeed
                 windBearing:(double)aWindBearing
                     uvIndex:(double)aUVIndex
{
    if (self = [super init]) {
        _time = aTime;
        _summary = aSummary.copy;
        _icon = aIcon.copy;
        _precipProbability = aPrecipProbability;
        _precipIntensity = aPrecipIntensity;
        _temperature = aTemperature;
        _apparentTemperature = aApparentTemperature;
        _humidity = aHumidity;
        _pressure = aPressure;
        _windSpeed = aWindSpeed;
        _windBearing = aWindBearing;
        _uvIndex = aUVIndex;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    NSNumber *timeInMilliseconds = [aDictionary objectForKey:@"time"];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000.];
    
    NSString *summary = [aDictionary objectForKey:@"summary"];
    if (![summary isKindOfClass:NSString.class]) return nil;
    
    NSString *icon = [aDictionary objectForKey:@"icon"];
    if (![icon isKindOfClass:NSString.class]) return nil;
    
    NSNumber *precipProbability = [aDictionary objectForKey:@"precipProbability"];
    if (![precipProbability isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *precipIntensity = [aDictionary objectForKey:@"precipIntensity"];
    if (![precipIntensity isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *temperature = [aDictionary objectForKey:@"temperature"];
    if (![temperature isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *apparentTemperature = [aDictionary objectForKey:@"apparentTemperature"];
    if (![apparentTemperature isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *humidity = [aDictionary objectForKey:@"humidity"];
    if (![humidity isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *pressure = [aDictionary objectForKey:@"pressure"];
    if (![pressure isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *windSpeed = [aDictionary objectForKey:@"windSpeed"];
    if (![windSpeed isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *windBearing = [aDictionary objectForKey:@"windBearing"];
    if (![windBearing isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *uvIndex = [aDictionary objectForKey:@"uvIndex"];
    if (![uvIndex isKindOfClass:NSNumber.class]) return nil;
    
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
                  windBearing:windBearing.doubleValue
                      uvIndex:uvIndex.doubleValue];
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *container = [[NSMutableDictionary alloc] init];
    
    [container setObject:@(self.time.timeIntervalSince1970*1000) forKey:@"time"];
    [container setObject:self.summary forKey:@"summary"];
    [container setObject:self.icon forKey:@"icon"];
    [container setObject:@(self.precipProbability) forKey:@"precipProbability"];
    [container setObject:@(self.precipIntensity) forKey:@"precipIntensity"];
    [container setObject:@(self.temperature) forKey:@"temperature"];
    [container setObject:@(self.apparentTemperature) forKey:@"apparentTemperature"];
    [container setObject:@(self.humidity) forKey:@"humidity"];
    [container setObject:@(self.pressure) forKey:@"pressure"];
    [container setObject:@(self.windSpeed) forKey:@"windSpeed"];
    [container setObject:@(self.windBearing) forKey:@"windBearing"];
    [container setObject:@(self.uvIndex) forKey:@"uvIndex"];
    
    return container;
}

@end
