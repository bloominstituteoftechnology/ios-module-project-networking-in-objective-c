//
//  LSIWeatherForcast.m
//  DailyWeather
//
//  Created by Sal B Amer on 5/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForcast.h"

@implementation LSIWeatherForcast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(NSNumber *)precipProbability
              recipIntensity:(NSNumber *)precipIntensity
                 temperature:(NSNumber *)temperature
         apparentTemperature:(NSNumber *)apparentTemperature
                    humidity:(NSNumber *)humidity
                    pressure:(NSNumber *)pressure
                   windSpeed:(NSNumber *)windSpeed
                 windBearing:(NSNumber *)windBearing
                     uvIndex:(NSNumber *)uvIndex
{
  if (self = [super init]) {
    _time = time;
    _summary = summary.copy;
    _icon = icon.copy;
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
  NSNumber *timeInMillisecond = [dictionary objectForKey:@"time"];
  NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMillisecond.longValue/1000.];
  
  NSString *summary = [dictionary objectForKey:@"summary"];
  if (![summary isKindOfClass:[NSString class]]) return nil;
  
  NSString *icon = [dictionary objectForKey:@"icon"];
  if (![icon isKindOfClass:[NSString class]]) return nil;
  
  NSNumber *precipProbability = [dictionary objectForKey:@"precipProbability"];
  if (![precipProbability isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *precipIntensity = [dictionary objectForKey:@"precipIntensity"];
  if (![precipIntensity isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *temperature = [dictionary objectForKey:@"temperature"];
  if (![temperature isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *apparentTemperature = [dictionary objectForKey:@"apparentTemperature"];
  if (![apparentTemperature isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *humidity = [dictionary objectForKey:@"humidity"];
  if (![humidity isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *pressure = [dictionary objectForKey:@"pressure"];
  if (![pressure isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *windSpeed = [dictionary objectForKey:@"windSpeed"];
  if (![windSpeed isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *windBearing = [dictionary objectForKey:@"windBearing"];
  if (![windBearing isKindOfClass:[NSNumber class]]) return nil;
  
  NSNumber *uvIndex = [dictionary objectForKey:@"uvIndex"];
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

@end
