//
//  LSIWeatherForcast.m
//  DailyWeather
//
//  Created by denis cedeno on 5/29/20.
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
    
    if (self = [super init]) {
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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSDictionary *currently = [dictionary objectForKey:@"currently"];
    if (![currently isKindOfClass:[NSDictionary class]]) return nil;
    
    NSNumber *timeInMilliseconds = [currently objectForKey:@"time"];
    if (![timeInMilliseconds isKindOfClass:[NSNumber class]]) return nil;
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000.];
    
    NSString *summary = [currently objectForKey:@"summary"];
    if (![summary isKindOfClass:[NSString class]]) return nil;
    
    NSString *icon = [currently objectForKey:@"icon"];
    if (![icon isKindOfClass:[NSString class]]) return nil;
    
    NSNumber *precipProbability = [currently objectForKey:@"precipProbability"];
    if (![precipProbability isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *precipIntensity = [currently objectForKey:@"precipIntensity"];
    if (![precipIntensity isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *temperature = [currently objectForKey:@"temperature"];
    if ([temperature isKindOfClass:[NSNull class]]) {
        temperature = nil;
    } else if (![temperature isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *apparentTemperature = [currently objectForKey:@"apparentTemperature"];
    if (![apparentTemperature isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *humidity = [currently objectForKey:@"humidity"];
    if (![humidity isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *pressure = [currently objectForKey:@"pressure"];
    if (![pressure isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *windSpeed = [currently objectForKey:@"windSpeed"];
    if (![windSpeed isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *windBearing = [currently objectForKey:@"windBearing"];
    if (![windBearing isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *uvIndex = [currently objectForKey:@"uvIndex"];
    if (![uvIndex isKindOfClass:[NSNumber class]]) return nil;
    
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

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; M%@ - %@>", NSStringFromClass(self.class), self, self.temperature, self.summary];
}

@end
